create procedure retrieve
	@DatabaseName sysname=null
as
begin
	set nocount on;


	declare @sql nvarchar(max)='';


	if @DatabaseName is not null
	begin 
		
		if exists( select 1 from sys.databases where name=@DatabaseName and name not in	('master','tempdb','model','msdb'))
		begin
			set @sql='
            USE [' + @DatabaseName + '];
            SELECT 
                DB_NAME() AS database_name,
                s.name AS schema_name,
                o.name AS object_name,
                o.type_desc AS object_type,
                p.name AS parameter_name,
                t.name AS data_type,
                p.max_length,
                p.is_output
            FROM sys.objects o
            JOIN sys.schemas s ON o.schema_id = s.schema_id
            LEFT JOIN sys.parameters p ON o.object_id = p.object_id
            LEFT JOIN sys.types t ON p.user_type_id = t.user_type_id
            WHERE o.type IN (''P'', ''FN'', ''TF'', ''IF'')
            ORDER BY s.name, o.name, p.parameter_id;
            ';
        END
        ELSE
        BEGIN
            RAISERROR('Invalid or system database name.', 16, 1);
            RETURN;
        END
    END
    ELSE
    BEGIN
        -- Loop over all user databases
        SELECT @sql += '
        USE [' + name + '];
        SELECT 
            DB_NAME() AS database_name,
            s.name AS schema_name,
            o.name AS object_name,
            o.type_desc AS object_type,
            p.name AS parameter_name,
            t.name AS data_type,
            p.max_length,
            p.is_output
        FROM sys.objects o
        JOIN sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN sys.parameters p ON o.object_id = p.object_id
        LEFT JOIN sys.types t ON p.user_type_id = t.user_type_id
        WHERE o.type IN (''P'', ''FN'', ''TF'', ''IF'')
        ORDER BY s.name, o.name, p.parameter_id;
        '
        FROM sys.databases
        WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb');
    END

    EXEC sp_executesql @sql;
END;

EXec retrieve @DatabaseName = 'Employees';
