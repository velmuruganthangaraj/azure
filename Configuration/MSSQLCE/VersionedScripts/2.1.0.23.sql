INSERT into [SfUMS_ApplicationType](Type,Id) values(N'Dashboard Server',2)
;

CREATE INDEX [IX_ADGroup_GroupId] ON [SfUMS_ADGroup] ([GroupId])
;

CREATE INDEX [IX_ADUser_UserId] ON [SfUMS_ADUser] ([UserId])
;

CREATE INDEX [IX_AzureADGroup_GroupId] ON [SfUMS_AzureADGroup] ([GroupId])
;

CREATE INDEX [IX_AzureADUser_UserId] ON [SfUMS_AzureADUser] ([UserId])
;

CREATE INDEX [IX_Group_Name_Description] ON [SfUMS_Group] ([Name], [Description])
;

CREATE INDEX [IX_User_UserName_Email_DisplayName] ON [SfUMS_User] ([UserName], [Email], [DisplayName])
;

CREATE INDEX [IX_UserGroup_GroupId_UserId] ON [SfUMS_UserGroup] ([GroupId], [UserId])
;

CREATE INDEX [IX_UserLogin_UserId] ON [SfUMS_UserLogin] ([UserId])
;

CREATE INDEX [IX_AppAccessToGroups_ApplicationId_GroupId] ON [SfUMS_AppAccessToGroups] ([ApplicationId], [GroupId])
;

CREATE INDEX [IX_AppAccessToUsers_ApplicationId_UserId] ON [SfUMS_AppAccessToUsers] ([ApplicationId], [UserId])
;

CREATE INDEX [IX_AppAdmin_ApplicationId_UserId] ON [SfUMS_AppAdmin] ([ApplicationId], [UserId])
;

CREATE INDEX [IX_Applications_Name_ClientId_Url] ON [SfUMS_Applications] ([Name], [ClientId], [Url])
;

ALTER TABLE [SfUMS_Applications] ALTER COLUMN [Url] [nvarchar](4000)
;

ALTER TABLE [SfUMS_ADCredential] ADD [ActiveDirectoryNewUserLogin] [bit] Not Null default '0'
;

ALTER TABLE [SfUMS_AzureADCredential] ADD [NewUserLogin] [bit] Not Null default '0'
;

ALTER TABLE [SfUMS_SAMLSettings] ADD [MobileAppId] [nvarchar](100) NULL
;

ALTER TABLE [SfUMS_User] ALTER COLUMN [Contact] [nvarchar](64) NULL
;

ALTER TABLE [SfUMS_AppAccessToGroups] ALTER COLUMN [CreatedById] [int] NULL
;

ALTER TABLE [SfUMS_AppAccessToGroups] ALTER COLUMN [ModifiedById] [int] NULL
;