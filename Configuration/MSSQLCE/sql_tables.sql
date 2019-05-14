CREATE TABLE [SfUMS_User](
	[Id] [int] IDENTITY(1,1) primary key NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[FirstName] [nvarchar](255) NOT NULL,
	[LastName] [nvarchar](255) NULL,
	[DisplayName] [nvarchar](512) NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Contact] [nvarchar](64) NULL,
	[Picture] [nvarchar](100) NOT NULL,	
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[LastLogin] [datetime] NULL,
	[PasswordChangedDate] [datetime] NULL,
	[ActivationExpirationDate] [datetime] NULL,
	[ActivationCode] [nvarchar](255) NOT NULL,
	[ResetPasswordCode] [nvarchar](255) NULL,
	[LastResetAttempt] [datetime] NULL,
	[UserTypeId] [int] NOT NULL DEFAULT 0,
	[IsActivated] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DomainId] [nvarchar](4000) NULL)
;

CREATE TABLE [SfUMS_Group](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1026) NULL,
	[Color] [nvarchar](255) NOT NULL DEFAULT 'White',
	[ModifiedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DomainId] [nvarchar](4000) NULL)
;

CREATE TABLE [SfUMS_UserGroup](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[GroupId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_UserGroup]  ADD FOREIGN KEY([GroupId]) REFERENCES [SfUMS_Group] ([Id])
;
ALTER TABLE [SfUMS_UserGroup]  ADD FOREIGN KEY([UserId]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_UserLogType](
	[Id] [int] IDENTITY(1,1) primary key NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL)
;

CREATE TABLE [SfUMS_UserLog](
	[Id] [int] IDENTITY(1,1) primary key NOT NULL,
	[UserLogTypeId] [int] NOT NULL,	
	[GroupId] [int] NULL,
	[OldValue] [int] NULL,
	[NewValue] [int] NULL,
	[UpdatedUserId] [int] NOT NULL,
	[TargetUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_UserLog]  ADD  FOREIGN KEY([UserLogTypeId]) REFERENCES [SfUMS_UserLogType] ([Id])
;
ALTER TABLE [SfUMS_UserLog]  ADD  FOREIGN KEY([GroupId]) REFERENCES [SfUMS_Group] ([Id])
;
ALTER TABLE [SfUMS_UserLog]  ADD  FOREIGN KEY([TargetUserId]) REFERENCES [SfUMS_User] ([Id])
;
ALTER TABLE [SfUMS_UserLog]  ADD  FOREIGN KEY([UpdatedUserId]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_UserLogin](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[UserId] [int] NOT NULL,
	[ClientToken] [nvarchar](4000) NOT NULL,
	[IpAddress] [nvarchar](50) NOT NULL,
	[LoggedInTime] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_UserLogin]  ADD FOREIGN KEY([UserId]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_UserPreference](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[UserId] [int] NOT NULL,
	[Language] [nvarchar](4000) NULL,
	[TimeZone] [nvarchar](100) NULL,
	[RecordSize] [int] NULL,
	[ItemSort] [nvarchar](4000) NULL,
	[ItemFilters] [nvarchar](4000) NULL,
	[Notifications] [nvarchar](4000) NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_UserPreference] ADD FOREIGN KEY([UserId]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_SystemLogType](
	[Id] [int] IDENTITY(1,1) primary key NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL)
;

CREATE TABLE [SfUMS_SystemLog](
	[LogId] [int] IDENTITY(1,1) primary key NOT NULL,
	[SystemLogTypeId] [int] NOT NULL,
	[UpdatedUserId] [int] NOT NULL,
	[TargetUserId] [int] NOT NULL,		
	[ModifiedDate] [datetime] NOT NULL,
	[IsActive] bit NOT NULL)
;

ALTER TABLE [SfUMS_SystemLog]  ADD FOREIGN KEY([SystemLogTypeId]) REFERENCES [SfUMS_SystemLogType] ([Id])
;
ALTER TABLE [SfUMS_SystemLog]  ADD FOREIGN KEY([UpdatedUserId]) REFERENCES [SfUMS_User] ([Id])
;
ALTER TABLE [SfUMS_SystemLog]  ADD FOREIGN KEY([TargetUserId]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_SystemSettings](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Key] [nvarchar](255) NOT NULL,
	[Value] [nvarchar](4000) NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	CONSTRAINT UK_SfUMS_SystemSettings_Key UNIQUE([Key]))
;

CREATE TABLE [SfUMS_ServerVersion](
[Id] [int] PRIMARY KEY NOT NULL,
[VersionNumber] [nvarchar](20) NOT NULL)
;

CREATE TABLE [SfUMS_ADUser](
[Id] [int] IDENTITY(1,1) primary key NOT NULL,
[UserId] [int] NOT NULL,
[ActiveDirectoryUserId] [uniqueidentifier] NOT NULL,
[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_ADUser] ADD FOREIGN KEY([UserId]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_ADGroup](
[Id] [int] IDENTITY(1,1) primary key NOT NULL,
[GroupId] [int] NOT NULL,
[ActiveDirectoryGroupId] [uniqueidentifier] NOT NULL,
[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_ADGroup] ADD FOREIGN KEY([GroupId]) REFERENCES [SfUMS_Group] ([Id])
;

CREATE TABLE [SfUMS_ADCredential](
[Id] [int] IDENTITY(1,1) primary key NOT NULL,
[Username] [nvarchar](100),
[Password] [nvarchar](100),
[LdapUrl] [nvarchar](255),
[EnableSsl] [bit] NOT NULL,
[DistinguishedName] [nvarchar](150),
[PortNo] [int] NOT NULL,
[ActiveDirectoryNewUserLogin] [bit],
[IsActive] [bit] NOT NULL)
;

CREATE TABLE [SfUMS_AzureADCredential](
[Id] [int] IDENTITY(1,1) primary key NOT NULL,
[TenantName] [nvarchar](255),
[ClientId] [nvarchar](100),
[ClientSecret] [nvarchar](100),
[NewUserLogin] [bit],
[IsActive] [bit] NOT NULL)
;

CREATE TABLE [SfUMS_AzureADUser](
[Id] [int] IDENTITY(1,1) primary key NOT NULL,
[UserId] [int] NOT NULL,
[AzureADUserId] [uniqueidentifier] NOT NULL,
[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_AzureADUser] ADD FOREIGN KEY([UserId]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_AzureADGroup](
[Id] [int] IDENTITY(1,1) primary key NOT NULL,
[GroupId] [int] NOT NULL,
[AzureADGroupId] [uniqueidentifier] NOT NULL,
[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_AzureADGroup] ADD FOREIGN KEY([GroupId]) REFERENCES [SfUMS_Group] ([Id])
;

CREATE TABLE [SfUMS_RecurrenceType](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[IsActive] [bit] NOT NULL)
;

CREATE TABLE [SfUMS_SAMLSettings](
	[Id] [int] IDENTITY(1,1) primary key NOT NULL, 
	[MetadataURI] nvarchar(4000),
	[Authority] nvarchar(4000),
	[DesignerClientId] nvarchar(100),
	[TenantName] nvarchar(100), 
	[MobileAppId] nvarchar(100),
	[IsEnabled] bit NOT NULL)
;

CREATE TABLE [SfUMS_UserType](
	[Id] [int] IDENTITY(1,1) primary key NOT NULL, 
	[Type] nvarchar(100))
;

INSERT into [SfUMS_SystemLogType] (Name,IsActive) VALUES (N'Updated',1)
;

INSERT into [SfUMS_UserLogType] (Name,IsActive) VALUES ( N'Added',1)
;
INSERT into [SfUMS_UserLogType] (Name,IsActive) VALUES ( N'Updated',1)
;
INSERT into [SfUMS_UserLogType] (Name,IsActive) VALUES ( N'Deleted',1)
;
INSERT into [SfUMS_UserLogType] (Name,IsActive) VALUES ( N'Changed',1)
;

INSERT into [SfUMS_RecurrenceType] (Name,IsActive) VALUES (N'Daily', 1)
;
INSERT into [SfUMS_RecurrenceType] (Name,IsActive) VALUES (N'DailyWeekDay', 1)
;
INSERT into [SfUMS_RecurrenceType] (Name,IsActive) VALUES (N'Weekly', 1)
;
INSERT into [SfUMS_RecurrenceType] (Name,IsActive) VALUES (N'Monthly', 1)
;
INSERT into [SfUMS_RecurrenceType] (Name,IsActive) VALUES (N'MonthlyDOW', 1)
;
INSERT into [SfUMS_RecurrenceType] (Name,IsActive) VALUES (N'Yearly', 1)
;
INSERT into [SfUMS_RecurrenceType] (Name,IsActive) VALUES (N'YearlyDOW', 1)
;
INSERT into [SfUMS_RecurrenceType] (Name,IsActive) VALUES (N'Time', 1)
;
INSERT into [SfUMS_RecurrenceType] (Name,IsActive) VALUES (N'Hourly',1)
;

INSERT into [SfUMS_Group] (Name,Description,Color,ModifiedDate,IsActive) VALUES (N'System Administrator','Has administrative rights for the UMS','#ff0000',GETDATE(), 1)
;

INSERT into [SfUMS_UserType](Type) values(N'Server User')
;
INSERT into [SfUMS_UserType](Type) values(N'Active Directory User')
;
INSERT into [SfUMS_UserType](Type) values(N'Federation User')
;

CREATE TABLE [SfUMS_ApplicationType](
	[Id] [int] primary key NOT NULL, 
	[Type] [nvarchar](255) NOT NULL)
;
ALTER TABLE [SfUMS_ApplicationType] ADD UNIQUE ([Type])
;

INSERT into [SfUMS_ApplicationType](Type,Id) values(N'Data Integration Platform',1)
;
INSERT into [SfUMS_ApplicationType](Type,Id) values(N'Others',10000)
;

CREATE TABLE [SfUMS_Applications](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Url] [nvarchar](4000) NOT NULL,
	[ClientId] [nvarchar](100) NOT NULL,
	[HasAccessToAllUsers] bit NOT NULL,
	[ApplicationTypeId] [int] NOT NULL,
	[Icon] [nvarchar](100) NOT NULL,
	[CreatedById] [int] NOT NULL,
	[ModifiedById] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ClientSecret] [nvarchar](255) NOT NULL,
	[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_Applications]  ADD FOREIGN KEY([CreatedById]) REFERENCES [SfUMS_User] ([Id])
;

ALTER TABLE [SfUMS_Applications]  ADD FOREIGN KEY([ModifiedById]) REFERENCES [SfUMS_User] ([Id])
;

ALTER TABLE [SfUMS_Applications]  ADD FOREIGN KEY([ApplicationTypeId]) REFERENCES [SfUMS_ApplicationType] ([Id])
;

CREATE TABLE [SfUMS_AppAccessToGroups](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
	[CreatedById] [int] NULL,
	[ModifiedById] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_AppAccessToGroups]  ADD FOREIGN KEY([ApplicationId]) REFERENCES [SfUMS_Applications] ([Id])
;

ALTER TABLE [SfUMS_AppAccessToGroups]  ADD FOREIGN KEY([GroupId]) REFERENCES [SfUMS_Group] ([Id])
;

ALTER TABLE [SfUMS_AppAccessToGroups]  ADD FOREIGN KEY([CreatedById]) REFERENCES [SfUMS_User] ([Id])
;

ALTER TABLE [SfUMS_AppAccessToGroups]  ADD FOREIGN KEY([ModifiedById]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_AppAccessToUsers](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[CreatedById] [int] NOT NULL,
	[ModifiedById] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_AppAccessToUsers]  ADD FOREIGN KEY([ApplicationId]) REFERENCES [SfUMS_Applications] ([Id])
;

ALTER TABLE [SfUMS_AppAccessToUsers]  ADD FOREIGN KEY([UserId]) REFERENCES [SfUMS_User] ([Id])
;

ALTER TABLE [SfUMS_AppAccessToUsers]  ADD FOREIGN KEY([CreatedById]) REFERENCES [SfUMS_User] ([Id])
;

ALTER TABLE [SfUMS_AppAccessToUsers]  ADD FOREIGN KEY([ModifiedById]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_AppAdmin](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[CreatedById] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL)
;

ALTER TABLE [SfUMS_AppAdmin]  ADD FOREIGN KEY([ApplicationId]) REFERENCES [SfUMS_Applications] ([Id])
;
ALTER TABLE [SfUMS_AppAdmin]  ADD FOREIGN KEY([UserId]) REFERENCES [SfUMS_User] ([Id])
;
ALTER TABLE [SfUMS_AppAdmin]  ADD FOREIGN KEY([CreatedById]) REFERENCES [SfUMS_User] ([Id])
;

CREATE TABLE [SfUMS_DBCredential](
    [Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [DatabaseType] [nvarchar](255) NOT NULL,
    [ConnectionString] [nvarchar](4000) NOT NULL,
    [UserNameSchema] [nvarchar](255) NOT NULL,
    [UserNameTable] [nvarchar](255) NOT NULL,
    [UserNameColumn] [nvarchar](255) NOT NULL,
    [FirstNameSchema] [nvarchar](255) NOT NULL,
    [FirstNameTable] [nvarchar](255) NOT NULL,
    [FirstNameColumn] [nvarchar](255) NOT NULL,
    [LastNameSchema] [nvarchar](255) NOT NULL,
    [LastNameTable] [nvarchar](255) NOT NULL,
    [LastNameColumn] [nvarchar](255) NOT NULL,
    [EmailSchema] [nvarchar](255) NOT NULL,
    [EmailTable] [nvarchar](255) NOT NULL,
    [EmailColumn] [nvarchar](255) NOT NULL,
    [IsActiveSchema] [nvarchar](255) NOT NULL,
    [IsActiveTable] [nvarchar](255) NOT NULL,
    [IsActiveColumn] [nvarchar](255) NOT NULL,
    [Status]  [nvarchar](255) NOT NULL,
    [ActiveStatusValue]  [nvarchar](255) NOT NULL,
    [EmailRelationId] [int] NULL,
    [FirstNameRelationId] [int] NULL,
    [LastNameRelationId] [int] NULL,
    [IsActiveRelationId] [int] NULL,
    [IsActive] [bit] NOT NULL)
;

CREATE TABLE [SfUMS_TableRelation](
    [Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [LeftTable] [nvarchar](255) NOT NULL,
    [LeftTableColumnName] [nvarchar](255) NOT NULL,	
    [LeftTableCondition]  [nvarchar](255) NOT NULL,
    [LeftTableName]  [nvarchar](255) NOT NULL,
    [LeftTableSchema] [nvarchar](255) NOT NULL,
    [Relationship] [nvarchar](255) NOT NULL,
    [RightTable] [nvarchar](255) NOT NULL,
    [RightTableColumnName] [nvarchar](255) NOT NULL,	
    [RightTableCondition]  [nvarchar](255) NOT NULL,
    [RightTableName]  [nvarchar](255) NOT NULL,
    [RightTableSchema] [nvarchar](255) NOT NULL)
;

INSERT into [SfUMS_ApplicationType](Type,Id) values(N'Dashboard Server',2)
;

INSERT into [SfUMS_ApplicationType](Type,Id) values(N'Report Server',3)
;

CREATE INDEX [IX_SfUMS_ADGrp] ON [SfUMS_ADGroup] ([GroupId])
;

CREATE INDEX [IX_SfUMS_ADUsr] ON [SfUMS_ADUser] ([UserId])
;

CREATE INDEX [IX_SfUMS_AzrADGrp] ON [SfUMS_AzureADGroup] ([GroupId])
;

CREATE INDEX [IX_SfUMS_AzrADUsr] ON [SfUMS_AzureADUser] ([UserId])
;

CREATE INDEX [IX_SfUMS_Grp] ON [SfUMS_Group] ([Name], [Description])
;

CREATE INDEX [IX_SfUMS_Usr] ON [SfUMS_User] ([UserName], [Email], [DisplayName])
;

CREATE INDEX [IX_SfUMS_UsrGrp] ON [SfUMS_UserGroup] ([GroupId], [UserId])
;

CREATE INDEX [IX_SfUMS_UsrLogin] ON [SfUMS_UserLogin] ([UserId])
;

CREATE INDEX [IX_SfUMS_AppAcsGrps] ON [SfUMS_AppAccessToGroups] ([ApplicationId], [GroupId])
;

CREATE INDEX [IX_SfUMS_AppAcsUsrs] ON [SfUMS_AppAccessToUsers] ([ApplicationId], [UserId])
;

CREATE INDEX [IX_SfUMS_AppAdmin] ON [SfUMS_AppAdmin] ([ApplicationId], [UserId])
;

CREATE INDEX [IX_SfUMS_Apps] ON [SfUMS_Applications] ([Name], [ClientId], [Url])
;