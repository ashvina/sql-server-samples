/*============================================================================
  File:     instawdb.sql

  Summary:  Creates the AdventureWorks sample database. Run this on
  any version of SQL Server (2008R2 or later) to get AdventureWorks for your
  current version.  

  Date:     October 26, 2017
  Updated:  October 26, 2017

------------------------------------------------------------------------------
  This file is part of the Microsoft SQL Server Code Samples.

  Copyright (C) Microsoft Corporation.  All rights reserved.

  This source code is intended only as a supplement to Microsoft
  Development Tools and/or on-line documentation.  See these other
  materials for detailed information regarding Microsoft code samples.

  All data in this database is ficticious.
  
  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
  KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
  PARTICULAR PURPOSE.
============================================================================*/

/*
 * HOW TO RUN THIS SCRIPT:
 *
 * 1. Enable full-text search on your SQL Server instance. 
 *
 * 2. Open the script inside SQL Server Management Studio and enable SQLCMD mode. 
 *    This option is in the Query menu.
 *
 * 3. Copy this script and the install files to C:\Samples\AdventureWorks, or
 *    set the following environment variable to your own data path.
 *
 * 4. Append the SQL Server version number to database name if you want to
 *    differentiate it from other installs of AdventureWorks.
 */

:setvar DatabaseName "AdventureWorks"
:setvar CredentialName "CredentialSampleDataSource"
:setvar SasSecret "something"
:setvar DataSourceName "SampleDataSource"
:setvar DataSourceLocation "SampleDataLocation"

/* Execute the script
 */

SET NOCOUNT OFF;
GO

PRINT CONVERT(varchar(1000), @@VERSION);
GO

PRINT '';
PRINT 'Started - ' + CONVERT(varchar, GETDATE(), 121);
GO

PRINT '';
PRINT '*** Checking for $(DatabaseName) Database';
/* CHECK FOR DATABASE IF IT DOESN'T EXISTS, DO NOT RUN THE REST OF THE SCRIPT */
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.databases WHERE name = N'$(DatabaseName)')
BEGIN
PRINT '*******************************************************************************************************************************************************************'
+char(10)+'********$(DatabaseName) Database does not exist.  Make sure that the script is being run in SQLCMD mode and that the variables have been correctly set.*********'
+char(10)+'*******************************************************************************************************************************************************************';
SET NOEXEC ON;
END
GO

-- ******************************************************
-- Drop Views
-- ******************************************************
PRINT '';
PRINT '*** Droping views';
GO

DROP VIEW [Person].[vAdditionalContactInfo]
DROP VIEW [HumanResources].[vEmployee] 
DROP VIEW [HumanResources].[vEmployeeDepartment] 
DROP VIEW [HumanResources].[vEmployeeDepartmentHistory] 
DROP VIEW [Sales].[vIndividualCustomer] 
DROP VIEW [Sales].[vPersonDemographics] 
DROP VIEW [HumanResources].[vJobCandidate] 
DROP VIEW [HumanResources].[vJobCandidateEmployment] 
DROP VIEW [HumanResources].[vJobCandidateEducation] 
DROP VIEW [Production].[vProductAndDescription] 
DROP VIEW [Production].[vProductModelCatalogDescription] 
DROP VIEW [Production].[vProductModelInstructions] 
DROP VIEW [Sales].[vSalesPerson] 
DROP VIEW [Sales].[vSalesPersonSalesByFiscalYears] 
DROP VIEW [Person].[vStateProvinceCountryRegion] 
DROP VIEW [Sales].[vStoreWithDemographics] 
DROP VIEW [Sales].[vStoreWithContacts] 
DROP VIEW [Sales].[vStoreWithAddresses] 
DROP VIEW [Purchasing].[vVendorWithContacts] 
DROP VIEW [Purchasing].[vVendorWithAddresses] 


-- ******************************************************
-- Drop Functions
-- ******************************************************
PRINT '';
PRINT '*** Droping Functions';
GO

DROP FUNCTION IF EXISTS ufnGetAccountingStartDate
DROP FUNCTION IF EXISTS ufnGetAccountingEndDate
DROP FUNCTION IF EXISTS ufnGetContactInformation
DROP FUNCTION IF EXISTS ufnGetProductDealerPrice
DROP FUNCTION IF EXISTS ufnGetProductListPrice
DROP FUNCTION IF EXISTS ufnGetProductStandardCost
DROP FUNCTION IF EXISTS ufnGetStock
DROP FUNCTION IF EXISTS ufnGetDocumentStatusText
DROP FUNCTION IF EXISTS ufnGetPurchaseOrderStatusText
DROP FUNCTION IF EXISTS ufnGetSalesOrderStatusText

-- ******************************************************
-- Drop Procedures
-- ******************************************************
PRINT '';
PRINT '*** Droping Stored Procedures';
GO

DROP PROCEDURE IF EXISTS [dbo].[uspGetBillOfMaterials]
DROP PROCEDURE IF EXISTS [dbo].[uspGetEmployeeManagers]
DROP PROCEDURE IF EXISTS [dbo].[uspGetManagerEmployees]
DROP PROCEDURE IF EXISTS [dbo].[uspGetWhereUsedProductID]
DROP PROCEDURE IF EXISTS [HumanResources].[uspUpdateEmployeeHireInfo]
DROP PROCEDURE IF EXISTS [HumanResources].[uspUpdateEmployeeLogin]
DROP PROCEDURE IF EXISTS [HumanResources].[uspUpdateEmployeePersonalInfo]


-- ******************************************************
-- Drop tables
-- ******************************************************
PRINT '';
PRINT '*** Droping Tables';
GO

DROP TABLE Person.Address
DROP TABLE Person.AddressType
DROP TABLE dbo.AWBuildVersion
DROP TABLE Production.BillOfMaterials
DROP TABLE Person.BusinessEntity
DROP TABLE Person.BusinessEntityAddress
DROP TABLE Person.BusinessEntityContact
DROP TABLE Person.ContactType
DROP TABLE Sales.CountryRegionCurrency
DROP TABLE Person.CountryRegion
DROP TABLE Sales.CreditCard
DROP TABLE Production.Culture
DROP TABLE Sales.Currency
DROP TABLE Sales.CurrencyRate
DROP TABLE Sales.Customer
DROP TABLE HumanResources.Department
DROP TABLE Production.Document
DROP TABLE Person.EmailAddress
DROP TABLE HumanResources.Employee
DROP TABLE HumanResources.EmployeeDepartmentHistory
DROP TABLE HumanResources.EmployeePayHistory
DROP TABLE Production.Illustration
DROP TABLE HumanResources.JobCandidate
DROP TABLE Production.Location
DROP TABLE Person.Password
DROP TABLE Person.Person
DROP TABLE Sales.PersonCreditCard
DROP TABLE Person.PersonPhone
DROP TABLE Person.PhoneNumberType
DROP TABLE Production.Product
DROP TABLE Production.ProductCategory
DROP TABLE Production.ProductCostHistory
DROP TABLE Production.ProductDescription
DROP TABLE Production.ProductDocument
DROP TABLE Production.ProductInventory
DROP TABLE Production.ProductListPriceHistory
DROP TABLE Production.ProductModel
DROP TABLE Production.ProductModelIllustration
DROP TABLE Production.ProductModelProductDescriptionCulture
DROP TABLE Production.ProductPhoto
DROP TABLE Production.ProductProductPhoto
DROP TABLE Production.ProductReview
DROP TABLE Production.ProductSubcategory
DROP TABLE Purchasing.ProductVendor
DROP TABLE Purchasing.PurchaseOrderDetail
DROP TABLE Purchasing.PurchaseOrderHeader
DROP TABLE Sales.SalesOrderDetail
DROP TABLE Sales.SalesOrderHeader
DROP TABLE Sales.SalesOrderHeaderSalesReason
DROP TABLE Sales.SalesPerson
DROP TABLE Sales.SalesPersonQuotaHistory
DROP TABLE Sales.SalesReason
DROP TABLE Sales.SalesTaxRate
DROP TABLE Sales.SalesTerritory
DROP TABLE Sales.SalesTerritoryHistory
DROP TABLE Production.ScrapReason
DROP TABLE HumanResources.Shift
DROP TABLE Purchasing.ShipMethod
DROP TABLE Sales.ShoppingCartItem
DROP TABLE Sales.SpecialOffer
DROP TABLE Sales.SpecialOfferProduct
DROP TABLE Person.StateProvince
DROP TABLE Sales.Store
DROP TABLE Production.TransactionHistory
DROP TABLE Production.TransactionHistoryArchive
DROP TABLE Production.UnitMeasure
DROP TABLE Purchasing.Vendor
DROP TABLE Production.WorkOrder
DROP TABLE Production.WorkOrderRouting

GO

SET NOEXEC OFF
