--Task1.
select 
	TABLE_CATALOG as DatabaseName,
	TABLE_SCHEMA as SchemaName,
	TABLE_NAME as TableName,
	COLUMN_NAME as ColumnName,
	concat(
		DATA_TYPE,'('+ 
			case when cast(CHARACTER_MAXIMUM_LENGTH as varchar) = '-1'
			then 'max'
			else cast(CHARACTER_MAXIMUM_LENGTH as varchar) end
		+')'
	) as DataType
from class10.INFORMATION_SCHEMA.COLUMNS;

declare @DatabaseName nvarchar(255);
declare @name varchar(255);
declare @i int = 1;
declare @count int;
select @count = count(1)
from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb');


while @i < @count
begin
	;with cte as (
		select name, ROW_NUMBER() OVER(order BY name) as rn
		from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')
	)
	select @name=name from cte
	where rn = @i;

	declare @sql_query nvarchar(max)='select 
		TABLE_CATALOG as DatabaseName,
		TABLE_SCHEMA as SchemaName,
		TABLE_NAME as TableName,
		COLUMN_NAME as ColumnName,
		concat(
			DATA_TYPE,(+ case when cast(CHARACTER_MAXIMUM_LENGTH as varchar) = -1
				then max
				else cast(CHARACTER_MAXIMUM_LENGTH as varchar) end
			+)
		) as DataType
	from'+QUOTENAME(@DatabaseName)+ '.INFORMATION_SCHEMA.COLUMNS;';


	set @i = @i + 1;

end

--Task2.
CREATE PROCEDURE GetStoredProceduresAndFunctions @DbName NVARCHAR(255) = NULL
AS
BEGIN
    SELECT
        OBJECT_NAME(OBJECT_ID(s.name + '.' + o.name)) AS ObjectName,
        s.name AS SchemaName,
        o.name AS ObjectName,
        p.name AS ParameterName,
        TYPE_NAME(p.user_type_id) AS DataType,
        p.max_length AS MaxLength
    FROM sys.objects o
    JOIN sys.schemas s ON o.schema_id = s.schema_id
    LEFT JOIN sys.parameters p ON o.object_id = p.object_id
    WHERE o.is_ms_shipped = 0
        AND (@DbName IS NULL OR DB_NAME() = @DbName)
        AND o.type IN ('P', 'FN', 'IF', 'TF')  -- Procedures and Functions
    ORDER BY s.name, o.name, p.parameter_id;  -- Order by schema, object, and parameter id
END