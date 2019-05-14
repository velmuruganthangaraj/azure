ALTER TABLE "SfUMS_User" ADD "DomainId" VARCHAR2(4000) NULL
; 

ALTER TABLE "SfUMS_Group" ADD "DomainId" VARCHAR2(4000) NULL
; 

INSERT into "SfUMS_ApplicationType" ("Id","Type") values(3,'Report Server')
;

CREATE INDEX "IX_SfUMS_ADGrp" ON "SfUMS_ADGroup" ("GroupId")
;

CREATE INDEX "IX_SfUMS_ADUsr" ON "SfUMS_ADUser" ("UserId")
;

CREATE INDEX "IX_SfUMS_AzrADGrp" ON "SfUMS_AzureADGroup" ("GroupId")
;

CREATE INDEX "IX_SfUMS_AzrADUsr" ON "SfUMS_AzureADUser" ("UserId")
;

CREATE INDEX "IX_SfUMS_Grp" ON "SfUMS_Group" ("Name", "Description")
;

CREATE INDEX "IX_SfUMS_Usr" ON "SfUMS_User" ("UserName", "Email", "DisplayName")
;

CREATE INDEX "IX_SfUMS_UsrGrp" ON "SfUMS_UserGroup" ("GroupId", "UserId")
;

CREATE INDEX "IX_SfUMS_UsrLogin" ON "SfUMS_UserLogin" ("UserId")
;

CREATE INDEX "IX_SfUMS_AppAcsGrps" ON "SfUMS_AppAccessToGroups" ("ApplicationId", "GroupId")
;

CREATE INDEX "IX_SfUMS_AppAcsUsrs" ON "SfUMS_AppAccessToUsers" ("ApplicationId", "UserId")
;

CREATE INDEX "IX_SfUMS_AppAdmin" ON "SfUMS_AppAdmin" ("ApplicationId", "UserId")
;

CREATE INDEX "IX_SfUMS_Apps" ON "SfUMS_Applications" ("Name", "ClientId", "Url")
;
