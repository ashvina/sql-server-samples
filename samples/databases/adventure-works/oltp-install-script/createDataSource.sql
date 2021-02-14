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

-- ****************************************
-- Drop External Data Source
-- ****************************************
PRINT '';
PRINT '*** Dropping External Data Source';
GO

IF EXISTS (SELECT [name] FROM [$(DatabaseName)].[sys].[external_data_sources] WHERE [name] = N'$(DataSourceName)')
    DROP EXTERNAL DATA SOURCE [$(DataSourceName)]

-- ****************************************
-- Drop Credential
-- ****************************************
PRINT '';
PRINT '*** Dropping Credential';
GO

IF EXISTS (SELECT [name] FROM [$(DatabaseName)].[sys].[database_scoped_credentials] WHERE [name] = N'$(CredentialName)')
    DROP DATABASE SCOPED CREDENTIAL [$(CredentialName)]

-- ****************************************
-- Create Credential
-- ****************************************
PRINT '';
PRINT '*** Creating Credential';
GO

CREATE DATABASE SCOPED CREDENTIAL [$(CredentialName)]
WITH IDENTITY='SHARED ACCESS SIGNATURE',
SECRET = N'$(SasSecret)'
GO

-- ****************************************
-- Create External Data Source
-- ****************************************
PRINT '';
PRINT '*** Creating External Data Source';
GO

CREATE EXTERNAL DATA SOURCE [$(DataSourceName)]
WITH (
  TYPE = BLOB_STORAGE,
  LOCATION = '$(DataSourceLocation)',
  CREDENTIAL = $(CredentialName)
);
GO


SET NOEXEC OFF
