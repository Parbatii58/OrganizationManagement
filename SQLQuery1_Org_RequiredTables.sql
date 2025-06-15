CREATE DATABASE OrganizationInfo

USE OrganizationInfo
GO

/***		Required TABLES			***/

CREATE TABLE UserPerson
(
	UserPersonId INT IDENTITY(1,1) PRIMARY KEY,
	UserPersonName NVARCHAR(200)
);

INSERT INTO UserPerson (UserPersonName) VALUES
('Aarav Sharma'),
('Priya Koirala'),
('Ramesh Thapa'),
('Sneha Adhikari'),
('Binod Shrestha'),
('Kriti Dhakal'),
('Dipesh Lama'),
('Sunita Gurung'),
('Anish Bhandari'),
('Nisha Poudel');


CREATE TABLE Organization
(
	OrganizationId INT IDENTITY(101,1) PRIMARY KEY,
	OrganizationName NVARCHAR(200),
	Department	NVARCHAR(200),
	Parent INT NULL,
	ROOT INT NULL,
	Status NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE
);
ALTER TABLE Organization ADD CONSTRAINT Fk_UserA FOREIGN KEY(UserPersonId) REFERENCES UserPerson(UserPersonId)


CREATE TABLE Company
(
	CompanyId INT IDENTITY(1,1),
	CompanyName NVARCHAR(200),
	OrganizationId INT,
	UserPersonId INT,
	InsertDate DATE,
	
	CONSTRAINT Fk_OrgId FOREIGN KEY (OrganizationId) REFERENCES Organization(OrganizationId)
);
ALTER TABLE Company ADD CONSTRAINT Fk_UserB FOREIGN KEY(UserPersonId) REFERENCES UserPerson(UserPersonId)

CREATE TABLE NewCustomer
(
	NewCustomerId INT IDENTITY(1,1),
	OrganizationId INT,
	Status NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE,

	CONSTRAINT Fk_Nc_OrgId FOREIGN KEY(OrganizationId) REFERENCES Organization(OrganizationId)
);
ALTER TABLE NewCustomer ADD CONSTRAINT Fk_UserAb FOREIGN KEY(UserPersonId) REFERENCES UserPerson(UserPersonId)

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
ALTER TABLE Address ADD CONSTRAINT Fk_UserBC FOREIGN KEY(UserPersonId) REFERENCES UserPerson(UserPersonId)

CREATE TABLE Contact
(
	ContactId INT IDENTITY(1,1) PRIMARY KEY,
	PhoneNumber NVARCHAR(200),
	Email NVARCHAR(200),
	Website NVARCHAR(200) NULL,
	UserPersonId INT,
	InsertDate DATE
);
ALTER TABLE Contact ADD CONSTRAINT Fk_UserCon FOREIGN KEY(UserPersonId) REFERENCES UserPerson(UserPersonId)

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