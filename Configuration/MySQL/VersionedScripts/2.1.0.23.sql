INSERT into {database_name}.SfUMS_ApplicationType(Type,Id) values('Dashboard Server',2)
;

CREATE INDEX IX_ADGroup_GroupId ON {database_name}.SfUMS_ADGroup (GroupId)
;

CREATE INDEX IX_ADUser_UserId ON {database_name}.SfUMS_ADUser (UserId)
;

CREATE INDEX IX_AzureADGroup_GroupId ON {database_name}.SfUMS_AzureADGroup (GroupId)
;

CREATE INDEX IX_AzureADUser_UserId ON {database_name}.SfUMS_AzureADUser (UserId)
;

CREATE INDEX IX_Group_Name_Description ON {database_name}.SfUMS_Group (Name, Description(255))
;

CREATE INDEX IX_User_UserName_Email_DisplayName ON {database_name}.SfUMS_User (UserName, Email, DisplayName)
;

CREATE INDEX IX_UserGroup_GroupId_UserId ON {database_name}.SfUMS_UserGroup (GroupId, UserId)
;

CREATE INDEX IX_UserLogin_UserId ON {database_name}.SfUMS_UserLogin (UserId)
;

CREATE INDEX IX_AppAccessToGroups_ApplicationId_GroupId ON {database_name}.SfUMS_AppAccessToGroups (ApplicationId, GroupId)
;

CREATE INDEX IX_AppAccessToUsers_ApplicationId_UserId ON {database_name}.SfUMS_AppAccessToUsers (ApplicationId, UserId)
;

CREATE INDEX IX_AppAdmin_ApplicationId_UserId ON {database_name}.SfUMS_AppAdmin (ApplicationId, UserId)
;

CREATE INDEX IX_Applications_Name_ClientId_Url ON {database_name}.SfUMS_Applications (Name, ClientId, Url(255))
;

ALTER TABLE {database_name}.SfUMS_Applications MODIFY Url varchar(4000)
;

ALTER TABLE {database_name}.SfUMS_ADCredential ADD ActiveDirectoryNewUserLogin tinyint(1) NOT NULL default 0
;

ALTER TABLE {database_name}.SfUMS_AzureADCredential ADD NewUserLogin tinyint(1) NOT NULL default 0
;

ALTER TABLE {database_name}.SfUMS_SAMLSettings ADD MobileAppId varchar(100)
;

ALTER TABLE {database_name}.SfUMS_User MODIFY Contact varchar(64)
;

ALTER TABLE {database_name}.SfUMS_AppAccessToGroups MODIFY CreatedById int
;

ALTER TABLE {database_name}.SfUMS_AppAccessToGroups MODIFY ModifiedById int
;