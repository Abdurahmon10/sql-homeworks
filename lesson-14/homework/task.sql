SELECT name 
FROM msdb.dbo.sysmail_profile;

-- Step 1: Prepare the index metadata
DECLARE @IndexMetadata TABLE (
    TableName NVARCHAR(256),
    IndexName NVARCHAR(256),
    IndexType NVARCHAR(60),
    ColumnType NVARCHAR(128)
);

INSERT INTO @IndexMetadata
SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    ty.name AS ColumnType
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.tables t ON i.object_id = t.object_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE i.is_hypothetical = 0
ORDER BY t.name, i.name;

-- Step 2: Build the HTML email body
DECLARE @Body NVARCHAR(MAX) = '';

SET @Body = 
N'<html>
<head>
<style>
    table { border-collapse: collapse; width: 100%; font-family: Arial, sans-serif; }
    th, td { border: 1px solid #ddd; padding: 8px; }
    th { background-color: #f2f2f2; }
</style>
</head>
<body>
<h3>SQL Server Index Metadata Report</h3>
<table>
<tr>
    <th>Table Name</th>
    <th>Index Name</th>
    <th>Index Type</th>
    <th>Column Type</th>
</tr>'

-- Add each row
SELECT @Body += 
    '<tr>
        <td>' + ISNULL(TableName, '') + '</td>
        <td>' + ISNULL(IndexName, '') + '</td>
        <td>' + ISNULL(IndexType, '') + '</td>
        <td>' + ISNULL(ColumnType, '') + '</td>
    </tr>'
FROM @IndexMetadata;

-- Close HTML tags
SET @Body += '</table></body></html>';

select @Body
-- Step 3: Send the email
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'YourDatabaseMailProfile',  -- 
    @recipients = 'amuhammadjanov1010@gmail.com',      -- 🔁 Replace with actual recipient
    @subject = 'SQL Server Index Metadata Report',
    @body = @Body,
    @body_format = 'HTML';
