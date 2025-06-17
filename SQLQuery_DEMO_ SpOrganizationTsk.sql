USE OrganizationInfo
GO
--	MAKE SURE the UserPerson ranges from 1 to 10
--  MAKE SURE the parent ranges from: 185 10 225
--		SELECT * FROM Organization 

--FOR entity-NewCustomer
DECLARE @json NVARCHAR(MAX)=
N'
{
  "UserPersonId": 7,
  "Entity": "NewCustomer",
  "Data": [
    {
      "OrganizationName": "SZ TechWorks",
      "Department": "Engineering",
     
      "Status": "Active",
      "Street": "Innovation Rd",
      "City": "Shenzhen",
      "State": "Guangdong",
      "ZipCode": "518000",
      "Country": "China",
      "PhoneNumber": "+86-755-12345678",
      "Email": "info@sztechworks.cn",
      "Website": "https://sztechworks.cn"
    },
    {
      "OrganizationName": "BJ MarketReach",
      "Department": "Marketing",
      "Parent": 186,
      "Status": "Pending",
      "Street": "Market St",
      "City": "Beijing",
      "State": "Beijing",
      "ZipCode": "100000",
      "Country": "China",
      "PhoneNumber": "+86-10-87654321",
      "Email": "contact@bjmarket.cn",
      "Website": "https://bjmarket.cn"
    },
    {
      "OrganizationName": "SH BioSolutions",
      "Department": "Biotech",
      "Parent": 202,
      "Status": "Active",
      "Street": "Science Park",
      "City": "Shanghai",
      "State": "Shanghai",
      "ZipCode": "200120",
      "Country": "China",
      "PhoneNumber": "+86-21-12341234",
      "Email": "info@shbiosol.cn",
      "Website": "https://shbiosol.cn"
    },
    {
      "OrganizationName": "GZ Transport Tech",
      "Department": "Transportation",
      "Parent": 188,
      "Status": "Active",
      "Street": "Transit Ave",
      "City": "Guangzhou",
      "State": "Guangdong",
      "ZipCode": "510000",
      "Country": "China",
      "PhoneNumber": "+86-20-22334455",
      "Email": "hello@gztransport.cn",
      "Website": "https://gztransport.cn"
    },
    {
      "OrganizationName": "NJ Softworks",
      "Department": "IT",
      "Parent": 202,
      "Status": "Pending",
      "Street": "Code Lane",
      "City": "Nanjing",
      "State": "Jiangsu",
      "ZipCode": "210000",
      "Country": "China",
      "PhoneNumber": "+86-25-33445566",
      "Email": "support@njsoft.cn",
      "Website": "https://njsoft.cn"
    },
    {
      "OrganizationName": "HZ SmartTech",
      "Department": "Research",
      
      "Status": "Active",
      "Street": "AI Street",
      "City": "Hangzhou",
      "State": "Zhejiang",
      "ZipCode": "310000",
      "Country": "China",
      "PhoneNumber": "+86-571-11223344",
      "Email": "ai@hzsmart.cn",
      "Website": "https://hzsmart.cn"
    },
    {
      "OrganizationName": "XM Ocean Systems",
      "Department": "Marine",
      "Parent": 200,
      "Status": "Active",
      "Street": "Harbor Rd",
      "City": "Xiamen",
      "State": "Fujian",
      "ZipCode": "361000",
      "Country": "China",
      "PhoneNumber": "+86-592-22334455",
      "Email": "contact@xmocean.cn",
      "Website": "https://xmocean.cn"
    },
    {
      "OrganizationName": "CD Environmental",
      "Department": "Environment",
      "Parent": 185,
      "Status": "Pending",
      "Street": "Eco Street",
      "City": "Chengdu",
      "State": "Sichuan",
      "ZipCode": "610000",
      "Country": "China",
      "PhoneNumber": "+86-28-33445566",
      "Email": "info@cdgreen.cn",
      "Website": "https://cdgreen.cn"
    },
    {
      "OrganizationName": "TJ Freight Co",
      "Department": "Logistics",
      "Parent": 204,
      "Status": "Active",
      "Street": "Logistics Blvd",
      "City": "Tianjin",
      "State": "Tianjin",
      "ZipCode": "300000",
      "Country": "China",
      "PhoneNumber": "+86-22-44556677",
      "Email": "logistics@tjfreight.cn",
      "Website": "https://tjfreight.cn"
    },
    {
      "OrganizationName": "WH MedTech",
      "Department": "Medical",
      "Parent": 199,
      "Status": "Active",
      "Street": "Health Ave",
      "City": "Wuhan",
      "State": "Hubei",
      "ZipCode": "430000",
      "Country": "China",
      "PhoneNumber": "+86-27-55667788",
      "Email": "contact@whmedtech.cn",
      "Website": "https://whmedtech.cn"
    },
    {
      "OrganizationName": "CQ Construction",
      "Department": "Construction",
      "Parent": 190,
      "Status": "Active",
      "Street": "Builder St",
      "City": "Chongqing",
      "State": "Chongqing",
      "ZipCode": "400000",
      "Country": "China",
      "PhoneNumber": "+86-23-77889900",
      "Email": "info@cqconstruct.cn",
      "Website": "https://cqconstruct.cn"
    },
    {
      "OrganizationName": "DL Manufacturing",
      "Department": "Manufacturing",
     
      "Status": "Pending",
      "Street": "Industry Rd",
      "City": "Dalian",
      "State": "Liaoning",
      "ZipCode": "116000",
      "Country": "China",
      "PhoneNumber": "+86-411-88990011",
      "Email": "contact@dlmfg.cn",
      "Website": "https://dlmfg.cn"
    },
    {
      "OrganizationName": "SJ Electronics",
      "Department": "Electronics",
      "Parent": 196,
      "Status": "Active",
      "Street": "Tech Park",
      "City": "Suzhou",
      "State": "Jiangsu",
      "ZipCode": "215000",
      "Country": "China",
      "PhoneNumber": "+86-512-99887766",
      "Email": "support@sjele.cn",
      "Website": "https://sjele.cn"
    },
    {
      "OrganizationName": "FZ Textile",
      "Department": "Textiles",
      
      "Status": "Active",
      "Street": "Fabric Ave",
      "City": "Fuzhou",
      "State": "Fujian",
      "ZipCode": "350000",
      "Country": "China",
      "PhoneNumber": "+86-591-66554433",
      "Email": "info@fztextile.cn",
      "Website": "https://fztextile.cn"
    },
    {
      "OrganizationName": "NN Food Corp",
      "Department": "Food",
      
      "Status": "Active",
      "Street": "Food Street",
      "City": "Nanning",
      "State": "Guangxi",
      "ZipCode": "530000",
      "Country": "China",
      "PhoneNumber": "+86-771-33445566",
      "Email": "contact@nnfood.cn",
      "Website": "https://nnfood.cn"
    },
    {
      "OrganizationName": "XZ Logistics",
      "Department": "Logistics",
   
      "Status": "Pending",
      "Street": "Freight Rd",
      "City": "Xuzhou",
      "State": "Jiangsu",
      "ZipCode": "221000",
      "Country": "China",
      "PhoneNumber": "+86-516-22334455",
      "Email": "info@xzlogistics.cn",
      "Website": "https://xzlogistics.cn"
    },
    {
      "OrganizationName": "HK Digital Media",
      "Department": "Media",
      "Parent": 188,
      "Status": "Active",
      "Street": "Media Ave",
      "City": "Haikou",
      "State": "Hainan",
      "ZipCode": "570000",
      "Country": "China",
      "PhoneNumber": "+86-898-33442211",
      "Email": "media@hkdigital.cn",
      "Website": "https://hkdigital.cn"
    },
    {
      "OrganizationName": "JX Mining",
      "Department": "Mining",
      "Parent": 189,
      "Status": "Active",
      "Street": "Miner Rd",
      "City": "Jixi",
      "State": "Heilongjiang",
      "ZipCode": "158100",
      "Country": "China",
      "PhoneNumber": "+86-468-55667788",
      "Email": "contact@jxmining.cn",
      "Website": "https://jxmining.cn"
    },
    {
      "OrganizationName": "YN Pharmaceuticals",
      "Department": "Pharmaceuticals",
      "Parent": 185,
      "Status": "Pending",
      "Street": "Health Blvd",
      "City": "Kunming",
      "State": "Yunnan",
      "ZipCode": "650000",
      "Country": "China",
      "PhoneNumber": "+86-871-22334455",
      "Email": "info@ynpharma.cn",
      "Website": "https://ynpharma.cn"
    },
    {
      "OrganizationName": "LZ Renewable Energy",
      "Department": "Energy",
      
      "Status": "Active",
      "Street": "Solar St",
      "City": "Lanzhou",
      "State": "Gansu",
      "ZipCode": "730000",
      "Country": "China",
      "PhoneNumber": "+86-931-77889900",
      "Email": "contact@lzrenew.cn",
      "Website": "https://lzrenew.cn"
    }
  ]
}

'

EXEC SpOrganizationTsk @json OUTPUT


-- FOR entity- Company


DECLARE @json NVARCHAR(MAX)=
N'
{
  "UserPersonId": 4,
  "Entity": "Company",
  "Data": [
    {
      "CompanyName": "Druk AgroTech",
      "OrganizationName": "Bhutan Green Growers",
      "Department": "Agriculture",
      "Parent": 186,
      "Status": "Active",
      "Street": "Farmland Road",
      "City": "Punakha",
      "State": "Punakha",
      "ZipCode": "14001",
      "Country": "Bhutan",
      "PhoneNumber": "+975-8-223344",
      "Email": "contact@drukagro.bt",
      "Website": "https://drukagro.bt"
    },
    {
      "CompanyName": "Bhutan Media House",
      "OrganizationName": "Druk News Network",
      "Department": "Media",
      "Parent": 188,
      "Status": "Pending",
      "Street": "Press Lane",
      "City": "Thimphu",
      "State": "Thimphu",
      "ZipCode": "11005",
      "Country": "Bhutan",
      "PhoneNumber": "+975-2-998877",
      "Email": "editor@druknews.bt",
      "Website": "https://druknews.bt"
    },
    {
      "CompanyName": "Himalayan Handicrafts",
      "OrganizationName": "Bhutan Artisans Guild",
      "Department": "Handicrafts",
      "Parent": 190,
      "Status": "Active",
      "Street": "Crafts Avenue",
      "City": "Wangdue Phodrang",
      "State": "Wangdue",
      "ZipCode": "12002",
      "Country": "Bhutan",
      "PhoneNumber": "+975-3-667788",
      "Email": "sales@bhutancrafts.bt",
      "Website": "https://bhutancrafts.bt"
    },
    {
      "CompanyName": "SnowLion TechWorks",
      "OrganizationName": "Bhutan Tech Innovators",
      "Department": "Technology",
      "Parent": 192,
      "Status": "Active",
      "Street": "Innovation Park",
      "City": "Gelephu",
      "State": "Sarpang",
      "ZipCode": "36001",
      "Country": "Bhutan",
      "PhoneNumber": "+975-6-334455",
      "Email": "info@snowliontech.bt",
      "Website": "https://snowliontech.bt"
    },
    {
      "CompanyName": "Zangto Pelri Wellness",
      "OrganizationName": "Bhutan Healing Center",
      "Department": "Healthcare",
      
      "Status": "Pending",
      "Street": "Healing Street",
      "City": "Samdrup Jongkhar",
      "State": "Samdrup",
      "ZipCode": "39001",
      "Country": "Bhutan",
      "PhoneNumber": "+975-7-445566",
      "Email": "care@zangtopelri.bt",
      "Website": "https://zangtopelri.bt"
    },
    {
      "CompanyName": "Thunder Dragon Solutions",
      "OrganizationName": "Bhutan Infrastructure Group",
      "Department": "Construction",
      "Parent": 196,
      "Status": "Active",
      "Street": "Builders Way",
      "City": "Phuentsholing",
      "State": "Chukha",
      "ZipCode": "21005",
      "Country": "Bhutan",
      "PhoneNumber": "+975-5-778899",
      "Email": "info@tdsolutions.bt",
      "Website": "https://tdsolutions.bt"
    },
    {
      "CompanyName": "Blue Sky Exports",
      "OrganizationName": "Bhutan International Traders",
      "Department": "Export",
      
      "Status": "Pending",
      "Street": "Trade Zone",
      "City": "Mongar",
      "State": "Mongar",
      "ZipCode": "43001",
      "Country": "Bhutan",
      "PhoneNumber": "+975-4-112233",
      "Email": "export@bluesky.bt",
      "Website": "https://bluesky.bt"
    }
  ]
}


'
EXEC SpOrganizationTsk @json OUTPUT


SELECT * FROM Organization where Parent = 164