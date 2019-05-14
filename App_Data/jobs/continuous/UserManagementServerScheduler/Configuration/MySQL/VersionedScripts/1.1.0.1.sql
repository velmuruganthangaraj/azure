CREATE TABLE {database_name}.SfUMS_User(
	Id int NOT NULL AUTO_INCREMENT,
	UserName varchar(100) NOT NULL,
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NULL,
	DisplayName varchar(512) NULL,
	Email varchar(255) NOT NULL,
	Password varchar(255) NOT NULL,
	Contact varchar(20) NULL,
	Picture varchar(100) NOT NULL,	
	CreatedDate datetime NOT NULL,
	ModifiedDate datetime NULL,
	LastLogin datetime NULL,
	PasswordChangedDate datetime NULL,
	ActivationExpirationDate datetime NULL,
	ActivationCode varchar(255) NOT NULL,
	ResetPasswordCode varchar(255) NULL,
	LastResetAttempt datetime NULL,
	UserTypeId int NOT NULL DEFAULT 0,
	IsActivated tinyint(1) NOT NULL,
	IsActive tinyint(1) NOT NULL,
	IsDeleted tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

CREATE TABLE {database_name}.SfUMS_Group(
	Id int NOT NULL AUTO_INCREMENT,
	Name varchar(255) NOT NULL,
	Description varchar(1026) NULL,
	Color varchar(255) NOT NULL DEFAULT 'White',
	ModifiedDate datetime NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

CREATE TABLE {database_name}.SfUMS_UserGroup(
	Id int NOT NULL AUTO_INCREMENT,
	GroupId int NOT NULL,
	UserId int NOT NULL,
	ModifiedDate datetime NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_UserGroup  ADD FOREIGN KEY(GroupId) REFERENCES {database_name}.SfUMS_Group (Id)
;
ALTER TABLE {database_name}.SfUMS_UserGroup  ADD FOREIGN KEY(UserId) REFERENCES {database_name}.SfUMS_User (Id)
;

CREATE TABLE {database_name}.SfUMS_UserLogType(
	Id int NOT NULL AUTO_INCREMENT,
	Name varchar(100) NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

CREATE TABLE {database_name}.SfUMS_UserLog(
	Id int NOT NULL AUTO_INCREMENT,
	UserLogTypeId int NOT NULL,	
	GroupId int NULL,
	OldValue int NULL,
	NewValue int NULL,
	UpdatedUserId int NOT NULL,
	TargetUserId int NOT NULL,
	ModifiedDate datetime NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_UserLog  ADD  FOREIGN KEY(UserLogTypeId) REFERENCES {database_name}.SfUMS_UserLogType (Id)
;
ALTER TABLE {database_name}.SfUMS_UserLog  ADD  FOREIGN KEY(GroupId) REFERENCES {database_name}.SfUMS_Group (Id)
;
ALTER TABLE {database_name}.SfUMS_UserLog  ADD  FOREIGN KEY(TargetUserId) REFERENCES {database_name}.SfUMS_User (Id)
;
ALTER TABLE {database_name}.SfUMS_UserLog  ADD  FOREIGN KEY(UpdatedUserId) REFERENCES {database_name}.SfUMS_User (Id)
;

CREATE TABLE {database_name}.SfUMS_UserLogin(
	Id int NOT NULL AUTO_INCREMENT,
	UserId int NOT NULL,
	ClientToken varchar(4000) NOT NULL,
	IpAddress varchar(50) NOT NULL,
	LoggedInTime datetime NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_UserLogin  ADD FOREIGN KEY(UserId) REFERENCES {database_name}.SfUMS_User (Id)
;

CREATE TABLE {database_name}.SfUMS_UserPreference(
	Id int NOT NULL AUTO_INCREMENT,
	UserId int NOT NULL,
	Language varchar(4000) NULL,
	TimeZone varchar(100) NULL,
	RecordSize int NULL,
	ItemSort varchar(4000) NULL,
	ItemFilters varchar(4000) NULL,
	Notifications varchar(4000) NULL,
	ModifiedDate datetime NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_UserPreference ADD FOREIGN KEY(UserId) REFERENCES {database_name}.SfUMS_User (Id)
;

CREATE TABLE {database_name}.SfUMS_SystemLogType(
	Id int NOT NULL AUTO_INCREMENT,
	Name varchar(100) NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

CREATE TABLE {database_name}.SfUMS_SystemLog(
	LogId int NOT NULL AUTO_INCREMENT,
	SystemLogTypeId int NOT NULL,
	UpdatedUserId int NOT NULL,
	TargetUserId int NOT NULL,		
	ModifiedDate datetime NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (LogId))
;

ALTER TABLE {database_name}.SfUMS_SystemLog  ADD FOREIGN KEY(SystemLogTypeId) REFERENCES {database_name}.SfUMS_SystemLogType (Id)
;
ALTER TABLE {database_name}.SfUMS_SystemLog  ADD FOREIGN KEY(UpdatedUserId) REFERENCES {database_name}.SfUMS_User (Id)
;
ALTER TABLE {database_name}.SfUMS_SystemLog  ADD FOREIGN KEY(TargetUserId) REFERENCES {database_name}.SfUMS_User (Id)
;

CREATE TABLE {database_name}.SfUMS_SystemSettings(
	Id int NOT NULL AUTO_INCREMENT,
	SfUMS_SystemSettings.Key varchar(255) NOT NULL,
	Value varchar(4000) NULL,
	ModifiedDate datetime NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT UK_SfUMS_SystemSettings_Key UNIQUE(`Key`))
;

CREATE TABLE {database_name}.SfUMS_ServerVersion(
Id int NOT NULL,
VersionNumber varchar(20) NOT NULL,
	PRIMARY KEY (Id))
;

CREATE TABLE {database_name}.SfUMS_ADUser(
Id int NOT NULL AUTO_INCREMENT,
UserId int not null,
ActiveDirectoryUserId char(38) not null,
IsActive tinyint(1) not null,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_ADUser ADD FOREIGN KEY(UserId) REFERENCES {database_name}.SfUMS_User (Id)
;

CREATE TABLE {database_name}.SfUMS_ADGroup(
Id int NOT NULL AUTO_INCREMENT,
GroupId int not null,
ActiveDirectoryGroupId char(38) not null,
IsActive tinyint(1) not null,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_ADGroup ADD FOREIGN KEY(GroupId) REFERENCES {database_name}.SfUMS_Group (Id)
;

CREATE TABLE {database_name}.SfUMS_ADCredential(
Id int NOT NULL AUTO_INCREMENT,
Username varchar(100),
Password varchar(100),
LdapUrl varchar(255),
EnableSsl tinyint(1) not null,
DistinguishedName varchar(150),
PortNo int not null,
IsActive tinyint(1) not null,
	PRIMARY KEY (Id))
;




CREATE TABLE {database_name}.SfUMS_AzureADCredential(
	Id int NOT NULL AUTO_INCREMENT,
	TenantName varchar(255),
	ClientId varchar(100),
	ClientSecret varchar(100),
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

CREATE TABLE {database_name}.SfUMS_AzureADUser(
	Id int NOT NULL AUTO_INCREMENT,
	UserId int NOT NULL,
	AzureADUserId char(38) NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_AzureADUser ADD FOREIGN KEY(UserId) REFERENCES {database_name}.SfUMS_User (Id)
;

CREATE TABLE {database_name}.SfUMS_AzureADGroup(
	Id int NOT NULL AUTO_INCREMENT,
	GroupId int NOT NULL,
	AzureADGroupId char(38) NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_AzureADGroup ADD FOREIGN KEY(GroupId) REFERENCES {database_name}.SfUMS_Group (Id)
;

CREATE TABLE {database_name}.SfUMS_RecurrenceType(
	Id int NOT NULL AUTO_INCREMENT,
	Name varchar(30) NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

CREATE TABLE {database_name}.SfUMS_SAMLSettings(
	Id int NOT NULL AUTO_INCREMENT, 
	MetadataURI varchar(4000), 
	Authority varchar(4000),
	DesignerClientId varchar(100),
	TenantName varchar(100),
	IsEnabled tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

CREATE TABLE {database_name}.SfUMS_UserType(
	Id int NOT NULL AUTO_INCREMENT,
	Type varchar(100),
	PRIMARY KEY (Id))
;

INSERT into {database_name}.SfUMS_SystemLogType (Name,IsActive) VALUES ('Updated',1)
;

INSERT into {database_name}.SfUMS_UserLogType (Name,IsActive) VALUES ( 'Added',1)
;
INSERT into {database_name}.SfUMS_UserLogType (Name,IsActive) VALUES ( 'Updated',1)
;
INSERT into {database_name}.SfUMS_UserLogType (Name,IsActive) VALUES ( 'Deleted',1)
;
INSERT into {database_name}.SfUMS_UserLogType (Name,IsActive) VALUES ( 'Changed',1)
;

INSERT into {database_name}.SfUMS_RecurrenceType (Name,IsActive) VALUES ('Daily', 1)
;
INSERT into {database_name}.SfUMS_RecurrenceType (Name,IsActive) VALUES ('DailyWeekDay', 1)
;
INSERT into {database_name}.SfUMS_RecurrenceType (Name,IsActive) VALUES ('Weekly', 1)
;
INSERT into {database_name}.SfUMS_RecurrenceType (Name,IsActive) VALUES ('Monthly', 1)
;
INSERT into {database_name}.SfUMS_RecurrenceType (Name,IsActive) VALUES ('MonthlyDOW', 1)
;
INSERT into {database_name}.SfUMS_RecurrenceType (Name,IsActive) VALUES ('Yearly', 1)
;
INSERT into {database_name}.SfUMS_RecurrenceType (Name,IsActive) VALUES ('YearlyDOW', 1)
;
INSERT into {database_name}.SfUMS_RecurrenceType (Name,IsActive) VALUES ('Time', 1)
;
INSERT into {database_name}.SfUMS_RecurrenceType (Name,IsActive) VALUES ('Hourly',1)
;

INSERT into {database_name}.SfUMS_Group (Name,Description,Color,ModifiedDate,IsActive) VALUES ('System Administrator','Has administrative rights for the UMS','#ff0000',UTC_TIMESTAMP(), 1)
;

INSERT into {database_name}.SfUMS_UserType(Type) values('Server User')
;
INSERT into {database_name}.SfUMS_UserType(Type) values('Active Directory User')
;
INSERT into {database_name}.SfUMS_UserType(Type) values('Federation User')
;

CREATE TABLE {database_name}.SfUMS_ApplicationType(
	Id int NOT NULL, 
	Type varchar(255) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_ApplicationType ADD CONSTRAINT UNIQUE (Type)
;

INSERT into {database_name}.SfUMS_ApplicationType(Type,Id) values('Data Integration Platform',1)
;
INSERT into {database_name}.SfUMS_ApplicationType(Type,Id) values('Others',10000)
;

CREATE TABLE {database_name}.SfUMS_Applications(
Id int NOT NULL AUTO_INCREMENT,
Name varchar(255) NOT NULL,
Url varchar(255) NOT NULL,
ClientId varchar(100) NOT NULL,
HasAccessToAllUsers tinyint(1) NOT NULL,
ApplicationTypeId int NOT NULL,
Icon varchar(100) NOT NULL,
CreatedById int NOT NULL,
ModifiedById int NOT NULL,
CreatedDate datetime NOT NULL,
ModifiedDate datetime NOT NULL,
ClientSecret varchar(255) NOT NULL,
IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_Applications  ADD FOREIGN KEY(CreatedById) REFERENCES {database_name}.SfUMS_User (Id)
;

ALTER TABLE {database_name}.SfUMS_Applications  ADD FOREIGN KEY(ModifiedById) REFERENCES {database_name}.SfUMS_User (Id)
;

ALTER TABLE {database_name}.SfUMS_Applications  ADD FOREIGN KEY(ApplicationTypeId) REFERENCES {database_name}.SfUMS_ApplicationType (Id)
;

CREATE TABLE {database_name}.SfUMS_AppAccessToGroups(
Id int NOT NULL AUTO_INCREMENT,
ApplicationId int NOT NULL,
GroupId int NOT NULL,
CreatedById int NOT NULL,
ModifiedById int NOT NULL,
CreatedDate datetime NOT NULL,
ModifiedDate datetime NOT NULL,
IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_AppAccessToGroups  ADD FOREIGN KEY(ApplicationId) REFERENCES {database_name}.SfUMS_Applications (Id)
;

ALTER TABLE {database_name}.SfUMS_AppAccessToGroups  ADD FOREIGN KEY(GroupId) REFERENCES {database_name}.SfUMS_Group (Id)
;

ALTER TABLE {database_name}.SfUMS_AppAccessToGroups  ADD FOREIGN KEY(CreatedById) REFERENCES {database_name}.SfUMS_User (Id)
;

ALTER TABLE {database_name}.SfUMS_AppAccessToGroups  ADD FOREIGN KEY(ModifiedById) REFERENCES {database_name}.SfUMS_User (Id)
;

CREATE TABLE {database_name}.SfUMS_AppAccessToUsers(
Id int NOT NULL AUTO_INCREMENT,
ApplicationId int NOT NULL,
UserId int NOT NULL,
CreatedById int NOT NULL,
ModifiedById int NOT NULL,
CreatedDate datetime NOT NULL,
ModifiedDate datetime NOT NULL,
IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_AppAccessToUsers  ADD FOREIGN KEY(ApplicationId) REFERENCES {database_name}.SfUMS_Applications (Id)
;

ALTER TABLE {database_name}.SfUMS_AppAccessToUsers  ADD FOREIGN KEY(UserId) REFERENCES {database_name}.SfUMS_User (Id)
;

ALTER TABLE {database_name}.SfUMS_AppAccessToUsers  ADD FOREIGN KEY(CreatedById) REFERENCES {database_name}.SfUMS_User (Id)
;

ALTER TABLE {database_name}.SfUMS_AppAccessToUsers  ADD FOREIGN KEY(ModifiedById) REFERENCES {database_name}.SfUMS_User (Id)

;

CREATE TABLE {database_name}.SfUMS_AppAdmin(
	Id int NOT NULL AUTO_INCREMENT,
	ApplicationId int NOT NULL,
	UserId int NOT NULL,
	CreatedById int NOT NULL,
	CreatedDate datetime NOT NULL,
	IsActive tinyint(1) NOT NULL,
	PRIMARY KEY (Id))
;

ALTER TABLE {database_name}.SfUMS_AppAdmin  ADD FOREIGN KEY(ApplicationId) REFERENCES {database_name}.SfUMS_Applications (Id)
;
ALTER TABLE {database_name}.SfUMS_AppAdmin  ADD FOREIGN KEY(UserId) REFERENCES {database_name}.SfUMS_User (Id)
;
ALTER TABLE {database_name}.SfUMS_AppAdmin  ADD FOREIGN KEY(CreatedById) REFERENCES {database_name}.SfUMS_User (Id)
;

CREATE TABLE {database_name}.SfUMS_DBCredential(
    Id int NOT NULL AUTO_INCREMENT,
    DatabaseType varchar(255) NOT NULL,
    ConnectionString varchar(4000) NOT NULL,
    Status  varchar(255) NOT NULL,
    ActiveStatusValue  varchar(255) NOT NULL,
    IsActive tinyint(1) NOT NULL,
    UserNameSchema varchar(255) NOT NULL,
    UserNameTable varchar(255) NOT NULL,
    UserNameColumn varchar(255) NOT NULL,
    FirstNameSchema varchar(255) NOT NULL,
    FirstNameTable varchar(255) NOT NULL,
    FirstNameColumn varchar(255) NOT NULL,
    LastNameSchema varchar(255) NOT NULL,
    LastNameTable varchar(255) NOT NULL,
    LastNameColumn varchar(255) NOT NULL,
    EmailSchema varchar(255) NOT NULL,
    EmailTable varchar(255) NOT NULL,
    EmailColumn varchar(255) NOT NULL,
    IsActiveSchema varchar(255) NOT NULL,
    IsActiveTable varchar(255) NOT NULL,
    IsActiveColumn varchar(255) NOT NULL,
    EmailRelationId int NULL,
    FirstNameRelationId int NULL,
    IsActiveRelationId int NULL,
    LastNameRelationId int NULL,
    PRIMARY KEY (Id))
;
CREATE TABLE {database_name}.SfUMS_TableRelation(
   Id int NOT NULL AUTO_INCREMENT,
   LeftTable varchar(255) NOT NULL,
   LeftTableColumnName varchar(255) NOT NULL,	
   LeftTableCondition varchar(255) NOT NULL,
   LeftTableName varchar(255) NOT NULL,
   LeftTableSchema varchar(255) NOT NULL,
   Relationship varchar(255) NOT NULL,
   RightTable varchar(255) NOT NULL,
   RightTableColumnName varchar(255) NOT NULL,	
   RightTableCondition varchar(255) NOT NULL,
   RightTableName varchar(255) NOT NULL,
   RightTableSchema varchar(255) NOT NULL,
   PRIMARY KEY (Id))
;