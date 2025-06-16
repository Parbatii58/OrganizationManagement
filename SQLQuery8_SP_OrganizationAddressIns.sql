USE OrganizationInfo
GO

/**					Organization Address Ins						**/
CREATE OR ALTER PROCEDURE SpOrganizationAddressIns
@json NVARCHAR(MAX) OUTPUT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		CREATE TABLE #temp
		(
			OrganizationId INT,
			AddressId INT
		);
		INSERT INTO #temp(OrganizationId, AddressId)
		SELECT OrganizationId, AddressId
		FROM OPENJSON(@json)
		WITH
		(
			OrganizationId INT,
			AddressId INT
		);
		DECLARE @insertOA TABLE
		(
		OrganizationAddressId INT,
		OrganizationId INT,
		AddressId INT
		);
		INSERT INTO OrganizationAddress(OrganizationId, AddressId)
		OUTPUT INSERTED.* INTO @insertOA
		SELECT OrganizationId, AddressId
		FROM #temp;

		SELECT * FROM @insertOA;

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

		PRINT 'Error line is:		' + CAST(@Error_Line AS NVARCHAR);
		PRINT 'Error procedure is:  ' + ISNULL(@Error_Procedure, 'Unknown Procedure');
		PRINT 'Error message is:	' + @Error_Message;
		RAISERROR(@Error_Message, 16,1 );
	END CATCH
END




DECLARE @json NVARCHAR(MAX)=
N'
[
  {
    "ContactId": 5,
    "OrganizationId": 101,
    "AddressId": 111,
    "PhoneNumber": "+977-1-6677889",
    "Email": "logistics@himalayanfreight.com",
    "Website": "https://himalayanfreight.com",
    "UserPersonId": 5
  },
  {
    "ContactId": 6,
    "OrganizationId": 111,
    "AddressId": 112,
    "PhoneNumber": "+977-1-4433221",
    "Email": "contact@globalagro.com",
    "Website": "https://globalagro.com",
    "UserPersonId": 5
  }
]
'
EXEC SpOrganizationAddressIns @json
print @json


/**
--		to check either SpOrganizationAddressIns works or not
CREATE TABLE OrganizationAddressCheck
(
	OrganizationAddressId INT IDENTITY(201,1),
	OrganizationId INT,
	AddressId INT
)

**/