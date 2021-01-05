--create login Name_admin with password = ''
--create login Name_reader with password = ''
--create login Name_user_manager with password = ''
--create login Name_backup_manager with password = ''
--go

use Afish
go

create user DB_admin for login Name_admin

create user DB_reader for login Name_reader

create user DB_user_manager for login Name_user_manager

create user DB_backup_manager for login Name_backup_manager

exec sp_addrolemember 'db_owner', 'DB_admin' 

exec sp_addrolemember 'db_denydatawriter', 'DB_reader'

exec sp_addrolemember 'db_backupoperator', 'DB_backup_manager'

exec sp_addrolemember 'db_securityadmin', 'DB_user_manager'