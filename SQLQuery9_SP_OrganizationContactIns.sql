USE OrganizationInfo
GO

/**					Company Ins						**/
CREATE OR ALTER PROCEDURE SpOrganizationContactIns
@json NVARCHAR(MAX) OUTPUT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		CREATE TABLE #temp
		(
			OrganizationId INT,
			ContactId INT
		);
		INSERT INTO #temp(OrganizationId, ContactId)
		SELECT OrganizationId, ContactId
		FROM OPENJSON(@json)
		WITH
		(
			OrganizationId INT,
			ContactId INT
		);
		DECLARE @insertOc TABLE
		(
			OrganizationContactId INT ,
			OrganizationId INT,
			ContactId INT
		);
		INSERT INTO OrganizationContact(OrganizationId, ContactId)
		OUTPUT INSERTED.* INTO @insertOc
		SELECT OrganizationId, ContactId 
		FROM #temp;

		SELECT * FROM @insertOc;
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
EXEC SpOrganizationContactIns @json
print @json

/**

CREATE TABLE OrganizationContactCheck
(
	OrganizationContactId INT IDENTITY(111,1),
	OrganizationId INT,
	ContactId INT
)

**/