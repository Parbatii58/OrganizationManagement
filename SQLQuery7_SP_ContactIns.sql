USE OrganizationInfo
GO

/**					Contact Ins						**/
CREATE OR ALTER PROCEDURE SpContactIns
@json NVARCHAR(MAX) OUTPUT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		CREATE TABLE #temp
		(
			OrganizationId INT,
			AddressId INT,
			PhoneNumber NVARCHAR(200),
			Email NVARCHAR(200),
			Website NVARCHAR(200),
			UserPersonId INT,
			InsertDate DATE
		);

		INSERT INTO #temp(OrganizationId, AddressId, PhoneNumber, Email, Website, UserPersonId, InsertDate)
		SELECT OrganizationId, AddressId, PhoneNumber, Email, Website, UserPersonId, InsertDate
		FROM OPENJSON(@json)
		WITH
		(
			OrganizationId INT,
			AddressId INT,
			PhoneNumber NVARCHAR(200),
			Email NVARCHAR(200),
			Website NVARCHAR(200),
			UserPersonId INT,
			InsertDate DATE
		)

		DECLARE @insertContact  TABLE 
		(
			ContactId INT,
			PhoneNumber NVARCHAR(200),
			Email NVARCHAR(200),
			Website NVARCHAR(200),
			UserPersonId INT,
			InsertDate DATE
		);
		
		INSERT INTO Contact(PhoneNumber, Email, Website, UserPersonId, InsertDate)
		OUTPUT INSERTED.* INTO @insertContact
		SELECT PhoneNumber, Email, Website, UserPersonId, GETDATE()
		FROM #temp;

		SET @json = (SELECT i.ContactId, t.*
					FROM #temp t JOIN @insertContact i
					ON t.PhoneNumber = i.PhoneNumber
					AND t.Email = i.Email
					AND t.Website = i.Website
					FOR JSON PATH
					);

		SELECT * FROM @insertContact;

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
    "OrganizationId": 101,
    "Street": "Kalanki",
    "City": "Butwal",
    "State": "Baneshowor",
    "ZipCode": "4002",
    "Country": "Nepal",
    "PhoneNumber": "+977-1-6677889",
    "Email": "logistics@himalayanfreight.com",
    "Website": "https://himalayanfreight.com",
    "UserPersonId": 5,
    "AddressId": 111
  },
  {
    "OrganizationId": 111,
    "Street": "Maitidevi",
    "City": "Pokhara",
    "State": "TTT",
    "ZipCode": "480001",
    "Country": "Nepal",
    "PhoneNumber": "+977-1-4433221",
    "Email": "contact@globalagro.com",
    "Website": "https://globalagro.com",
    "UserPersonId": 5,
    "AddressId": 112
  }
]
'
EXEC SpContactIns @json OUTPUT
PRINT @json




/**
--		Spare table just to check if SpContactIns works or not
CREATE TABLE ContactCheck
(
	ContactId INT IDENTITY(1,1) ,
	PhoneNumber NVARCHAR(200),
	Email NVARCHAR(200),
	Website NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE
);

**/