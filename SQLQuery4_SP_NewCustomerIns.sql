USE OrganizationInfo
GO

/**					NewCustomer Ins						**/
CREATE OR ALTER PROCEDURE SpNewCustomerIns
@json NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			CREATE TABLE #temp
			(	
				OrganizationId INT,
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

			INSERT INTO #temp(OrganizationId, Status, Street, State, ZipCode, Country, PhoneNumber, Email, Website, UserPersonId)
			SELECT OrganizationId, Status, Street, State, ZipCode, Country, PhoneNumber, Email, Website, UserPersonId
			FROM OPENJSON(@json)
			WITH
			(
				OrganizationId INT,
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

			DECLARE @insertNc TABLE
			(
				NewCustomerId INT,
				OrganizationId INT,
				Status NVARCHAR(200),
				UserPersonId INT,
				InsertDate DATE
			)

			INSERT INTO NewCustomer(OrganizationId, Status, UserPersonId, InsertDate)
			OUTPUT INSERTED.* INTO @insertNc
			SELECT OrganizationId, Status, UserPersonId, getdate()
			FROM #temp

			SELECT * FROM @insertNc;
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

DECLARE @json NVARCHAR(MAX)=
N'
[
  {
    "OrganizationName": "AllDIN Freight",
    "Department": "Logistics",
    "Parent": 101,
    "Status": "Active",
    "Street": "Kalanki",
    "City": "Kathmandu",
    "State": "Bagmati",
    "ZipCode": "44602",
    "Country": "Nepal",
    "PhoneNumber": "+977-1-6677889",
    "Email": "logistics@himalayanfreight.com",
    "Website": "https://himalayanfreiht.com",
    "UserPersonId": 5,
    "InsertDate": "2025-06-15",
    "OrganizationId": 124
  },
  {
    "OrganizationName": "Global Agro Farms",
    "Department": "Agriculture",
    "Parent": 102,
    "Status": "Active",
    "Street": "Maitidevi",
    "City": "Kathmandu",
    "State": "Bagmati",
    "ZipCode": "44601",
    "Country": "Nepal",
    "PhoneNumber": "+977-1-4433221",
    "Email": "contact@globalagro.com",
    "Website": "https://glbalagro.com",
    "UserPersonId": 5,
    "InsertDate": "2025-06-15",
    "OrganizationId": 125
  }
]'

EXEC SpNewCustomerIns @json
PRINT @json;


/**
--		Created this table to check if the SpNewCustomerINs works or not
CREATE TABLE NewCustomerCheck
(
	NewCustomerId INT IDENTITY(1,1),
	OrganizationId INT,
	Status NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE
)

**/