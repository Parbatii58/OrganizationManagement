USE OrganizationInfo 
GO


DECLARE @json NVARCHAR(MAX)=N'
{
	"UserPersonId" : 4,
	"Entity": "NewCustomer",
	"Data":[
			{
			 "OrganizationName": "NovaEdge Solutions",
			 "Department": "Finance",
			 "Parent": 119,
			 "Status": "Inactive",
			 "Street": "540 Birch Boulevard",
			 "City": "Kathmandu",
			 "State": "Gandaki",
			 "ZipCode": "67459",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9828446697",
			 "Email": "user1@example.com",
			 "Website": "www.technova.com"
			},
			{
			 "OrganizationName": "GreenField Group",
			 "Department": "Finance",
			 "Parent": 119,
			 "Status": "Active",
			 "Street": "736 Pine Avenue",
			 "City": "Kathmandu",
			 "State": "Bagmati",
			 "ZipCode": "54540",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9800961660",
			 "Email": "user2@example.com",
			 "Website": "www.greenfield.com"
			},
			{
			 "OrganizationName": "BlueSky Inc",
			 "Department": "IT",
			 "Parent": 120,
			 "Status": "Inactive",
			 "Street": "323 Birch Boulevard",
			 "City": "Bhaktapur",
			 "State": "Lumbini",
			 "ZipCode": "78264",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9845859355",
			 "Email": "user3@demo.net",
			 "Website": "www.greenfield.com"
			},
			{
			 "OrganizationName": "NovaEdge Solutions",
			 "Department": "Finance",
			 "Parent": 119,
			 "Status": "Inactive",
			 "Street": "319 Cedar Lane",
			 "City": "Kathmandu",
			 "State": "Province No.1",
			 "ZipCode": "39038",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9816588976",
			 "Email": "user4@example.com",
			 "Website": "www.technova.com"
			},
			{
			 "OrganizationName": "BlueSky Inc",
			 "Department": "HR",
			 "Parent": 124,
			 "Status": "Active",
			 "Street": "104 Pine Avenue",
			 "City": "Bhaktapur",
			 "State": "Bagmati",
			 "ZipCode": "38171",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9864278012",
			 "Email": "user5@sample.org",
			 "Website": "www.greenfield.com"
			},
			{
			 "OrganizationName": "BlueSky Inc",
			 "Department": "Operations",
			 "Parent": 121,
			 "Status": "Inactive",
			 "Street": "875 Maple Road",
			 "City": "Bhaktapur",
			 "State": "Province No.1",
			 "ZipCode": "89016",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9854188454",
			 "Email": "user6@sample.org",
			 "Website": "www.bluesky.com"
			},
			{
			 "OrganizationName": "BlueSky Inc",
			 "Department": "HR",
			 "Parent": 117,
			 "Status": "Inactive",
			 "Street": "697 Oak Street",
			 "City": "Biratnagar",
			 "State": "Province No.1",
			 "ZipCode": "22557",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9875276005",
			 "Email": "user7@sample.org",
			 "Website": "www.bluesky.com"
			},
			{
			 "OrganizationName": "TechNova Corp",
			 "Department": "Marketing",
			 "Parent": 117,
			 "Status": "Active",
			 "Street": "445 Birch Boulevard",
			 "City": "Pokhara",
			 "State": "Province No.1",
			 "ZipCode": "82961",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9877889953",
			 "Email": "user8@example.com",
			 "Website": "www.novaedge.com"
			},
			{
			 "OrganizationName": "BlueSky Inc",
			 "Department": "Finance",
			 "Parent": 121,
			 "Status": "Active",
			 "Street": "760 Cedar Lane",
			 "City": "Kathmandu",
			 "State": "Bagmati",
			 "ZipCode": "66836",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9826239364",
			 "Email": "user9@sample.org",
			 "Website": "www.brightstar.com"
			},
			{
			 "OrganizationName": "NovaEdge Solutions",
			 "Department": "Operations",
			 "Parent": 120,
			 "Status": "Active",
			 "Street": "191 Pine Avenue",
			 "City": "Pokhara",
			 "State": "Lumbini",
			 "ZipCode": "39394",
			 "Country": "Nepal",
			 "PhoneNumber": "+977-9828375623",
			 "Email": "user10@demo.net",
			 "Website": "www.technova.com"
			}
			]
}
'
EXEC SpOrganizationTsk @json = @json;
