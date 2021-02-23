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

SET QUOTED_IDENTIFIER ON;
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

PRINT '';
PRINT '*** Verifying schema exists';
/* CHECK FOR SOME SCEHMA IF IT DOESN'T EXISTS, DO NOT RUN THE REST OF THE SCRIPT */
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.schemas WHERE name = N'HumanResources')
BEGIN
PRINT '*******************************************************************************************************************************************************************'
+char(10)+'********HumanResources Schema does not exist.  Make sure that the script is being run in SQLCMD mode and that the variables have been correctly set.*********'
+char(10)+'*******************************************************************************************************************************************************************';
SET NOEXEC ON;
END
GO

-- ******************************************************
-- Load data
-- ******************************************************
PRINT '';
PRINT '*** Loading Data';
GO

PRINT 'Loading [Person].[Address]';

BULK INSERT [Person].[Address] FROM 'Address.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE = 'char',
    FIELDTERMINATOR= '\t',
    ROWTERMINATOR = '0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Person].[AddressType]';

BULK INSERT [Person].[AddressType] FROM 'AddressType.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE = 'char',
    FIELDTERMINATOR= '\t',
    ROWTERMINATOR = '0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [dbo].[AWBuildVersion]';



INSERT INTO [dbo].[AWBuildVersion] 
VALUES
( CONVERT(nvarchar(25), SERVERPROPERTY('ProductVersion')), CONVERT(datetime, SERVERPROPERTY('ResourceLastUpdateDateTime')), CONVERT(datetime, GETDATE()) );


GO
PRINT 'Loading [Production].[BillOfMaterials]';

BULK INSERT [Production].[BillOfMaterials] FROM 'BillOfMaterials.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE = 'char',
    FIELDTERMINATOR= '\t',
    ROWTERMINATOR = '0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Person].[BusinessEntity]';

BULK INSERT [Person].[BusinessEntity] FROM 'BusinessEntity.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Person].[BusinessEntityAddress]';

BULK INSERT [Person].[BusinessEntityAddress] FROM 'BusinessEntityAddress.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Person].[BusinessEntityContact]';

BULK INSERT [Person].[BusinessEntityContact] FROM 'BusinessEntityContact.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Person].[ContactType]';

BULK INSERT [Person].[ContactType] FROM 'ContactType.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Person].[CountryRegion]';

BULK INSERT [Person].[CountryRegion] FROM 'CountryRegion.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Sales].[CountryRegionCurrency]';

BULK INSERT [Sales].[CountryRegionCurrency] FROM 'CountryRegionCurrency.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Sales].[CreditCard]';

BULK INSERT [Sales].[CreditCard] FROM 'CreditCard.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[Culture]';

BULK INSERT [Production].[Culture] FROM 'Culture.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Sales].[Currency]';

BULK INSERT [Sales].[Currency] FROM 'Currency.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Sales].[CurrencyRate]';

BULK INSERT [Sales].[CurrencyRate] FROM 'CurrencyRate.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Sales].[Customer]';

BULK INSERT [Sales].[Customer] FROM 'Customer.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);



GO
PRINT 'Loading [HumanResources].[Department]';

BULK INSERT [HumanResources].[Department] FROM 'Department.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

 
GO
PRINT 'Loading [Production].[Document]';

BULK INSERT [Production].[Document] FROM 'Document.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK   
);


GO
PRINT 'Loading [Person].[EmailAddress]';

BULK INSERT [Person].[EmailAddress] FROM 'EmailAddress.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [HumanResources].[Employee]';

BULK INSERT [HumanResources].[Employee] FROM 'Employee.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [HumanResources].[EmployeeDepartmentHistory]';

BULK INSERT [HumanResources].[EmployeeDepartmentHistory] FROM 'EmployeeDepartmentHistory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [HumanResources].[EmployeePayHistory]';

BULK INSERT [HumanResources].[EmployeePayHistory] FROM 'EmployeePayHistory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Production].[Illustration]';

BULK INSERT [Production].[Illustration] FROM 'Illustration.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [HumanResources].[JobCandidate]';

BULK INSERT [HumanResources].[JobCandidate] FROM 'JobCandidate.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);



GO
PRINT 'Loading [Production].[Location]';

BULK INSERT [Production].[Location] FROM 'Location.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Person].[Password]';

BULK INSERT [Person].[Password] FROM 'Password.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Person].[Person]';

BULK INSERT [Person].[Person] FROM 'Person.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Sales].[PersonCreditCard]';

BULK INSERT [Sales].[PersonCreditCard] FROM 'PersonCreditCard.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Person].[PersonPhone]';

BULK INSERT [Person].[PersonPhone] FROM 'PersonPhone.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Person].[PhoneNumberType]';

BULK INSERT [Person].[PhoneNumberType] FROM 'PhoneNumberType.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Production].[Product]';

BULK INSERT [Production].[Product] FROM 'Product.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductCategory]';

BULK INSERT [Production].[ProductCategory] FROM 'ProductCategory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductCostHistory]';

BULK INSERT [Production].[ProductCostHistory] FROM 'ProductCostHistory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductDescription]';

BULK INSERT [Production].[ProductDescription] FROM 'ProductDescription.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductDocument]';

BULK INSERT [Production].[ProductDocument] FROM 'ProductDocument.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK   
);

GO
PRINT 'Loading [Production].[ProductInventory]';

BULK INSERT [Production].[ProductInventory] FROM 'ProductInventory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductListPriceHistory]';

BULK INSERT [Production].[ProductListPriceHistory] FROM 'ProductListPriceHistory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductModel]';

BULK INSERT [Production].[ProductModel] FROM 'ProductModel.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductModelIllustration]';

BULK INSERT [Production].[ProductModelIllustration] FROM 'ProductModelIllustration.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductModelProductDescriptionCulture]';

BULK INSERT [Production].[ProductModelProductDescriptionCulture] FROM 'ProductModelProductDescriptionCulture.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductPhoto]';

BULK INSERT [Production].[ProductPhoto] FROM 'ProductPhoto.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK   
);

GO
PRINT 'Loading [Production].[ProductProductPhoto]';

BULK INSERT [Production].[ProductProductPhoto] FROM 'ProductProductPhoto.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductReview]';

BULK INSERT [Production].[ProductReview] FROM 'ProductReview.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Production].[ProductSubcategory]';

BULK INSERT [Production].[ProductSubcategory] FROM 'ProductSubcategory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Purchasing].[ProductVendor]';

BULK INSERT [Purchasing].[ProductVendor] FROM 'ProductVendor.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Purchasing].[PurchaseOrderDetail]';

BULK INSERT [Purchasing].[PurchaseOrderDetail] FROM 'PurchaseOrderDetail.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Purchasing].[PurchaseOrderHeader]';

BULK INSERT [Purchasing].[PurchaseOrderHeader] FROM 'PurchaseOrderHeader.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Sales].[SalesOrderDetail]';

BULK INSERT [Sales].[SalesOrderDetail] FROM 'SalesOrderDetail.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO
PRINT 'Loading [Sales].[SalesOrderHeader]';

BULK INSERT [Sales].[SalesOrderHeader] FROM 'SalesOrderHeader.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Sales].[SalesOrderHeaderSalesReason]';

BULK INSERT [Sales].[SalesOrderHeaderSalesReason] FROM 'SalesOrderHeaderSalesReason.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Sales].[SalesPerson]';

BULK INSERT [Sales].[SalesPerson] FROM 'SalesPerson.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Sales].[SalesPersonQuotaHistory]';

BULK INSERT [Sales].[SalesPersonQuotaHistory] FROM 'SalesPersonQuotaHistory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


GO
PRINT 'Loading [Sales].[SalesReason]';

BULK INSERT [Sales].[SalesReason] FROM 'SalesReason.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Sales].[SalesTaxRate]';

BULK INSERT [Sales].[SalesTaxRate] FROM 'SalesTaxRate.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Sales].[SalesTerritory]';

BULK INSERT [Sales].[SalesTerritory] FROM 'SalesTerritory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Sales].[SalesTerritoryHistory]';

BULK INSERT [Sales].[SalesTerritoryHistory] FROM 'SalesTerritoryHistory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);


PRINT 'Loading [Production].[ScrapReason]';

BULK INSERT [Production].[ScrapReason] FROM 'ScrapReason.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [HumanResources].[Shift]';

BULK INSERT [HumanResources].[Shift] FROM 'Shift.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Purchasing].[ShipMethod]';

BULK INSERT [Purchasing].[ShipMethod] FROM 'ShipMethod.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Sales].[ShoppingCartItem]';

BULK INSERT [Sales].[ShoppingCartItem] FROM 'ShoppingCartItem.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Sales].[SpecialOffer]';

BULK INSERT [Sales].[SpecialOffer] FROM 'SpecialOffer.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Sales].[SpecialOfferProduct]';

BULK INSERT [Sales].[SpecialOfferProduct] FROM 'SpecialOfferProduct.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Person].[StateProvince]';

BULK INSERT [Person].[StateProvince] FROM 'StateProvince.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Sales].[Store]';

BULK INSERT [Sales].[Store] FROM 'Store.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);


PRINT 'Loading [Production].[TransactionHistory]';

BULK INSERT [Production].[TransactionHistory] FROM 'TransactionHistory.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    TABLOCK
);

PRINT 'Loading [Production].[TransactionHistoryArchive]';

BULK INSERT [Production].[TransactionHistoryArchive] FROM 'TransactionHistoryArchive.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Production].[UnitMeasure]';

BULK INSERT [Production].[UnitMeasure] FROM 'UnitMeasure.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Purchasing].[Vendor]';

BULK INSERT [Purchasing].[Vendor] FROM 'Vendor.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Production].[WorkOrder]';

BULK INSERT [Production].[WorkOrder] FROM 'WorkOrder.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

PRINT 'Loading [Production].[WorkOrderRouting]';

BULK INSERT [Production].[WorkOrderRouting] FROM 'WorkOrderRouting.csv'
WITH (
    DATA_SOURCE = '$(DataSourceName)',
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='0x0A',
    KEEPIDENTITY,
    TABLOCK
);

GO

SET NOEXEC OFF
