USE OrganizationInfo
GO
--	MAKE SURE the UserPerson ranges from 1 to 10
--  MAKE SURE the parent ranges from: 115 10 124
--		SELECT * FROM Organization


DECLARE @json NVARCHAR(MAX)=
N'
{
  "UserPersonId": 5,
  "Entity": "NewCustomer",
  "Data": [
    {
      "OrganizationName": "London Tech Hub",
      "Department": "IT",
      "Parent": 118,
      "Status": "Active",
      "Street": "Old Street",
      "City": "London",
      "State": "England",
      "ZipCode": "EC1V",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-20-79460001",
      "Email": "info@londontechhub.co.uk",
      "Website": "https://londontechhub.co.uk"
    },
    {
      "OrganizationName": "Manchester Logistics Ltd.",
      "Department": "Logistics",
      "Parent": 120,
      "Status": "Inactive",
      "Street": "Oxford Road",
      "City": "Manchester",
      "State": "England",
      "ZipCode": "M13",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-161-1234567",
      "Email": "contact@manlogistics.co.uk",
      "Website": "https://manlogistics.co.uk"
    },
    {
      "OrganizationName": "Glasgow Marketing Group",
      "Department": "Marketing",
      
      "Status": "Active",
      "Street": "Sauchiehall Street",
      "City": "Glasgow",
      "State": "Scotland",
      "ZipCode": "G2",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-141-8765432",
      "Email": "info@glasgowmarketing.co.uk",
      "Website": "https://glasgowmarketing.co.uk"
    },
    {
      "OrganizationName": "Birmingham Engineering Services",
      "Department": "Engineering",
      "Parent": 129,
      "Status": "Pending",
      "Street": "New Street",
      "City": "Birmingham",
      "State": "England",
      "ZipCode": "B2",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-121-8888888",
      "Email": "info@bhameng.co.uk",
      "Website": "https://bhameng.co.uk"
    },
    {
      "OrganizationName": "Leeds Creative Agency",
      "Department": "Design",
      "Parent": 131,
      "Status": "Archived",
      "Street": "The Headrow",
      "City": "Leeds",
      "State": "England",
      "ZipCode": "LS1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-113-7654321",
      "Email": "hello@leedscreative.co.uk",
      "Website": "https://leedscreative.co.uk"
    },
    {
      "OrganizationName": "Edinburgh Publishing House",
      "Department": "Publishing",
      "Parent": 137,
      "Status": "Active",
      "Street": "Princes Street",
      "City": "Edinburgh",
      "State": "Scotland",
      "ZipCode": "EH1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-131-9988776",
      "Email": "info@edinpub.co.uk",
      "Website": "https://edinpub.co.uk"
    },
    {
      "OrganizationName": "Cardiff Health Group",
      "Department": "Healthcare",
      
      "Status": "Pending",
      "Street": "Queen Street",
      "City": "Cardiff",
      "State": "Wales",
      "ZipCode": "CF10",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-29-12345678",
      "Email": "support@cardiffhealth.co.uk",
      "Website": "https://cardiffhealth.co.uk"
    },
    {
      "OrganizationName": "Belfast Tech Solutions",
      "Department": "IT",
      "Parent": 133,
      "Status": "Inactive",
      "Street": "Royal Avenue",
      "City": "Belfast",
      "State": "Northern Ireland",
      "ZipCode": "BT1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-28-7654321",
      "Email": "info@belfasttech.co.uk",
      "Website": "https://belfasttech.co.uk"
    },
    {
      "OrganizationName": "Liverpool Maritime Co.",
      "Department": "Shipping",
      "Parent": 139,
      "Status": "Active",
      "Street": "Albert Dock",
      "City": "Liverpool",
      "State": "England",
      "ZipCode": "L3",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-151-1122334",
      "Email": "marine@liverpoolmaritime.co.uk",
      "Website": "https://liverpoolmaritime.co.uk"
    },
    {
      "OrganizationName": "Sheffield Finance Group",
      "Department": "Finance",
      "Parent": 117,
      "Status": "Archived",
      "Street": "High Street",
      "City": "Sheffield",
      "State": "England",
      "ZipCode": "S1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-114-5566778",
      "Email": "finance@sheffieldgroup.co.uk",
      "Website": "https://sheffieldgroup.co.uk"
    },
    {
      "OrganizationName": "Oxford Research Institute",
      "Department": "Research",
      "Parent": 140,
      "Status": "Active",
      "Street": "Broad Street",
      "City": "Oxford",
      "State": "England",
      "ZipCode": "OX1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-1865-123456",
      "Email": "info@oxfordresearch.co.uk",
      "Website": "https://oxfordresearch.co.uk"
    },
    {
      "OrganizationName": "Cambridge BioTech",
      "Department": "Biotech",
     
      "Status": "Pending",
      "Street": "Trinity Lane",
      "City": "Cambridge",
      "State": "England",
      "ZipCode": "CB2",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-1223-987654",
      "Email": "info@cambridgebiotech.co.uk",
      "Website": "https://cambridgebiotech.co.uk"
    },
    {
      "OrganizationName": "Brighton Tourism Board",
      "Department": "Travel",
      "Parent": 116,
      "Status": "Inactive",
      "Street": "Kings Road",
      "City": "Brighton",
      "State": "England",
      "ZipCode": "BN1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-1273-321654",
      "Email": "contact@brightontourism.co.uk",
      "Website": "https://brightontourism.co.uk"
    },
    {
      "OrganizationName": "York Heritage Foundation",
      "Department": "History",
      "Parent": 128,
      "Status": "Active",
      "Street": "Micklegate",
      "City": "York",
      "State": "England",
      "ZipCode": "YO1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-1904-112233",
      "Email": "info@yorkheritage.co.uk",
      "Website": "https://yorkheritage.co.uk"
    },
    {
      "OrganizationName": "Nottingham Robotics Ltd.",
      "Department": "Engineering",
      "Parent": 135,
      "Status": "Archived",
      "Street": "Talbot Street",
      "City": "Nottingham",
      "State": "England",
      "ZipCode": "NG1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-115-334455",
      "Email": "info@nottsrobotics.co.uk",
      "Website": "https://nottsrobotics.co.uk"
    },
    {
      "OrganizationName": "Southampton Shipping Lines",
      "Department": "Logistics",
      "Parent": 141,
      "Status": "Pending",
      "Street": "Town Quay",
      "City": "Southampton",
      "State": "England",
      "ZipCode": "SO14",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-2380-998877",
      "Email": "contact@southamptonshipping.co.uk",
      "Website": "https://southamptonshipping.co.uk"
    },
    {
      "OrganizationName": "Reading Green Energy",
      "Department": "Energy",
      "Parent": 138,
      "Status": "Active",
      "Street": "Friar Street",
      "City": "Reading",
      "State": "England",
      "ZipCode": "RG1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-118-765432",
      "Email": "energy@readinggreen.co.uk",
      "Website": "https://readinggreen.co.uk"
    },
    {
      "OrganizationName": "Plymouth Marine Tech",
      "Department": "Marine",
      "Parent": 119,
      "Status": "Inactive",
      "Street": "Union Street",
      "City": "Plymouth",
      "State": "England",
      "ZipCode": "PL1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-1752-998877",
      "Email": "info@plymouthmarine.co.uk",
      "Website": "https://plymouthmarine.co.uk"
    },
    {
      "OrganizationName": "Derby Rail Co.",
      "Department": "Transport",
      "Parent": 126,
      "Status": "Active",
      "Street": "Station Approach",
      "City": "Derby",
      "State": "England",
      "ZipCode": "DE1",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-1332-223344",
      "Email": "info@derbyrail.co.uk",
      "Website": "https://derbyrail.co.uk"
    },
    {
      "OrganizationName": "Luton Airport Services",
      "Department": "Aviation",
      
      "Status": "Pending",
      "Street": "Airport Way",
      "City": "Luton",
      "State": "England",
      "ZipCode": "LU2",
      "Country": "United Kingdom",
      "PhoneNumber": "+44-1582-556677",
      "Email": "support@lutonairport.co.uk",
      "Website": "https://lutonairport.co.uk"
    }
  ]
}
'

EXEC SpOrganizationTsk @json OUTPUT