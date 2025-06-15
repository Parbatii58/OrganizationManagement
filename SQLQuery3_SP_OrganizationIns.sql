USE OrganizationInfo
GO


/**					Organization Insert						**/


CREATE OR ALTER PROCEDURE SpOrganizationIns
@json NVARCHAR(MAX) OUTPUT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @UserPersonId INT = JSON_VALUE(@json, '$.UserPersonId');
			-- temporary table to populate json value
			CREATE TABLE #temp
			(
				OrganizationName NVARCHAR(200),
				Department NVARCHAR(200),
				Parent INT NULL,
				Root INT NULL,
				Status NVARCHAR(200),
				Street NVARCHAR(200),
				City NVARCHAR(200),
				State NVARCHAR(200),
				ZipCode NVARCHAR(200),
				Country NVARCHAR(200),
				PhoneNumber NVARCHAR(200),
				Email NVARCHAR(200),
				Website NVARCHAR(200),
				UserPersonId INT,
				InsertDate DATE
			);
			-- populate in the #temp table
			INSERT INTO #temp (OrganizationName, Department, Parent, Status, Street, City, State, ZipCode, Country, PhoneNumber, Email, Website, UserPersonId, InsertDate)
			SELECT DISTINCT OrganizationName, Department, Parent, Status, Street, City, State, ZipCode, Country, PhoneNumber, Email, Website, @UserPersonId, GETDATE()
			FROM OPENJSON(@json, '$.Data')
			WITH
			(
				OrganizationName NVARCHAR(200),
				Department NVARCHAR(200),
				Parent INT,
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
			DECLARE @insertOrg TABLE 
			(
				OrganizationId INT,
				OrganizationName NVARCHAR(200),
				Department	NVARCHAR(200),
				Parent INT NULL,
				ROOT INT NULL,
				Status NVARCHAR(200),
				UserPersonId INT,
				InsertDate DATE
			);
			-- inserting values in organization 
			INSERT INTO Organization(OrganizationName, Department, Parent, ROOT, Status, UserPersonId, InsertDate)
			OUTPUT INSERTED.* INTO @insertOrg
			SELECT t.OrganizationName, t.Department, t.Parent, NULL, t.Status, t.UserPersonId, t.InsertDate
			FROM #temp t
			WHERE NOT EXISTS
			(
				SELECT 1 FROM Organization o
				WHERE o.OrganizationName = t.OrganizationName
				AND o.Department = t.Department
				AND ((o.Parent = t.Parent) OR (o.Parent IS NULL AND t.Parent IS NULL))
				AND o.Status = t.Status
			)
			-- Since the root is Null so we update it in the table
			UPDATE o
			SET Root = ISNULL(oo.Root, o.OrganizationId)
			FROM Organization o
			JOIN @insertOrg i
			ON o.OrganizationId = i.OrganizationId
			LEFT JOIN Organization oo
			ON o.OrganizationId = oo.Parent
			--update root in @insertorg table
			UPDATE i
			SET i.Root = o.Root
			FROM Organization o 
			JOIN @insertOrg i
			ON i.OrganizationId = o.OrganizationId
			-- adding organizationid in the json in order to pass it to other tables
			SET @json = (SELECT t.* , i.OrganizationId
							FROM #temp t INNER JOIN @insertOrg i 
							ON i.OrganizationName = t.OrganizationName 
							AND i.Department = t.Department 
							AND i.Parent = t.Parent
							AND i.Status = t.Status
							FOR JSON PATH
							);
			-- it is compulsory to drop #temp table
			DROP TABLE #temp;
			SELECT * FROM @insertOrg;
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



-- Make sure the userperson id must be from 1 to 10

DECLARE @json NVARCHAR(MAX)=
N'
{
  "UserPersonId": 1,
  "Entity": "NewCustomer",
  "Data": [
    {
      "OrganizationName": "Everest Traders",
      "Department": "Sales",
      "Parent": 102,
      "Status": "Active",
      "Street": "New Road",
      "City": "Kathmandu",
      "State": "Bagmati",
      "ZipCode": "44600",
      "Country": "Nepal",
      "PhoneNumber": "+977-1-1234567",
      "Email": "info@everesttraders.com",
      "Website": "https://everestrader.com"
    }
  ]
}
'



/**
-- I created this table to check if the SpOrganizationIns works or not

CREATE TABLE OrganizationCheck
(
	OrganizationId INT IDENTITY(101,1) PRIMARY KEY,
	OrganizationName NVARCHAR(200),
	Department	NVARCHAR(200),
	Parent INT NULL,
	ROOT INT  NULL,
	Status NVARCHAR(200),
	UserPersonId INT,
	InsertDate DATE
);

SELECT * FROM OrganizationCheck

**/