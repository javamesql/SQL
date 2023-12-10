--These are the SQL queries from SQL Server Management Studio used to cleanse the tables and prepare them for loading

--DIM_Products Table Cleansed
SELECT p.[ProductKey]
      ,p.[ProductAlternateKey] AS ProductItemCode
      --,[ProductSubcategoryKey]
      --,[WeightUnitMeasureCode]
      --,[SizeUnitMeasureCode]
      ,p.[EnglishProductName] AS [Product Name]
	  ,ps.EnglishProductSubcategoryName AS [Sub Category] --Joined from Sub Category Table
	  ,pc.EnglishProductCategoryName AS [Product Category] --Joined from Category Table
      --,[SpanishProductName]
      --,[FrenchProductName]
      --,[StandardCost]
      --,[FinishedGoodsFlag]
      ,p.[Color] AS [Product Color]
      --,[SafetyStockLevel]
      --,[ReorderPoint]
      --,[ListPrice]
      ,p.[Size] AS [Product Size]
      --,[SizeRange]
      --,[Weight]
      --,[DaysToManufacture]
      ,p.[ProductLine] AS [Product Line]
      --,[DealerPrice]
      --,[Class]
      --,[Style]
      ,p.[ModelName] AS [Product Model Name]
      --,[LargePhoto]
      ,p.[EnglishDescription] AS [Product Description]
      --,[FrenchDescription]
      --,[ChineseDescription]
      --,[ArabicDescription]
      --,[HebrewDescription]
      --,[ThaiDescription]
      --,[GermanDescription]
      ---,[JapaneseDescription]
      --,[TurkishDescription]
      --,[StartDate]
      --,[EndDate]
      ,ISNULL (p.[Status], 'Outdated') AS [Product Status] --Makes it either Current or Outdated instead of Null
FROM [dbo].[DimProduct] p
	LEFT JOIN dbo.DimProductSubcategory ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
	LEFT JOIN dbo.DimProductCategory pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY
	p.ProductKey ASC;


--FACT_InternetSales Table Cleanse
SELECT [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
      --,[PromotionKey]
      --,[CurrencyKey]
      --,[SalesTerritoryKey]
      ,[SalesOrderNumber]
      --,[SalesOrderLineNumber]
      --,[RevisionNumber]
      --,[OrderQuantity]
      --,[UnitPrice]
      --,[ExtendedAmount]
      --,[UnitPriceDiscountPct]
      --,[DiscountAmount]
      --,[ProductStandardCost]
      --,[TotalProductCost]
      ,[SalesAmount]
      --,[TaxAmt]
      --,[Freight]
      --,[CarrierTrackingNumber]
      --,[CustomerPONumber]
      --,[OrderDate]
      --,[DueDate]
      --,[ShipDate]
FROM 
	[dbo].[FactInternetSales]
WHERE
	LEFT (OrderDateKey, 4) BETWEEN 2020 AND 2022 --We want sales from the last 2 fiscal years excluding 2023
ORDER BY
	OrderDateKey ASC;


-- DIM_Customers Table Cleanse
SELECT c.CustomerKey 
      --,[GeographyKey]
      --,[CustomerAlternateKey]
      --,[Title]
      ,c.FirstName AS [First Name]
      --,[MiddleName]
      ,c.LastName AS [Last Name]
	  ,c.FirstName + ' ' + c.LastName AS [Full Name]
      --,[NameStyle]
      --,[BirthDate]
      --,[MaritalStatus]
      --,[Suffix]
      ,CASE c.Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender --Easier to read
      --,[EmailAddress]
      --,[YearlyIncome]
      --,[TotalChildren]
      --,[NumberChildrenAtHome]
      --,[EnglishEducation]
      --,[SpanishEducation]
      --,[FrenchEducation]
      --,[EnglishOccupation]
      --,[SpanishOccupation]
      --,[FrenchOccupation]
      --,[HouseOwnerFlag]
      --,[NumberCarsOwned]
      --,[AddressLine1]
      --,[AddressLine2]
      --,[Phone]
      ,c.DateFirstPurchase
      --,[CommuteDistance]
	  ,g.city AS [Customer City] -- Joined in Customer City from Geography Table
FROM dbo.DimCustomer c
	LEFT JOIN dbo.DimGeography g ON g.GeographyKey = c.GeographyKey
WHERE
	LEFT (DateFirstPurchase, 4) BETWEEN 2020 AND 2022
ORDER BY
	CustomerKey ASC; -- Ordered List by Customer Key


--DimDate Cleanse--
SELECT [DateKey]
      ,[FullDateAlternateKey] AS Date
      --[DayNumberOfWeek]
      ,[EnglishDayNameOfWeek] AS Day
      --[SpanishDayNameOfWeek]
      --[FrenchDayNameOfWeek]
      --[DayNumberOfMonth]
      --[DayNumberOfYear]
      --,[WeekNumberOfYear]
      ,[EnglishMonthName] AS Month
	  ,LEFT([EnglishMonthName], 3) AS MonthShort
      --[SpanishMonthName]
      --[FrenchMonthName]
      ,[MonthNumberOfYear] AS MonthNumber
      ,[CalendarQuarter] AS Quarter
      ,[CalendarYear] AS Year
      --[CalendarSemester]
      --[FiscalQuarter]
      --[FiscalYear]
      --[FiscalSemester]
  FROM [AdventureWorksDW2022].[dbo].[DimDate]
  WHERE [CalendarYear] BETWEEN 2020 AND 2022; --We want only dates from the last 2 full years excluding 2023

