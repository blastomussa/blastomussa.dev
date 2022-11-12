---
title: "Crayon CloudIQ SDK for Python"
date: 2022-11-10T18:21:09-05:00
draft: false

tags: ["Python", "REST API"]
showEdit: false
showTaxonomies: true
---
This project is an SDK for Crayon's CloudIQ API that can be used in Python
scripts and applications. Provides a simple interface for individuals who are
inexperienced in C# to test Cloud IQ API calls with Python.

Project Repository: https://github.com/blastomussa/crayon-python-sdk 

**Use at your own risk. Only use POST, PUT, PATCH and DELETE methods if you understand the consequenses**

MIT License: https://github.com/blastomussa/crayon-python-sdk/blob/master/LICENSE 

## Installation

1. Clone the repository using the following command:
	```
	git clone https://github.com/blastomussa/crayon-python-sdk.git
	```

2. Navigate to the root directory of the project and run:
	```
	pip install -r requirements.txt
	```

3. Copy cloudiq.py to the root directory of a new project.

4. Import the CloudIQ class from cloudiq.py:
	```
	from cloudiq import CloudIQ
	```

5. Initialize an instance of the CloudIQ class with valid user credentials:
	```
	CLIENT_ID = xxxxxxx-xxxx-xxxx-xxxx-xxxxxx
	CLIENT_SECRET = xxxxxxx-xxxx-xxxx-xxxx-xxxxxx
	USERNAME = example@example.com
	PASSWORD = Password123456

	crayon_api = CloudIQ(CLIENT_ID,CLIENT_SECRET,USERNAME,PASSWORD)
	```

6. Make a test call to the API:
	```
	# retrieves all organizations associated with account
	response = crayon_api.getOrganizations()
	print(response)
	```

7. Make a raw GET request:
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

8. Retrieve a valid authorization token:
	```
	response = crayon_api.getToken()
	print(response)
	```

## Example Scripts

In order to use the example scripts, open example-config.ini with your favorite
text editor. Replace the dummy credentials with the those of a registered API
user and **save the file as config.ini.**
```
python3 example-products.py
```

## Methods currently implemented in CloudIQ class

1. get()
2. ping()
3. me()
4. getToken()
5. validateToken()
6. getOrganizations()
7. getOrganization()
8. getOrganizationSalesContact()
9. getAgreementProducts()
10. getActivityLogs()
11. getOrganizationHasAccess()
12. getAddresses()
13. getAddress()
14. getSupportedBillingCycles()
15. getAgreements()
16. getAgreementReports()
17. getCustomerTenants()
18. getCustomerTenant()
19. getCustomerTenantDetails()
20. getCustomerTenantAzurePlan()
21. getCustomerTenantAgreements()
22. getBillingCycles()
23. getProductVariantBillingCycles()
24. getBillingCyclesNameDictionary()
25. getBillingStatements()
26. getGroupedBillingStatements()
27. getBillingStatementExcel()
28. getBillingStatementCSV()
29. getBillingStatementJSON()
30. getBlogItems()
31. getClients()
32. getClient()
33. getConsumers()
34. getConsumer()
35. getCrayonAccounts()
36. getCrayonAccount()
37. getGroupings()
38. getGrouping()
39. getInvoiceProfiles()
40. getInvoiceProfile()
41. getProductContainers()
42. getProductContainer()
43. getProductContainerRowIssues()
44. getProductContainerShoppingCart()
45. getPrograms()
46. getProgram()
47. getPublishers()
48. getPublisher()
49. getRegions()
50. getRegionByCode()
51. getUsers()
52. getUser()
53. getUsername()
54. getUsageCost()
55. delete()
56. patch() 
57. post()
58. put()
59. createClient()
60. deleteClient()



##  How to retrieve detailed Docstring information on CloudIQ class

```
from cloudiq import CloudIQ
help(CloudIQ)
```

## References

1. Crayon API Documentation: https://apidocs.crayon.com/
2. Swagger UI (includes all valid schemas): https://api.crayon.com/docs/index.html

