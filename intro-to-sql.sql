/******************************************************************************
Course: Introduction to Structured Query Language (SQL)
Course materials: https://github.com/ajallohcode/Introduction-to-SQL

           The course begins here!
*****************************************************************************/

/*******************************************************************************
Demo: Using SSMS and Azure Data Studio to connect to SQL Server 
*******************************************************************************/

/******************************************************************************* 
Demo: Restore the sample sqldb database 
*******************************************************************************/

--Verify you're connected to a dedicated test instance
SELECT @@SERVERNAME AS WhereAmIConnected;
GO

-- Single line comment 

/* 
Multiple line 
comments 
*/

/********************************************************************************
Using and changing Database context 
*******************************************************************************/

--From TSQL:
USE sqldb
GO

--Shortcut in SSMS: CTRL + U
--If this shortcut doesn't work, you may be using an older version of SSMS

--GO is a batch separator
--This indicates the end of a group of code you'd like to execute together

--Note: GO is not part of T-SQL. It is simply a batch separator 
--It is a command recognized by sql utiltilies (like SSMS) 
--to delimit groups of code to execute in a batch
--You can even change the batch separator (Tools ->  Options -> Query Execution)


/********************************************************************************
 If you want to select all the columns in a table, you can use * (known as wildcard)
*********************************************************************************/

SELECT * FROM person;

-- Note: 
--; is a polite way to end queries (and it's the ANSI standard - American National Standards Institute)
-- It's not always required to end the SQL statement with a semicolumn (;)
-- Formatting convention: 
-- It is not necessary to capitalize the commands. Lowercase still works [select]
-- Capitalizing key words is simply a convention that makes queries easier to read 
-- Spacing: Sql treats one space, multiple space or line break as being the same thing


/********************************************************************************
For better performance use the column list, instead of using * 
*******************************************************************************/

SELECT FirstName, LastName, EmailAddress
FROM person

--Note: Whenever you select multiple columns, they must be separated by commas, but you should not include a comma after the last column name.
-- You can drag the columns if you do not want to type them out 
-- Example: DEMO
-- You can also right-click on the table name, select 'Script Table as', 'Select To' and 'New Query Editor Window'


/********************************************************************************
  Aliasing column names 
*********************************************************************************/

SELECT [FirstName] AS [First Name],
       [LastName] AS [Last Name],
       [EmailAddress] AS [Email Address]
FROM person;
GO

-- You can alias column names
--Bracket delimiters let me use spaces /special characters in my alias
--This is a very common way to alias columns for SQL Server:

--'AS' is not required to alias but it helps readability substantially


-- You can also alias in your FROM clause
SELECT p.FirstName,
       p.LastName ,
       p.EmailAddress
FROM person AS p;
GO

-- this will come in handy in cases where you may have multiple tables that may share similar names


/********************************************************************************
Using the Keyword TOP: restricting how many rows the SQL query returns 
*******************************************************************************/

SELECT TOP 500 *
FROM person

-- Note: the equivalent syntax/keyword in MySQL is LIMIT (which comes at the end of the SELECT statement)
-- Example: SELECT * FROM person LIMIT 500


/********************************************************************************
keyword DISTINCT: To Select or return unique values 
*******************************************************************************/

SELECT DISTINCT JobTitle
FROM person


/********************************************************************************
Filtering rows with WHERE clause
*******************************************************************************/

SELECT FirstName, LastName, JobTitle
FROM person
WHERE JobTitle = 'Design Engineer'

-- Note: 
-- text values are wrapped in single quotes. This is not required for numeric values 
-- the clauses always need to be in this order: SELECT, FROM, WHERE.

/*- List of different OPERATORS that can be used in the WHERE clause with examples 
-- Comparison operators on NUMERICAL and NON-NUMERICAL data
Not equal to	<> or !=
Greater than	>
Less than	<
Greater than or equal to	>=
Less than or equal to	<=
*/


/********************************************************************************
  SQL Logical Operators
- Logical operators allow you to use multiple comparison operators in a query
*******************************************************************************/

-- LIKE allows you to match similar values, instead of exact values.
SELECT * 
FROM person
WHERE BirthDate LIKE '%1969'
--Note:
-- % represents any character or set of characters (i.e. it is also referred to as a wildcard)
-- not case-sentive in T-SQL but may be so in other dialects?
-- to ignore case sensitivity in other dialects, user ILIKE?
-- underscore can be used to substitute for individual character?

-- IN allows you to specify a list of values you'd like to include in your query.
SELECT * 
FROM person
WHERE JobTitle IN ('Chief Executive Officer', 'Marketing Manager', 'Vice President of Production')

-- OR could also be used but is not efficient especially with many values 
SELECT * 
FROM person
WHERE JobTitle = 'Chief Executive Officer' OR JobTitle = 'Marketing Manager' OR JobTitle = 'Vice President of Production'
-- Note: remember to put non-numerical values in quote 

-- AND allows you to select only rows that satisfy two or more conditions.
-- It can be used with additional AND statemments or any other comparison operator as many times as you want 

-- OR allows you to select rows that satisfy either of two conditions.
-- OR and AND can be combined using parenthesis 


-- BETWEEN allows you to select only rows within a certain range. It has to be paired with the AND operator 

-- IS NULL allows you to select rows that contain no data in a given column.
-- You cannot perform arithmetic on null values 

-- NOT allows you to select rows that do not match a certain condition.
-- enables you to select rows for which that statement is false 
-- it is commonly used with LIKE

/******************************************************************************************************
ORDER BY: used for sorting data in SQL 
The ORDER BY clause allows you to reorder your query results based on the data in one or more columns. 
*******************************************************************************************************/