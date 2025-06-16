USE OrganizationInfo
GO

/**					Address Ins						**/
CREATE OR ALTER PROCEDURE SpAddressIns
@json NVARCHAR(MAX) OUTPUT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			CREATE TABLE #temp
			(
				OrganizationId INT,
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

			INSERT INTO #temp(OrganizationId, Street, City, State, ZipCode, Country, PhoneNumber, Email, Website, UserPersonId)
			SELECT OrganizationId, Street, City, State, ZipCode, Country, PhoneNumber, Email, Website, UserPersonId
			FROM OPENJSON(@json)
			WITH
			(
				OrganizationId INT,
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
			DECLARE @insertAddress TABLE
			(
				AddressId INT,
				Street NVARCHAR(200),
				City NVARCHAR(200),
				State NVARCHAR(200),
				ZipCode NVARCHAR(200),
				Country NVARCHAR(200),
				UserPersonId INT,
				InsertDate DATE
			);

			INSERT INTO Address(Street, City, State, ZipCode, Country, UserPersonId, InsertDate)
			OUTPUT INSERTED.* INTO @insertAddress
			SELECT Street, City, State, ZipCode, Country, UserPersonId, GETDATE()
			FROM #temp;

			SET @json = (SELECT i.AddressId, t.* FROM #temp t
						JOIN @insertAddress i
						ON t.Street = i.Street
						AND t.City = i.City
						AND t.State = i.State
						AND t.ZipCode = i.ZipCode
						AND t.Country = i.Country
						FOR JSON PATH
						);

			SELECT * FROM @insertAddress;
			PRINT @json;
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

		PRINT 'Error line is:		' + CAST(@Error_Line AS NVARCHAR)
		PRINT 'Error procedure is:  ' + ISNULL(@Error_Procedure, 'Unknown Procedure');
		PRINT 'Error message is:	' + @Error_Message;
		RAISERROR(@Error_Message, 16,1 );
	END CATCH
END

DECLARE @json NVARCHAR(MAX) = N'
[
  {
    "OrganizationName": "PWpAW Freight",
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
    "Website": "https://himalayanfreight.com",
    "UserPersonId": 5,
    "InsertDate": "2025-06-15",
    "OrganizationId": 124
  },
  {
    "OrganizationName": "Agro Farms",
    "Department": "Agriculture",
    "Parent": 108,
    "Status": "Active",
    "Street": "Maitidevi",
    "City": "Kathmandu",
    "State": "Bagmati",
    "ZipCode": "44601",
    "Country": "Nepal",
    "PhoneNumber": "+977-1-4433221",
    "Email": "contact@globalagro.com",
    "Website": "https://globalagro.com",
    "UserPersonId": 5,
    "InsertDate": "2025-06-15",
    "OrganizationId": 125
	
  }
]
'
EXEC SpAddressIns @json 

/**
--		Spare table just to check if SpAddressIns works or not

CREATE TABLE AddressCheck
(
	AddressId INT IDENTITY(111,1),
	Street NVARCHAR(200),
	City NVARCHAR(200),
	State NVARCHAR(200),
	ZipCode NVARCHAR(200),
	Country NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE
);

**/