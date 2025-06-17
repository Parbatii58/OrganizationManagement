USE OrganizationInfo
GO

-- For backup

BACKUP DATABASE OrganizationInfo
TO DISK = 'C:\BACKUP_SSMS\OrganizationInfo.bak'
WITH FORMAT,
	 MEDIANAME = 'OrganizationManagement_Backup_Drive',
	 NAME = 'Full Backup of OrganizationInfo Database- June 17, 2025'

-- For recovery
RESTORE DATABASE OrganizationInfo
FROM DISK = 'C:\BACKUP_SSMS\OrganizationInfo.bak'