---
title: "Crayon CloudIQ SDK for Python"
date: 2023-02-20
draft: false

tags: ["Python", "REST API", "PyPi"]
showEdit: false
showTaxonomies: true
---
# **Crayon CloudIQ SDK for Python**

This project is an SDK for Crayon's CloudIQ API that can be used in Python
scripts and applications. Provides a simple interface to authenticate with 
the API using Oauth2. It can be used to create tenants, create licensing subscriptions,
and monitor billing. Anything that can be done in the Cloud-IQ portal can be automated 
using this package. 

Includes several preconfigured data schema and API methods.
Custom blocks of data can be posted to the API as Python dictionaries. REST methods: 
GET, POST, PATCH, PUT, and DELETE can be called with an API endpoint and data dictionary as arguments. 

PyPi: https://pypi.org/project/crayon-cloudiq-sdk/ 
GitHub: https://github.com/blastomussa/crayon-python-sdk

## **Installation**

1. Install the crayon-cloudiq-sdk package with the following command:
	```
	pip install crayon-cloudiq-sdk
	```

## **Setup**
How to Create Cloud-IQ API Client Credentials

1. Login to Cloud IQ
2. Choose Manage -> API Management from the top menu
3. Press the + Add Client button
4. Choose a name of the client
5. Choose Resource Flow as the authentication type
6. Save the Client ID and the Client Secret 

## **Usage**

1. Create a new python script

2. Import the CloudIQ class
	```
	from cloudiq import CloudIQ
	```

3. Initialize an instance of the CloudIQ class with valid user credentials:
	```
	from cloudiq import CloudIQ

	CLIENT_ID = xxxxxxx-xxxx-xxxx-xxxx-xxxxxx
	CLIENT_SECRET = xxxxxxx-xxxx-xxxx-xxxx-xxxxxx
	USERNAME = "example@example.com"
	PASSWORD = "Password123456"

	crayon_api = CloudIQ(CLIENT_ID,CLIENT_SECRET,USERNAME,PASSWORD)
	```
	**The prefered way of importing credentials is through ENV variables.**
	```
	from os import getenv
	from cloudiq import CloudIQ

	CLIENT_ID = getenv('CLIENT_ID')
	CLIENT_SECRET = getenv('CLIENT_SECRET')
	USERNAME = getenv('CLOUDIQ_USER')
	PASSWORD = getenv('CLOUDIQ_PW')

	crayon_api = CloudIQ(CLIENT_ID,CLIENT_SECRET,USERNAME,PASSWORD)
	```
	ENV variables can be set using various methods including injection if using containers and pipelines or through a secrets manager such as Azure KeyVault. To set them on a local system using bash run the following commands:
	```
	export CLIENT_ID="xxxxxxx-xxxx-xxxx-xxxx-xxxxxx"
	export CLIENT_SECRET="xxxxxxx-xxxx-xxxx-xxxx-xxxxxx"
	export USERNAME="example@example.com"
	export PASSWORD="Password123456"
	```
	An alternative method is to use a config.ini file containing the credentials and retrive them using the configparser module.
	```
	import configparser
	from cloudiq import CloudIQ

	# Parse configuration file
	try:
		config = configparser.ConfigParser()
		config.read('config.ini')
		ID = config['CRAYON_API']['ID']
		SECRET = config['CRAYON_API']['SECRET']
		USER = config['CRAYON_API']['USER']
		PASS = config['CRAYON_API']['PASS']
	except configparser.Error:
		print("Configuration Error...config.ini not found")
		exit()
	except KeyError:
		print("Configuration Error...configuration not found in config.ini")
		exit()

	crayon_api = CloudIQ(CLIENT_ID,CLIENT_SECRET,USERNAME,PASSWORD)
	```
	**See examples folder for authentication demos using configparser, ENV variables, and Azure DevOps Pipelines** 

## **Example calls**

1. Make an unauthenticated test ping to the API
	```
	response = crayon_api.ping()
	print(response)
	```

2. Get information about the currently authenticated user
	```
	response = crayon_api.me()
	print(response)
	```

3. Make a raw GET request:
	```
	# retrieves all products in the Azure Active Directory product family within Org 123456
	params = {
		'OrganizationId': 123456,
		'Include.ProductFamilyNames': 'Azure Active Directory'
	}
	# make a GET request to https://api.crayon.com/api/v1/AgreementProducts
	response = crayon_api.get("https://api.crayon.com/api/v1/AgreementProducts",params)
	print(response)
	```
	**Data can be sent to the API as a standard Python dictionary object**

4. Retrieve a valid authorization token:
	```
	response = crayon_api.getToken()
	print(response)
	```

5. Create a tenant using the CustomerTenantDetailed schema:
	```
	# Set Unique Tenant Variables
	tenant_name = "tenant_name"
	domain_prefix = "domain_prefix"

	# Intialize Tenant and Agreement objects
	tenant = crayon_api.CustomerTenantDetailed(
		tenant_name=tenant_name,
		domain_prefix=domain_prefix,
		org_id=111111,
		org_name="Fake Org",
		invoice_profile_id=80408, # Default
		contact_firstname="First",
		contact_lastname="Last",
		contact_email="email@example.com",
		contact_phone="5555555555",
		address_firstname="First",
		address_lastname="Last",
		address_address="75 NoWhere Lane",
		address_city="Boston",
		address_countrycode="US",
		address_region="MA",
		address_zipcode="02109"
	)

	agreement = crayon_api.CustomerTenantAgreement(
		firstname="First",
		lastname="Last",
		phone_number="5555555555",
		email="email@example.com"
	)

	#Create New Tenant
	new_tenant = crayon_api.createTenant(tenant.tenant)
	print(new_tenant)

	# Agree to Microsoft Customer Agreement
	tenant_id = new_tenant["Tenant"]["Id"]  
	agreement = crayon_api.createTenantAgreement(tenant_id,agreement.agreement)
	print(agreement)
	```

6. Buy a Microsoft license for a tenant using the SubscriptionDetailed schema:
	```
	tenant_id=123456

	 # Create Subscription objects
	azure_subscription = crayon_api.SubscriptionDetailed(
		name="Azure P2 Subscription",
		tenant_id=tenant_id,
		part_number="CFQ7TTC0LFK5:0001",
		quantity=1,
		billing_cycle=1,
		duration="P1M"
	)

	 # Create Azure P2 Subsription
	sub = crayon_api.createSubscription(azure_subscription.subscription)
	print(sub)
	```

##  **Docstring**

```
from cloudiq import CloudIQ
help(CloudIQ)
```

## **API Documentation**

1. Crayon API Documentation: https://apidocs.crayon.com/
2. Swagger UI (includes all valid schemas): https://api.crayon.com/docs/index.html

## **Schema currently implemented in CloudIQ class**

1. CustomerTenantDetailed
2. CustomerTenantAgreement
3. SubscriptionDetailed

## **Methods currently implemented in CloudIQ class**

1. get
2. ping
3. me
4. getToken
5. validateToken
6. getOrganizations
7. getOrganization
8. getOrganizationSalesContact
9. getAgreementProducts
10. getActivityLogs
11. getOrganizationHasAccess
12. getAddresses
13. getAddress
14. getSupportedBillingCycles
15. getAgreements
16. getAgreementReports
17. getCustomerTenants
18. getCustomerTenant
19. getCustomerTenantDetails
20. getCustomerTenantAzurePlan
21. getCustomerTenantAgreements
22. getBillingCycles
23. getProductVariantBillingCycles
24. getBillingCyclesNameDictionary
25. getBillingStatements
26. getGroupedBillingStatements
27. getBillingStatementExcel
28. getBillingStatementCSV
29. getBillingStatementJSON
30. getBlogItems
31. getClients
32. getClient
33. getConsumers
34. getConsumer
35. getCrayonAccounts
36. getCrayonAccount
37. getGroupings
38. getGrouping
39. getInvoiceProfiles
40. getInvoiceProfile
41. getProductContainers
42. getProductContainer
43. getProductContainerRowIssues
44. getProductContainerShoppingCart
45. getPrograms
46. getProgram
47. getPublishers
48. getPublisher
49. getRegions
50. getRegionByCode
51. getUsers
52. getUser
53. getUsername
54. getUsageCost
55. delete
56. patch 
57. post
58. put
59. createClient
60. deleteClient
61. createTenant
62. createSubscription
63. createTenantAgreement



