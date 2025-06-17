USE OrganizationInfo
GO

/**					Organization Tsk						**/
CREATE OR ALTER PROCEDURE SpOrganizationTsk
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
				EXEC SpNewCustomerIns @json
			END
			ELSE IF @entity = 'Company'
			BEGIN
				EXEC SpCompanyIns @json
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

		PRINT 'Error line is:		' + CAST(@Error_Line AS NVARCHAR);
		PRINT 'Error procedure is:  ' + ISNULL(@Error_Procedure, 'Unknown Procedure');
		PRINT 'Error message is:	' + @Error_Message;
		RAISERROR(@Error_Message, 16,1 );
	END CATCH
END

--	MAKE SURE the UserPerson ranges from 1 to 10
--  MAKE SURE the parent ranges from: 115 10 124
DECLARE @json NVARCHAR(MAX)=
N'
{
  "UserPersonId": 1,
  "Entity": "NewCustomer",
  "Data": [
    {
      "OrganizationName": "Dubai Trading Co.",
      "Department": "Sales",
      "Parent": null,
      "Status": "Active",
      "Street": "Al Rigga Street",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00000",
      "Country": "UAE",
      "PhoneNumber": "+971-4-1234567",
      "Email": "info@dubaitradingco.ae",
      "Website": "https://dubaitradingco.ae"
    },
    {
      "OrganizationName": "Emirates Logistics",
      "Department": "Logistics",
      "Parent": null,
      "Status": "Active",
      "Street": "Jebel Ali Free Zone",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00001",
      "Country": "UAE",
      "PhoneNumber": "+971-4-7654321",
      "Email": "contact@emirateslogistics.ae",
      "Website": "https://emirateslogistics.ae"
    },
    {
      "OrganizationName": "Dubai Tech Solutions",
      "Department": "IT",
      "Parent": null,
      "Status": "Active",
      "Street": "Dubai Internet City",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00002",
      "Country": "UAE",
      "PhoneNumber": "+971-4-2345678",
      "Email": "support@dubai-tech.ae",
      "Website": "https://dubai-tech.ae"
    },
    {
      "OrganizationName": "Gulf Marketing Group",
      "Department": "Marketing",
      "Parent": null,
      "Status": "Active",
      "Street": "Sheikh Zayed Road",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00003",
      "Country": "UAE",
      "PhoneNumber": "+971-4-9876543",
      "Email": "info@gulfmarketing.ae",
      "Website": "https://gulfmarketing.ae"
    },
    {
      "OrganizationName": "Dubai Food Supplies",
      "Department": "Procurement",
      "Parent": null,
      "Status": "Active",
      "Street": "Al Quoz Industrial Area",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00004",
      "Country": "UAE",
      "PhoneNumber": "+971-4-3344556",
      "Email": "contact@dubaifoodsupplies.ae",
      "Website": "https://dubaifoodsupplies.ae"
    },
    {
      "OrganizationName": "Emirates Construction",
      "Department": "Construction",
      "Parent": null,
      "Status": "Active",
      "Street": "Dubai Marina",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00005",
      "Country": "UAE",
      "PhoneNumber": "+971-4-6677889",
      "Email": "info@emiratesconstruction.ae",
      "Website": "https://emiratesconstruction.ae"
    },
    {
      "OrganizationName": "Dubai Real Estate Ltd.",
      "Department": "Real Estate",
      "Parent": null,
      "Status": "Active",
      "Street": "Business Bay",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00006",
      "Country": "UAE",
      "PhoneNumber": "+971-4-1239876",
      "Email": "info@dubairealestate.ae",
      "Website": "https://dubairealestate.ae"
    },
    {
      "OrganizationName": "Gulf Exporters",
      "Department": "Exports",
      "Parent": null,
      "Status": "Active",
      "Street": "Al Barsha",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00007",
      "Country": "UAE",
      "PhoneNumber": "+971-4-7894561",
      "Email": "contact@gulfexporters.ae",
      "Website": "https://gulfexporters.ae"
    },
    {
      "OrganizationName": "Dubai Travel Agency",
      "Department": "Travel",
      "Parent": null,
      "Status": "Active",
      "Street": "Deira",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00008",
      "Country": "UAE",
      "PhoneNumber": "+971-4-4561237",
      "Email": "info@dubaitravel.ae",
      "Website": "https://dubaitravel.ae"
    },
    {
      "OrganizationName": "Emirates Electronics",
      "Department": "Sales",
      "Parent": null,
      "Status": "Active",
      "Street": "Al Nahda",
      "City": "Dubai",
      "State": "Dubai",
      "ZipCode": "00009",
      "Country": "UAE",
      "PhoneNumber": "+971-4-3216549",
      "Email": "sales@emirateselectronics.ae",
      "Website": "https://emirateselectronics.ae"
    }
  ]
}
'

EXEC SpOrganizationTsk @json OUTPUT