INSERT into "SfUMS_ApplicationType" ("Id","Type") values(2,'Dashboard Server')
;

CREATE INDEX "IX_ADGroup_GroupId" ON "SfUMS_ADGroup" ("GroupId")
;

CREATE INDEX "IX_ADUser_UserId" ON "SfUMS_ADUser" ("UserId")
;

CREATE INDEX "IX_AzureADGroup_GroupId" ON "SfUMS_AzureADGroup" ("GroupId")
;

CREATE INDEX "IX_AzureADUser_UserId" ON "SfUMS_AzureADUser" ("UserId")
;

CREATE INDEX "IX_Group_Name_Description" ON "SfUMS_Group" ("Name", "Description")
;

CREATE INDEX "IX_User_UName_Email_DName" ON "SfUMS_User" ("UserName", "Email", "DisplayName")
;

CREATE INDEX "IX_UserGroup_GrpId_UsrId" ON "SfUMS_UserGroup" ("GroupId", "UserId")
;

CREATE INDEX "IX_UserLogin_UserId" ON "SfUMS_UserLogin" ("UserId")
;

CREATE INDEX "IX_AppAcsToGrps_AppId_GrpId" ON "SfUMS_AppAccessToGroups" ("ApplicationId", "GroupId")
;

CREATE INDEX "IX_AppAcsToUsrs_AppId_UsrId" ON "SfUMS_AppAccessToUsers" ("ApplicationId", "UserId")
;

CREATE INDEX "IX_AppAdmin_AppId_UsrId" ON "SfUMS_AppAdmin" ("ApplicationId", "UserId")
;

CREATE INDEX "IX_Apps_Name_ClientId_Url" ON "SfUMS_Applications" ("Name", "ClientId", "Url")
;

ALTER TABLE "SfUMS_Applications" MODIFY "Url" NVARCHAR2(2000)
;

ALTER TABLE "SfUMS_ADCredential" ADD "ActiveDirectoryNewUserLogin" NUMBER(1) NOT NULL default 0
;

ALTER TABLE "SfUMS_AzureADCredential" ADD "NewUserLogin" NUMBER(1) NOT NULL default 0
;

ALTER TABLE "SfUMS_SAMLSettings" ADD "MobileAppId" VARCHAR2(100)
;

ALTER TABLE "SfUMS_User" MODIFY "Contact" NVARCHAR2(64)
;

ALTER TABLE "SfUMS_AppAccessToGroups" MODIFY "CreatedById" int
;

ALTER TABLE "SfUMS_AppAccessToGroups" MODIFY "ModifiedById" int
;
