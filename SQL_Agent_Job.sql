-- Make use of SQL agent job to perform a full, differential, and log backup on a schedule

Full Backup Job:

-- SQL Server Agent > Jobs > New Job.
-- Full_Backup_SHA.

-- Full_Backup_Step
-- Type: "Transact-SQL Script (T-SQL)".
-- T-script

EXECUTE dbo.DatabaseBackup
    @Databases = 'SmartHomeAutomation',
    @Directory = 'C:\Program Files\Microsoft SQL Server\MSSQL16.GINSENG\MSSQL\Backup',  
    @BackupType = 'FULL', 
    @Verify = 'Y',
    @CleanupTime = 24, 
    @CheckSum = 'Y',
    @LogToTable = 'Y'

-- Schedules 
-- Occurs every week on Monday at 1:00 AM

Differential Backup
-- Name: Differential_Backup_SHA


-- Steps:
-- Name: Differenetial_Backup_SHA
-- T-Script:
EXECUTE dbo.DatabaseBackup
    @Databases = 'SmartHomeAutomation',
    @Directory = 'C:\Program Files\Microsoft SQL Server\MSSQL16.GINSENG\MSSQL\Backup', 
    @BackupType = 'DIFF',
    @Verify = 'Y',
    @CleanupTime = 24, 
    @CheckSum = 'Y',
    @LogToTable = 'Y'

-- Schedule:
-- Name: Differential_Backup_SHA
-- Occurs every week on Sunday at 9:00 P.M


Log Backup
-- Name:Log_Backup_SHA

-- Step:
-- Name:Log_Backup_SHA
EXECUTE dbo.DatabaseBackup
   @Databases = 'SmartHomeAutomation',
   @Directory = 'C:\Program Files\Microsoft SQL Server\MSSQL16.GINSENG\MSSQL\Backup', 
   @BackupType = 'LOG',
   @Verify = 'Y',
   @CleanupTime = 24, 
   @CheckSum = 'Y',
   @LogToTable = 'Y'

-- Schedule:
-- Name: Log_Backup_SHA_Schedule
-- Occurs every day at 12:00 A.M