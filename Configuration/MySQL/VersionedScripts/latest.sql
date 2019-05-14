ALTER TABLE {database_name}.SfUMS_User ADD DomainId varchar(4000) NULL
; 

ALTER TABLE {database_name}.SfUMS_Group ADD DomainId varchar(4000) NULL
; 

INSERT into {database_name}.SfUMS_ApplicationType(Type,Id) values('Report Server',3)
;

CREATE INDEX IX_SfUMS_ADGrp ON {database_name}.SfUMS_ADGroup (GroupId)
;

CREATE INDEX IX_SfUMS_IX_ADUsr ON {database_name}.SfUMS_ADUser (UserId)
;

CREATE INDEX IX_SfUMS_AzrADGrp ON {database_name}.SfUMS_AzureADGroup (GroupId)
;

CREATE INDEX IX_SfUMS_AzrADUsr ON {database_name}.SfUMS_AzureADUser (UserId)
;

CREATE INDEX IX_SfUMS_Grp ON {database_name}.SfUMS_Group (Name, Description(255))
;

CREATE INDEX IX_SfUMS_Usr ON {database_name}.SfUMS_User (UserName, Email, DisplayName)
;

CREATE INDEX IX_SfUMS_UsrGrp ON {database_name}.SfUMS_UserGroup (GroupId, UserId)
;

CREATE INDEX IX_SfUMS_UsrLogin ON {database_name}.SfUMS_UserLogin (UserId)
;

CREATE INDEX IX_SfUMS_AppAcsGrps ON {database_name}.SfUMS_AppAccessToGroups (ApplicationId, GroupId)
;

CREATE INDEX IX_SfUMS_AppAcsUsrs ON {database_name}.SfUMS_AppAccessToUsers (ApplicationId, UserId)
;

CREATE INDEX IX_SfUMS_AppAdmin ON {database_name}.SfUMS_AppAdmin (ApplicationId, UserId)
;

CREATE INDEX IX_SfUMS_Apps ON {database_name}.SfUMS_Applications (Name, ClientId, Url(255))
;