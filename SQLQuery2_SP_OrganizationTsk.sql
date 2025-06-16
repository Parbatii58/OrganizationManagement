USE OrganizationInfo
GO

/**					Organization Tsk						**/
CREATE PROCEDURE SpOrganizationTsk
@json NVARCHAR(MAX) OUTPUT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @UserPerson INT = JSON_VALUE(@json, '$.UserPersonId');
			DECLARE @entity NVARCHAR(200) = JSON_VALUE(@json, '$.Entity');

			IF @UserPerson NOT IN (SELECT  UserPersonId FROM UserPerson)
			BEGIN
				RAISERROR('Invalid UserPerson',16,1)
				ROLLBACK;
			END

			IF @entity NOT IN ('NewCustomer', 'Company')
			BEGIN
				RAISERROR('Invalid entity', 16,1)
				ROLLBACK;
			END

			--Insert in organization
			EXEC SpOrganizationIns @json = @json OUTPUT;

			-- Insert in either NewCustomer or Company
			IF @entity= 'NewCustomer'
			BEGIN
				EXEC SpNewCustomerIns @json = @json OUTPUT
			END
			ELSE IF @entity = 'Company'
			BEGIN
				EXEC SpCompanyIns @json = @json OUTPUT
			END
			-- Insert in Address
			EXEC SpAddressIns @json = @json OUTPUT
			-- Insert in Contact
			EXEC SpContactIns @json = @json OUTPUT
			-- Insert in Address
			EXEC SpOrganizationAddressIns @json
			-- Insert in Address
			EXEC SpOrganizationContactIns @json
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
      "Parent": null,
      "Status": "Active",
      "OfficeLocation": "Kathmandu, Nepal",
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
