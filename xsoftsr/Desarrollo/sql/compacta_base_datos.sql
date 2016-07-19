USE valle
CHECKPOINT
EXEC sp_addumpdevice 'disk', 'CopiaMiBase', 'c:\LogMiBase.bak'
BACKUP DATABASE valle TO CopiaMiBase
BACKUP LOG valle WITH TRUNCATE_ONLY
DBCC SHRINKFILE (valle_Log, 100)
		