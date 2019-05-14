CREATE TABLE "SfUMS_User"(
	"Id" int primary key NOT NULL,
	"UserName" NVARCHAR2(100) NOT NULL,
	"FirstName" NVARCHAR2(255) NOT NULL,
	"LastName" NVARCHAR2(255) NULL,
	"DisplayName" NVARCHAR2(512) NULL,
	"Email" NVARCHAR2(255) NOT NULL,
	"Password" NVARCHAR2(255) NOT NULL,
	"Contact" NVARCHAR2(64) NULL,
	"Picture" NVARCHAR2(100) NOT NULL,	
	"CreatedDate" DATE NOT NULL,
	"ModifiedDate" DATE NULL,
	"LastLogin" DATE NULL,
	"PasswordChangedDate" DATE NULL,
	"ActivationExpirationDate" DATE NULL,
	"ActivationCode" NVARCHAR2(255) NOT NULL,
	"ResetPasswordCode" NVARCHAR2(255) NULL,
	"LastResetAttempt" DATE NULL,
	"UserTypeId" int DEFAULT 0 NOT NULL,
	"IsActivated" NUMBER(1) NOT NULL,
	"IsActive" NUMBER(1) NOT NULL,
	"IsDeleted" NUMBER(1) NOT NULL,
	"DomainId" VARCHAR2(4000) NULL)
;

CREATE SEQUENCE "SfUMS_User_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_Group"(
	"Id" int PRIMARY KEY NOT NULL,
	"Name" NVARCHAR2(255) NOT NULL,
	"Description" NVARCHAR2(1026) NULL,
	"Color" NVARCHAR2(255) DEFAULT 'White' NOT NULL,
	"ModifiedDate" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL,
	"DomainId" VARCHAR2(4000) NULL)
;

CREATE SEQUENCE "SfUMS_Group_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_UserGroup"(
	"Id" int PRIMARY KEY NOT NULL,
	"GroupId" int NOT NULL,
	"UserId" int NOT NULL,
	"ModifiedDate" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_UserGroup_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_UserGroup"  ADD FOREIGN KEY("GroupId") REFERENCES "SfUMS_Group" ("Id")
;
ALTER TABLE "SfUMS_UserGroup"  ADD FOREIGN KEY("UserId") REFERENCES "SfUMS_User" ("Id")
;

CREATE TABLE "SfUMS_UserLogType"(
	"Id" int primary key NOT NULL,
	"Name" NVARCHAR2(100) NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_UserLogType_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_UserLog"(
	"Id" int primary key NOT NULL,
	"UserLogTypeId" int NOT NULL,	
	"GroupId" int NULL,
	"OldValue" int NULL,
	"NewValue" int NULL,
	"UpdatedUserId" int NOT NULL,
	"TargetUserId" int NOT NULL,
	"ModifiedDate" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_UserLog_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_UserLog"  ADD  FOREIGN KEY("UserLogTypeId") REFERENCES "SfUMS_UserLogType" ("Id")
;
ALTER TABLE "SfUMS_UserLog"  ADD  FOREIGN KEY("GroupId") REFERENCES "SfUMS_Group" ("Id")
;
ALTER TABLE "SfUMS_UserLog"  ADD  FOREIGN KEY("TargetUserId") REFERENCES "SfUMS_User" ("Id")
;
ALTER TABLE "SfUMS_UserLog"  ADD  FOREIGN KEY("UpdatedUserId") REFERENCES "SfUMS_User" ("Id")
;

CREATE TABLE "SfUMS_UserLogin"(
	"Id" int PRIMARY KEY NOT NULL,
	"UserId" int NOT NULL,
	"ClientToken" VARCHAR2(4000) NOT NULL,
	"IpAddress" NVARCHAR2(50) NOT NULL,
	"LoggedInTime" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_UserLogin_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_UserLogin"  ADD FOREIGN KEY("UserId") REFERENCES "SfUMS_User" ("Id")
;

CREATE TABLE "SfUMS_UserPreference"(
	"Id" int PRIMARY KEY NOT NULL,
	"UserId" int NOT NULL,
	"Language" VARCHAR2(4000) NULL,
	"TimeZone" NVARCHAR2(100) NULL,
	"RecordSize" int NULL,
	"ItemSort" VARCHAR2(4000) NULL,
	"ItemFilters" VARCHAR2(4000) NULL,
	"Notifications" VARCHAR2(4000) NULL,
	"ModifiedDate" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_UserPreference_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_UserPreference" ADD FOREIGN KEY("UserId") REFERENCES "SfUMS_User" ("Id")
;

CREATE TABLE "SfUMS_SystemLogType"(
	"Id" int primary key NOT NULL,
	"Name" NVARCHAR2(100) NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_SystemLogType_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_SystemLog"(
	"LogId" int primary key NOT NULL,
	"SystemLogTypeId" int NOT NULL,
	"UpdatedUserId" int NOT NULL,
	"TargetUserId" int NOT NULL,		
	"ModifiedDate" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_SystemLog_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_SystemLog"  ADD FOREIGN KEY("SystemLogTypeId") REFERENCES "SfUMS_SystemLogType" ("Id")
;
ALTER TABLE "SfUMS_SystemLog"  ADD FOREIGN KEY("UpdatedUserId") REFERENCES "SfUMS_User" ("Id")
;
ALTER TABLE "SfUMS_SystemLog"  ADD FOREIGN KEY("TargetUserId") REFERENCES "SfUMS_User" ("Id")
;

CREATE TABLE "SfUMS_SystemSettings"(
	"Id" int PRIMARY KEY NOT NULL,
	"Key" NVARCHAR2(255) NOT NULL,
	"Value" VARCHAR2(4000) NULL,
	"ModifiedDate" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL,
	CONSTRAINT UK_SfUMS_SystemSettings_Key UNIQUE ("Key"))
;

CREATE SEQUENCE "SfUMS_SystemSettings_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_ServerVersion"(
	"Id" int PRIMARY KEY NOT NULL,
	"VersionNumber" NVARCHAR2(20) NOT NULL)
;
CREATE SEQUENCE "SfUMS_ServerVersion_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

create table "SfUMS_ADUser"(
	"Id" int primary key NOT NULL,
	"UserId" int not null,
	"ActiveDirectoryUserId" NCHAR(36) not null,
	"IsActive" NUMBER(1) not null)
;

CREATE SEQUENCE "SfUMS_ADUser_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_ADUser" ADD FOREIGN KEY("UserId") REFERENCES "SfUMS_User" ("Id")
;

create table "SfUMS_ADGroup"(
	"Id" int primary key NOT NULL,
	"GroupId" int not null,
	"ActiveDirectoryGroupId" NCHAR(36) not null,
	"IsActive" NUMBER(1) not null)
;

CREATE SEQUENCE "SfUMS_ADGroup_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_ADGroup" ADD FOREIGN KEY("GroupId") REFERENCES "SfUMS_Group" ("Id")
;

create table "SfUMS_ADCredential"(
	"Id" int primary key NOT NULL,
	"Username" NVARCHAR2(100),
	"Password" NVARCHAR2(100),
	"LdapUrl" NVARCHAR2(255),
	"EnableSsl" NUMBER(1) not null,
	"DistinguishedName" NVARCHAR2(150),
	"PortNo" int not null,
	"ActiveDirectoryNewUserLogin" NUMBER(1),
	"IsActive" NUMBER(1) not null)
;

CREATE SEQUENCE "SfUMS_ADCredential_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_AzureADCredential"(
	"Id" int primary key NOT NULL,
	"TenantName" NVARCHAR2(255),
	"ClientId" NVARCHAR2(100),
	"ClientSecret" NVARCHAR2(100),
	"NewUserLogin" NUMBER(1),
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_AzureADCredential_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_AzureADUser"(
	"Id" int primary key NOT NULL,
	"UserId" int NOT NULL,
	"AzureADUserId" NCHAR(36) NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_AzureADUser_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_AzureADUser" ADD FOREIGN KEY("UserId") REFERENCES "SfUMS_User" ("Id")
;

CREATE TABLE "SfUMS_AzureADGroup"(
	"Id" int primary key NOT NULL,
	"GroupId" int NOT NULL,
	"AzureADGroupId" NCHAR(36) NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_AzureADGroup_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_AzureADGroup" ADD FOREIGN KEY("GroupId") REFERENCES "SfUMS_Group" ("Id")
;

CREATE TABLE "SfUMS_RecurrenceType"(
	"Id" int PRIMARY KEY NOT NULL,
	"Name" NVARCHAR2(30) NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;
CREATE SEQUENCE "SfUMS_RecurrenceType_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_SAMLSettings"(
	"Id" int primary key NOT NULL, 
	"MetadataURI" VARCHAR2(4000),
	"Authority" VARCHAR2(4000),
	"DesignerClientId" VARCHAR2(100),
	"TenantName" VARCHAR2(100), 	
	"MobileAppId" VARCHAR2(100),
	"IsEnabled" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_SAMLSettings_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_UserType"(
	"Id" int primary key NOT NULL, 
	"Type" NVARCHAR2(100))
;

CREATE SEQUENCE "SfUMS_UserType_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

INSERT into "SfUMS_SystemLogType" ("Id","Name","IsActive") VALUES ("SfUMS_SystemLogType_seq".nextval,'Updated',1)
;

INSERT into "SfUMS_UserLogType" ("Id","Name","IsActive") VALUES ("SfUMS_UserLogType_seq".nextval,'Added',1)
;
INSERT into "SfUMS_UserLogType" ("Id","Name","IsActive") VALUES ("SfUMS_UserLogType_seq".nextval,'Updated',1)
;
INSERT into "SfUMS_UserLogType" ("Id","Name","IsActive") VALUES ("SfUMS_UserLogType_seq".nextval,'Deleted',1)
;
INSERT into "SfUMS_UserLogType" ("Id","Name","IsActive") VALUES ("SfUMS_UserLogType_seq".nextval,'Changed',1)
;

INSERT into "SfUMS_RecurrenceType" ("Id","Name","IsActive") VALUES ("SfUMS_RecurrenceType_seq".nextval,'Daily', 1)
;
INSERT into "SfUMS_RecurrenceType" ("Id","Name","IsActive") VALUES ("SfUMS_RecurrenceType_seq".nextval,'DailyWeekDay', 1)
;
INSERT into "SfUMS_RecurrenceType" ("Id","Name","IsActive") VALUES ("SfUMS_RecurrenceType_seq".nextval,'Weekly', 1)
;
INSERT into "SfUMS_RecurrenceType" ("Id","Name","IsActive") VALUES ("SfUMS_RecurrenceType_seq".nextval,'Monthly', 1)
;
INSERT into "SfUMS_RecurrenceType" ("Id","Name","IsActive") VALUES ("SfUMS_RecurrenceType_seq".nextval,'MonthlyDOW', 1)
;
INSERT into "SfUMS_RecurrenceType" ("Id","Name","IsActive") VALUES ("SfUMS_RecurrenceType_seq".nextval,'Yearly', 1)
;
INSERT into "SfUMS_RecurrenceType" ("Id","Name","IsActive") VALUES ("SfUMS_RecurrenceType_seq".nextval,'YearlyDOW', 1)
;
INSERT into "SfUMS_RecurrenceType" ("Id","Name","IsActive") VALUES ("SfUMS_RecurrenceType_seq".nextval,'Time', 1)
;
INSERT into "SfUMS_RecurrenceType" ("Id","Name","IsActive") VALUES ("SfUMS_RecurrenceType_seq".nextval,'Hourly',1)
;

INSERT into "SfUMS_Group" ("Id","Name","Description","Color","ModifiedDate","IsActive") VALUES ("SfUMS_Group_seq".nextval,'System Administrator','Has administrative rights for the UMS','#ff0000',SYSDATE, 1)
;

INSERT into "SfUMS_UserType" ("Id","Type") values("SfUMS_UserType_seq".nextval,'Server User')
;
INSERT into "SfUMS_UserType" ("Id","Type") values("SfUMS_UserType_seq".nextval,'Active Directory User')
;
INSERT into "SfUMS_UserType" ("Id","Type") values("SfUMS_UserType_seq".nextval,'Federation User')
;

CREATE TABLE "SfUMS_ApplicationType"(
	"Id" int primary key NOT NULL, 
	"Type" NVARCHAR2(255) NOT NULL)
;
ALTER TABLE "SfUMS_ApplicationType" ADD UNIQUE ("Type")
;

INSERT into "SfUMS_ApplicationType" ("Id","Type") values(1,'Data Integration Platform')
;
INSERT into "SfUMS_ApplicationType" ("Id","Type") values(10000,'Others')
;

CREATE TABLE "SfUMS_Applications"(
	"Id" int primary key NOT NULL,
	"Name" NVARCHAR2(255) NOT NULL,
	"Url" NVARCHAR2(2000) NOT NULL,
	"ClientId" NVARCHAR2(100) NOT NULL,
	"HasAccessToAllUsers" NUMBER(1) NOT NULL,
	"ApplicationTypeId" int NOT NULL,
	"Icon" NVARCHAR2(100) NOT NULL,
	"CreatedById" int NOT NULL,
	"ModifiedById" int NOT NULL,
	"CreatedDate" DATE NOT NULL,
	"ModifiedDate" DATE NOT NULL,
	"ClientSecret" NVARCHAR2(255) NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_Applications_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_Applications"  ADD FOREIGN KEY("CreatedById") REFERENCES "SfUMS_User" ("Id")
;

ALTER TABLE "SfUMS_Applications"  ADD FOREIGN KEY("ModifiedById") REFERENCES "SfUMS_User" ("Id")
;

ALTER TABLE "SfUMS_Applications"  ADD FOREIGN KEY("ApplicationTypeId") REFERENCES "SfUMS_ApplicationType" ("Id")
;

CREATE TABLE "SfUMS_AppAccessToGroups"(
	"Id" int primary key NOT NULL,
	"ApplicationId" int NOT NULL,
	"GroupId" int NOT NULL,
	"CreatedById" int NULL,
	"ModifiedById" int NULL,
	"CreatedDate" DATE NOT NULL,
	"ModifiedDate" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_AppAccessToGroups_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_AppAccessToGroups"  ADD FOREIGN KEY("ApplicationId") REFERENCES "SfUMS_Applications" ("Id")
;

ALTER TABLE "SfUMS_AppAccessToGroups"  ADD FOREIGN KEY("GroupId") REFERENCES "SfUMS_Group" ("Id")
;

ALTER TABLE "SfUMS_AppAccessToGroups"  ADD FOREIGN KEY("CreatedById") REFERENCES "SfUMS_User" ("Id")
;

ALTER TABLE "SfUMS_AppAccessToGroups"  ADD FOREIGN KEY("ModifiedById") REFERENCES "SfUMS_User" ("Id")
;

CREATE TABLE "SfUMS_AppAccessToUsers"(
	"Id" int primary key NOT NULL,
	"ApplicationId" int NOT NULL,
	"UserId" int NOT NULL,
	"CreatedById" int NOT NULL,
	"ModifiedById" int NOT NULL,
	"CreatedDate" DATE NOT NULL,
	"ModifiedDate" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_AppAccessToUsers_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_AppAccessToUsers"  ADD FOREIGN KEY("ApplicationId") REFERENCES "SfUMS_Applications" ("Id")
;

ALTER TABLE "SfUMS_AppAccessToUsers"  ADD FOREIGN KEY("UserId") REFERENCES "SfUMS_User" ("Id")
;

ALTER TABLE "SfUMS_AppAccessToUsers"  ADD FOREIGN KEY("CreatedById") REFERENCES "SfUMS_User" ("Id")
;

ALTER TABLE "SfUMS_AppAccessToUsers"  ADD FOREIGN KEY("ModifiedById") REFERENCES "SfUMS_User" ("Id")

;

CREATE TABLE "SfUMS_AppAdmin"(
	"Id" int PRIMARY KEY NOT NULL,
	"ApplicationId" int NOT NULL,
	"UserId" int NOT NULL,
	"CreatedById" int NOT NULL,
	"CreatedDate" DATE NOT NULL,
	"IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_AppAdmin_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

ALTER TABLE "SfUMS_AppAdmin"  ADD FOREIGN KEY("ApplicationId") REFERENCES "SfUMS_Applications" ("Id")
;
ALTER TABLE "SfUMS_AppAdmin"  ADD FOREIGN KEY("UserId") REFERENCES "SfUMS_User" ("Id")
;
ALTER TABLE "SfUMS_AppAdmin"  ADD FOREIGN KEY("CreatedById") REFERENCES "SfUMS_User" ("Id")
;

CREATE TABLE "SfUMS_DBCredential"(
    "Id" int PRIMARY KEY NOT NULL,
    "DatabaseType" NVARCHAR2(255) NOT NULL,
    "ConnectionString" VARCHAR2(4000) NOT NULL,
    "Status"  NVARCHAR2(255) NOT NULL,
    "ActiveStatusValue"  NVARCHAR2(255) NOT NULL,
    "UserNameSchema" NVARCHAR2(255) NOT NULL,
    "UserNameTable" NVARCHAR2(255) NOT NULL,
    "UserNameColumn" NVARCHAR2(255) NOT NULL,
    "FirstNameSchema" NVARCHAR2(255) NOT NULL,
    "FirstNameTable" NVARCHAR2(255) NOT NULL,
    "FirstNameColumn" NVARCHAR2(255) NOT NULL,
    "LastNameSchema" NVARCHAR2(255) NOT NULL,
    "LastNameTable" NVARCHAR2(255) NOT NULL,
    "LastNameColumn" NVARCHAR2(255) NOT NULL,
    "EmailSchema" NVARCHAR2(255) NOT NULL,
    "EmailTable" NVARCHAR2(255) NOT NULL,
    "EmailColumn" NVARCHAR2(255) NOT NULL,
    "IsActiveColumn" NVARCHAR2(255) NOT NULL,
    "IsActiveSchema" NVARCHAR2(255) NOT NULL,
    "IsActiveTable" NVARCHAR2(255) NOT NULL,
    "EmailRelationId" int NULL,
    "FirstNameRelationId" int NULL,
    "IsActiveRelationId" int NULL,
    "LastNameRelationId" int NULL,
    "IsActive" NUMBER(1) NOT NULL)
;

CREATE SEQUENCE "SfUMS_DBCredential_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

CREATE TABLE "SfUMS_TableRelation"(
    "Id" int PRIMARY KEY NOT NULL,
    "LeftTable" NVARCHAR2(255) NOT NULL,
    "LeftTableColumnName" NVARCHAR2(255) NOT NULL,	
    "LeftTableCondition"  NVARCHAR2(255) NOT NULL,
    "LeftTableName"  NVARCHAR2(255) NOT NULL,
    "LeftTableSchema" NVARCHAR2(255) NOT NULL,
    "Relationship" NVARCHAR2(255) NOT NULL,
    "RightTable" NVARCHAR2(255) NOT NULL,
    "RightTableColumnName" NVARCHAR2(255) NOT NULL,	
    "RightTableCondition"  NVARCHAR2(255) NOT NULL,
    "RightTableName"  NVARCHAR2(255) NOT NULL,
    "RightTableSchema" NVARCHAR2(255) NOT NULL)
;

CREATE SEQUENCE "SfUMS_TableRelation_seq"
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

INSERT into "SfUMS_ApplicationType" ("Id","Type") values(2,'Dashboard Server')
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
