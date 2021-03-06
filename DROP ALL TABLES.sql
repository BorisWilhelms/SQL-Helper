DECLARE @TableCount INT
SELECT @TableCount = COUNT(*) FROM sys.tables

WHILE @TableCount > 0
BEGIN
	DECLARE table_cursor CURSOR
		FOR SELECT Name FROM sys.tables

	DECLARE @TableName VARCHAR(255)
	OPEN table_cursor
	FETCH NEXT FROM table_cursor
		INTO @TableName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC('DROP TABLE dbo.' + @TableName)

		FETCH NEXT FROM table_cursor
			INTO @TableName
	END

	CLOSE table_cursor;  
	DEALLOCATE table_cursor;  

	SELECT @TableCount = COUNT(*) FROM sys.tables
END