CREATE TABLE SfUMS_User(
	Id SERIAL primary key NOT NULL,
	UserName varchar(100) NOT NULL,
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NULL,
	DisplayName varchar(512) NULL,
	Email varchar(255) NOT NULL,
	Password varchar(255) NOT NULL,
	Contact varchar(20) NULL,
	Picture varchar(100) NOT NULL,	
	CreatedDate timestamp NOT NULL,
	ModifiedDate timestamp NULL,
	LastLogin timestamp NULL,
	PasswordChangedDate timestamp NULL,
	ActivationExpirationDate timestamp NULL,
	ActivationCode varchar(255) NOT NULL,
	ResetPasswordCode varchar(255) NULL,
	LastResetAttempt timestamp NULL,
	UserTypeId int NOT NULL DEFAULT 0,
	IsActivated smallint NOT NULL,
	IsActive smallint NOT NULL,
	IsDeleted smallint NOT NULL)
;

CREATE TABLE SfUMS_Group(
	Id SERIAL PRIMARY KEY NOT NULL,
	Name varchar(255) NOT NULL,
	Description varchar(1026) NULL,
	Color varchar(255) NOT NULL DEFAULT 'White',
	ModifiedDate timestamp NOT NULL,
	IsActive smallint NOT NULL)
;

CREATE TABLE SfUMS_UserGroup(
	Id SERIAL PRIMARY KEY NOT NULL,
	GroupId int NOT NULL,
	UserId int NOT NULL,
	ModifiedDate timestamp NOT NULL,
	IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_UserGroup  ADD FOREIGN KEY(GroupId) REFERENCES SfUMS_Group (Id)
;
ALTER TABLE SfUMS_UserGroup  ADD FOREIGN KEY(UserId) REFERENCES SfUMS_User (Id)
;

CREATE TABLE SfUMS_UserLogType(
	Id SERIAL primary key NOT NULL,
	Name varchar(100) NOT NULL,
	IsActive smallint NOT NULL)
;

CREATE TABLE SfUMS_UserLog(
	Id SERIAL primary key NOT NULL,
	UserLogTypeId int NOT NULL,	
	GroupId int NULL,
	OldValue int NULL,
	NewValue int NULL,
	UpdatedUserId int NOT NULL,
	TargetUserId int NOT NULL,
	ModifiedDate timestamp NOT NULL,
	IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_UserLog  ADD  FOREIGN KEY(UserLogTypeId) REFERENCES SfUMS_UserLogType (Id)
;
ALTER TABLE SfUMS_UserLog  ADD  FOREIGN KEY(GroupId) REFERENCES SfUMS_Group (Id)
;
ALTER TABLE SfUMS_UserLog  ADD  FOREIGN KEY(TargetUserId) REFERENCES SfUMS_User (Id)
;
ALTER TABLE SfUMS_UserLog  ADD  FOREIGN KEY(UpdatedUserId) REFERENCES SfUMS_User (Id)
;

CREATE TABLE SfUMS_UserLogin(
	Id SERIAL PRIMARY KEY NOT NULL,
	UserId int NOT NULL,
	ClientToken varchar(4000) NOT NULL,
	IpAddress varchar(50) NOT NULL,
	LoggedInTime timestamp NOT NULL,
	IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_UserLogin  ADD FOREIGN KEY(UserId) REFERENCES SfUMS_User (Id)
;

CREATE TABLE SfUMS_UserPreference(
	Id SERIAL PRIMARY KEY NOT NULL,
	UserId int NOT NULL,
	Language varchar(4000) NULL,
	TimeZone varchar(100) NULL,
	RecordSize int NULL,
	ItemSort varchar(4000) NULL,
	ItemFilters varchar(4000) NULL,
	Notifications varchar(4000) NULL,
	ModifiedDate timestamp NOT NULL,
	IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_UserPreference ADD FOREIGN KEY(UserId) REFERENCES SfUMS_User (Id)
;

CREATE TABLE SfUMS_SystemLogType(
	Id SERIAL primary key NOT NULL,
	Name varchar(100) NOT NULL,
	IsActive smallint NOT NULL)
;

CREATE TABLE SfUMS_SystemLog(
	LogId SERIAL primary key NOT NULL,
	SystemLogTypeId int NOT NULL,
	UpdatedUserId int NOT NULL,
	TargetUserId int NOT NULL,		
	ModifiedDate timestamp NOT NULL,
	IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_SystemLog  ADD FOREIGN KEY(SystemLogTypeId) REFERENCES SfUMS_SystemLogType (Id)
;
ALTER TABLE SfUMS_SystemLog  ADD FOREIGN KEY(UpdatedUserId) REFERENCES SfUMS_User (Id)
;
ALTER TABLE SfUMS_SystemLog  ADD FOREIGN KEY(TargetUserId) REFERENCES SfUMS_User (Id)
;

CREATE TABLE SfUMS_SystemSettings(
	Id SERIAL PRIMARY KEY NOT NULL,
	Key varchar(255) NOT NULL,
	Value varchar(4000) NULL,
	ModifiedDate timestamp NOT NULL,
	IsActive smallint NOT NULL,
	CONSTRAINT UK_SfUMS_SystemSettings_Key UNIQUE (Key))
;

CREATE TABLE SfUMS_ServerVersion(
Id int PRIMARY KEY NOT NULL,
VersionNumber varchar(20) NOT NULL)
;

CREATE TABLE SfUMS_ADUser(
Id SERIAL primary key NOT NULL,
UserId int NOT NULL,
ActiveDirectoryUserId uuid NOT NULL,
IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_ADUser ADD FOREIGN KEY(UserId) REFERENCES SfUMS_User (Id)
;

CREATE TABLE SfUMS_ADGroup(
Id SERIAL primary key NOT NULL,
GroupId int NOT NULL,
ActiveDirectoryGroupId uuid NOT NULL,
IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_ADGroup ADD FOREIGN KEY(GroupId) REFERENCES SfUMS_Group (Id)
;

CREATE TABLE SfUMS_ADCredential(
Id SERIAL primary key NOT NULL,
Username varchar(100),
Password varchar(100),
LdapUrl varchar(255),
EnableSsl smallint NOT NULL,
DistinguishedName varchar(150),
PortNo int NOT NULL,
IsActive smallint NOT NULL)
;

CREATE TABLE SfUMS_AzureADCredential(
Id SERIAL primary key NOT NULL,
TenantName varchar(255),
ClientId varchar(100),
ClientSecret varchar(100),
IsActive smallint NOT NULL)
;

CREATE TABLE SfUMS_AzureADUser(
Id SERIAL primary key NOT NULL,
UserId int NOT NULL,
AzureADUserId uuid NOT NULL,
IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_AzureADUser ADD FOREIGN KEY(UserId) REFERENCES SfUMS_User (Id)
;

CREATE TABLE SfUMS_AzureADGroup(
Id SERIAL primary key NOT NULL,
GroupId int NOT NULL,
AzureADGroupId uuid NOT NULL,
IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_AzureADGroup ADD FOREIGN KEY(GroupId) REFERENCES SfUMS_Group (Id)
;

CREATE TABLE SfUMS_RecurrenceType(
	Id SERIAL PRIMARY KEY NOT NULL,
	Name varchar(30) NOT NULL,
	IsActive smallint NOT NULL)
;

CREATE TABLE SfUMS_SAMLSettings(
	Id SERIAL primary key NOT NULL, 
	MetadataURI varchar(4000),
	Authority varchar(4000),
	DesignerClientId varchar(100),
	TenantName varchar(100), 
	IsEnabled smallint NOT NULL)
;

CREATE TABLE SfUMS_UserType(
	Id SERIAL primary key NOT NULL, 
	Type varchar(100))
;

INSERT into SfUMS_SystemLogType (Name,IsActive) VALUES (N'Updated',1)
;

INSERT into SfUMS_UserLogType (Name,IsActive) VALUES ( N'Added',1)
;
INSERT into SfUMS_UserLogType (Name,IsActive) VALUES ( N'Updated',1)
;
INSERT into SfUMS_UserLogType (Name,IsActive) VALUES ( N'Deleted',1)
;
INSERT into SfUMS_UserLogType (Name,IsActive) VALUES ( N'Changed',1)
;

INSERT into SfUMS_RecurrenceType (Name,IsActive) VALUES (N'Daily', 1)
;
INSERT into SfUMS_RecurrenceType (Name,IsActive) VALUES (N'DailyWeekDay', 1)
;
INSERT into SfUMS_RecurrenceType (Name,IsActive) VALUES (N'Weekly', 1)
;
INSERT into SfUMS_RecurrenceType (Name,IsActive) VALUES (N'Monthly', 1)
;
INSERT into SfUMS_RecurrenceType (Name,IsActive) VALUES (N'MonthlyDOW', 1)
;
INSERT into SfUMS_RecurrenceType (Name,IsActive) VALUES (N'Yearly', 1)
;
INSERT into SfUMS_RecurrenceType (Name,IsActive) VALUES (N'YearlyDOW', 1)
;
INSERT into SfUMS_RecurrenceType (Name,IsActive) VALUES (N'Time', 1)
;
INSERT into SfUMS_RecurrenceType (Name,IsActive) VALUES (N'Hourly', 1)
;

INSERT into SfUMS_Group (Name,Description,Color,ModifiedDate,IsActive) VALUES (N'System Administrator','Has administrative rights for the UMS','#ff0000',current_timestamp(0), 1)
;

INSERT into SfUMS_UserType(Type) values(N'Server User')
;
INSERT into SfUMS_UserType(Type) values(N'Active Directory User')
;
INSERT into SfUMS_UserType(Type) values(N'Federation User')
;

CREATE TABLE SfUMS_ApplicationType(
	Id int primary key NOT NULL, 
	Type varchar(255) NOT NULL)
;
ALTER TABLE SfUMS_ApplicationType ADD UNIQUE (Type)
;

INSERT into SfUMS_ApplicationType(Type,Id) values(N'Data Integration Platform',1)
;
INSERT into SfUMS_ApplicationType(Type,Id) values(N'Others',10000)
;

CREATE TABLE SfUMS_Applications(
Id SERIAL primary key NOT NULL,
Name varchar(255) NOT NULL,
Url varchar(255) NOT NULL,
ClientId varchar(100) NOT NULL,
HasAccessToAllUsers smallint NOT NULL,
ApplicationTypeId int NOT NULL,
Icon varchar(100) NOT NULL,
CreatedById int NOT NULL,
ModifiedById int NOT NULL,
CreatedDate timestamp NOT NULL,
ModifiedDate timestamp NOT NULL,
ClientSecret varchar(255) NOT NULL,
IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_Applications  ADD FOREIGN KEY(CreatedById) REFERENCES SfUMS_User (Id)
;

ALTER TABLE SfUMS_Applications  ADD FOREIGN KEY(ModifiedById) REFERENCES SfUMS_User (Id)
;

ALTER TABLE SfUMS_Applications  ADD FOREIGN KEY(ApplicationTypeId) REFERENCES SfUMS_ApplicationType (Id)
;

CREATE TABLE SfUMS_AppAccessToGroups(
Id SERIAL primary key NOT NULL,
ApplicationId int NOT NULL,
GroupId int NOT NULL,
CreatedById int NOT NULL,
ModifiedById int NOT NULL,
CreatedDate timestamp NOT NULL,
ModifiedDate timestamp NOT NULL,
IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_AppAccessToGroups  ADD FOREIGN KEY(ApplicationId) REFERENCES SfUMS_Applications (Id)
;

ALTER TABLE SfUMS_AppAccessToGroups  ADD FOREIGN KEY(GroupId) REFERENCES SfUMS_Group (Id)
;

ALTER TABLE SfUMS_AppAccessToGroups  ADD FOREIGN KEY(CreatedById) REFERENCES SfUMS_User (Id)
;

ALTER TABLE SfUMS_AppAccessToGroups  ADD FOREIGN KEY(ModifiedById) REFERENCES SfUMS_User (Id)
;

CREATE TABLE SfUMS_AppAccessToUsers(
Id SERIAL primary key NOT NULL,
ApplicationId int NOT NULL,
UserId int NOT NULL,
CreatedById int NOT NULL,
ModifiedById int NOT NULL,
CreatedDate timestamp NOT NULL,
ModifiedDate timestamp NOT NULL,
IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_AppAccessToUsers  ADD FOREIGN KEY(ApplicationId) REFERENCES SfUMS_Applications (Id)
;

ALTER TABLE SfUMS_AppAccessToUsers  ADD FOREIGN KEY(UserId) REFERENCES SfUMS_User (Id)
;

ALTER TABLE SfUMS_AppAccessToUsers  ADD FOREIGN KEY(CreatedById) REFERENCES SfUMS_User (Id)
;

ALTER TABLE SfUMS_AppAccessToUsers  ADD FOREIGN KEY(ModifiedById) REFERENCES SfUMS_User (Id)

;

CREATE TABLE SfUMS_AppAdmin(
	Id SERIAL PRIMARY KEY NOT NULL,
	ApplicationId int NOT NULL,
	UserId int NOT NULL,
	CreatedById int NOT NULL,
	CreatedDate timestamp NOT NULL,
	IsActive smallint NOT NULL)
;

ALTER TABLE SfUMS_AppAdmin  ADD FOREIGN KEY(ApplicationId) REFERENCES SfUMS_Applications (Id)
;
ALTER TABLE SfUMS_AppAdmin  ADD FOREIGN KEY(UserId) REFERENCES SfUMS_User (Id)
;
ALTER TABLE SfUMS_AppAdmin  ADD FOREIGN KEY(CreatedById) REFERENCES SfUMS_User (Id)
;

CREATE TABLE SfUMS_DBCredential(
    Id SERIAL primary key NOT NULL,
    DatabaseType varchar(255) NOT NULL,
    ConnectionString varchar(4000) NOT NULL,
    Status varchar(255) NOT NULL,
    ActiveStatusValue varchar(255) NOT NULL,
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
    IsActive smallint NOT NULL)
;


CREATE TABLE SfUMS_TableRelation(
    Id SERIAL primary key NOT NULL,
    LeftTable varchar(255) NOT NULL,
    LeftTableColumnName varchar(255) NOT NULL,	
    LeftTableCondition  varchar(255) NOT NULL,
    LeftTableName  varchar(255) NOT NULL,
    LeftTableSchema varchar(255) NOT NULL,
    Relationship varchar(255) NOT NULL,
    RightTable varchar(255) NOT NULL,
    RightTableColumnName varchar(255) NOT NULL,	
    RightTableCondition  varchar(255) NOT NULL,
    RightTableName  varchar(255) NOT NULL,
    RightTableSchema varchar(255) NOT NULL)
;