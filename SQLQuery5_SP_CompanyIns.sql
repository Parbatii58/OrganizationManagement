USE OrganizationInfo
GO

/**					Company Ins						**/
CREATE OR ALTER PROCEDURE SpCompanyIns
@json NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			CREATE TABLE #temp
			(	
				OrganizationId INT,
				CompanyName NVARCHAR(200),
				Status NVARCHAR(200),
				Street NVARCHAR(200),
				City NVARCHAR(200),
				State NVARCHAR(200),
				ZipCode NVARCHAR(200),
				Country NVARCHAR(200),
				PhoneNumber NVARCHAR(200),
				Email NVARCHAR(200),
				Website NVARCHAR(200),
				UserPersonId INT
			);

			INSERT INTO #temp(OrganizationId, CompanyName, Status, Street, City, State, ZipCode, Country, PhoneNumber, Email, Website, UserPersonId)
			SELECT Organizationid, CompanyName, Status, Street, City, State, ZipCode, Country, PhoneNumber, Email, Website, UserPersonId
			FROM OPENJSON(@json)
			WITH
			(
				OrganizationId INT,
				CompanyName NVARCHAR(200),
				Status NVARCHAR(200),
				Street NVARCHAR(200),
				City NVARCHAR(200),
				State NVARCHAR(200),
				ZipCode NVARCHAR(200),
				Country NVARCHAR(200),
				PhoneNumber NVARCHAR(200),
				Email NVARCHAR(200),
				Website NVARCHAR(200),
				UserPersonId INT
			)
			
			DECLARE @InsertCompany TABLE 
			(
				CompanyId INT,
				CompanyName NVARCHAR(200),
				OrganizationId INT,
				UserPersonId INT,
				InsertDate DATE
			)
			INSERT INTO Company(CompanyName, OrganizationId, UserPersonId, InsertDate)
			OUTPUT INSERTED.* INTO @InsertCompany
			SELECT CompanyName, OrganizationId, UserPersonId, GETDATE()
			FROM #temp

			SELECT * FROM @InsertCompany;
			DROP TABLE #temp;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT>0
		BEGIN
			ROLLBACK
		END
		DECLARE @Error_Message NVARCHAR(200);
		DECLARE @Error_Line INT;
		DECLARE @Error_Procedure NVARCHAR(200);
		
		SET @Error_Message  = ERROR_MESSAGE();
		SET @Error_Line		= ERROR_LINE();
		SET @Error_Procedure= ERROR_PROCEDURE();

		PRINT 'Error line is:		' + @Error_Line;
		PRINT 'Error procedure is:  ' + ISNULL(@Error_Procedure, 'Unknown Procedure');
		PRINT 'Error message is:	' + @Error_Message;
		RAISERROR(@Error_Message, 16,1 );
	END CATCH
END


DECLARE @json NVARCHAR(MAX) = N'
[
  {
    "OrganizationId": 104,
    "CompanyName": "Everest Holdings Pvt. Ltd.",
    "Status": "Active",
    "Street": "Putalisadak",
    "City": "Kathmandu",
    "State": "Bagmati",
    "ZipCode": "44600",
    "Country": "Nepal",
    "PhoneNumber": "+977-1-5555555",
    "Email": "info@everestholdings.com",
    "Website": "https://evholdings.com",
    "UserPersonId": 7
  },
  {
    "OrganizationId": 107,
    "CompanyName": "Sagarmatha Agro Inc.",
    "Status": "Active",
    "Street": "Thapathali",
    "City": "Kathmandu",
    "State": "Bagmati",
    "ZipCode": "44605",
    "Country": "Nepal",
    "PhoneNumber": "+977-1-4444444",
    "Email": "contact@sagarmathaagro.com",
    "Website": "https://sagthaagro.com",
    "UserPersonId": 7
  }
]';

EXEC SpCompanyIns @json;
PRINT @json



/**
--		Created this table to check if the SpNewCustomerINs works or not

CREATE TABLE CompanyCheck
(
	CompanyId INT IDENTITY(1,1),
	CompanyName NVARCHAR(200),
	OrganizationId INT,
	UserPersonId INT,
	InsertDate DATE,
)

**/