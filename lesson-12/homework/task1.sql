declare @sql nvarchar(max);

set @sql='';

select @sql+='
use['+name+'];
select
	db_name() as data_base_name,
	s.name as schema_name,
	t.name as table_name,
	c.name as column_name,
	ty.name as data_type
from sys.tables t
join sys.schemas s on s.schema_id=t.schema_id
join sys.columns c on c.object_id=t.object_id
join sys.types as ty on ty.user_type_id=c.user_type_id
where t.is_ms_shipped=0;
'
from sys.databases
where name not in ('master','tempdb','model','msdb');

exec sp_executesql @sql;

