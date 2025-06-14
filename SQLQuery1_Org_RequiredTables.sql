CREATE DATABASE OrganizationInfo

USE OrganizationInfo
GO

/***		Required TABLES			***/

CREATE TABLE Organization
(
	OrganizationId INT IDENTITY(101,1) PRIMARY KEY,
	OrganizationName NVARCHAR(200),
	Department	NVARCHAR(200),
	Parent INT NULL,
	ROOT INT NOT NULL,
	Status NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE
);


CREATE TABLE Office
(
	OfficeId INT IDENTITY(201,1) PRIMARY KEY,
	OrganizationId INT,
	OfficeLocation NVARCHAR(200),
	Status NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE,

	CONSTRAINT Fk_OrgaId FOREIGN KEY (OrganizationId) REFERENCES Organization(OrganizationId)
);

CREATE TABLE Company
(
	CompanyId INT IDENTITY(1,1),
	CompanyName NVARCHAR(200),
	OrganizationId INT,
	OfficeId INT,
	UserPersonId INT,
	InsertDate DATE,

	CONSTRAINT Fk_OrgId FOREIGN KEY (OrganizationId) REFERENCES Organization(OrganizationId),
	CONSTRAINT Fk_C_OffId FOREIGN KEY(OfficeId) REFERENCES Office(OfficeId)
);


CREATE TABLE NewCustomer
(
	NewCustomerId INT IDENTITY(1,1),
	OrganizationId INT,
	OfficeId INT,
	Status NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE,

	CONSTRAINT Fk_Nc_OrgId FOREIGN KEY(OrganizationId) REFERENCES Organization(OrganizationId),
	CONSTRAINT Fk_Nc_OffId FOREIGN KEY(OfficeId) REFERENCES Office(OfficeId)
);


CREATE TABLE Address
(
	AddressId INT IDENTITY(111,1) PRIMARY KEY,
	Street NVARCHAR(200),
	City NVARCHAR(200),
	State NVARCHAR(200),
	ZipCode NVARCHAR(200),
	Country NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE
);


CREATE TABLE Contact
(
	ContactId INT IDENTITY(1,1) PRIMARY KEY,
	PhoneNumber NVARCHAR(200),
	Email NVARCHAR(200),
	Website NVARCHAR(200) NULL,
	UserPersonId INT,
	InsertDate DATE
);


CREATE TABLE OrganizationAddress
(
	OrganizationAddressId INT IDENTITY(201,1),
	OrganizationId INT,
	AddressId INT,

	CONSTRAINT Fk_OrgAddressorg FOREIGN KEY(OrganizationId) REFERENCES Organization(OrganizationId),
	CONSTRAINT Fk_OrgAddressAdd FOREIGN KEY(AddressId)		REFERENCES Address(AddressId)
);


CREATE TABLE OrganizationContact
(
	OrganizationContactId INT IDENTITY(111,1) PRIMARY KEY,
	OrganizationId INT,
	ContactId INT,

	CONSTRAINT Fk_OrgContactOrg FOREIGN KEY(OrganizationId) REFERENCES Organization(OrganizationId),
	CONSTRAINT Fk_OrgContactCon FOREIGN KEY(ContactId)		REFERENCES Contact(ContactId)
);