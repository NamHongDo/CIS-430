USE Company
GO
--LAB 6: PART 1: Q1
--DROPING ALL THE FK FROM OTHER TABLE THAT REFER TO DEPARTMENT AND EMPLOYEE PK BEFORE DROPPING THEIR PK
ALTER TABLE DEPT_LOCATIONS
DROP CONSTRAINT FK__DEPT_LOCA__Dnumb__3C34F16F;

ALTER TABLE PROJECT
DROP CONSTRAINT FK__PROJECT__Dnum__3D2915A8;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT FK__EMPLOYEE__Dno__3A4CA8FD;

ALTER TABLE DEPARTMENT
DROP CONSTRAINT FK__DEPARTMEN__Mgr_s__3B40CD36,
				PK__DEPARTME__40A4CC7A6B8CA08F;		

ALTER TABLE WORKS_ON
DROP CONSTRAINT FK__WORKS_ON__Essn__3E1D39E1;
						
ALTER TABLE [DEPENDENT]
DROP CONSTRAINT FK__DEPENDENT__Essn__40058253;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT FK__EMPLOYEE__Super___395884C4,PK__EMPLOYEE__CA33E0E5C91F51C6;  
Question 1-1
Create a view named VDept_Budget that reports headcount for each department.
The report includes 3 columns as follow:
Dept_Name, Dept_Number, No_Emp.
Include all the departments. */

USE COMPANY
GO
	CREATE VIEW VDept_Budget (Dept_Name, Dept_Number, No_Emp)
	AS SELECT	D.Dname, D.Dnumber, COUNT (*)
	FROM		DEPARTMENT D, EMPLOYEE E
	WHERE		E.Dno=D.Dnumber		
	GROUP BY	D.Dname, D.Dnumber; 

/*1-2 Add yourself to the database (to Employee table). Then Show the content of your view again to
see if your view is updated according to the changes in its base table Employee. 
*/

INSERT INTO EMPLOYEE VALUES ('QUOC', 'Q', 'DO', '234149928','28-July-89', '1800 Bullock, Cleveland, OH', 'M', 50000, '259470411', 4);

/*1-3Change your view to add two more info – Sum_Salary, Ave_Salary for each department. Include all
the departments. Your report (view) lists 5 Columns as follow:
Dept_Name, Dept_Number, No_Emp, Sum_Salary, Ave_Salary 
*/

ALTER VIEW  VDept_Budget (Dept_Name, Dept_Number, No_Emp, Sum_Salary, Ave_salary) AS
SELECT		D.Dname, D.Dnumber, COUNT (*), SUM(E.SALARY), AVG (E.Salary)
FROM		DEPARTMENT D, EMPLOYEE E
WHERE		E.Dno=D.Dnumber		
GROUP BY	D.Dname, D.Dnumber; 

/*2.1Write a Stored Procedure SP_Report_ NEW_Budget */
CREATE PROCEDURE SP_Report_NEW_Budget
AS

DECLARE @Count		as smallint
DECLARE @Dept_No	as int
DECLARE @Dept_Name	as varchar(10)
DECLARE	@COUNT_Emp	as int
DECLARE	@SUM_Salary	as int
DECLARE	@AVE_Salary	as int

IF OBJECT_ID('dbo.NEW_Dept_Budget') IS NOT NULL
DROP TABLE NEW_Dept_Budget
	CREATE TABLE NEW_Dept_Budget(
		Dept_Name		VarChar(30),
		Dept_No			Int,
		COUNT_Emp		INT,
		New_SUM_Salary	INT,
		New_AVE_Salary	INT
		)
DECLARE Budget CURSOR FOR
	SELECT *
	FROM VDept_Budget 

SELECT	@Count=Count(*)
FROM	VDept_Budget

IF @Count > 0
	BEGIN
		OPEN Budget
		FETCH NEXT FROM Budget INTO @Dept_Name, @Dept_No, @COUNT_Emp, @SUM_Salary, @AVE_Salary
WHILE @@FETCH_STATUS=0
	BEGIN
			IF @Dept_No=1
				BEGIN
					SET @SUM_Salary= @Sum_Salary*110/100			
				END
			ELSE IF @Dept_No=4
				BEGIN
					SET @SUM_Salary= @Sum_Salary*120/100
				END
			ELSE IF @Dept_No=5
				BEGIN
					SET @SUM_Salary= @Sum_Salary*130/100
				END
			ELSE IF @Dept_No=7
				BEGIN
					SET @SUM_Salary= @Sum_Salary*140/100
				END
			SET @AVE_Salary=@SUM_Salary/@COUNT_Emp
		INSERT INTO  NEW_Dept_Budget(Dept_Name, Dept_No, COUNT_Emp, New_SUM_Salary, New_AVE_Salary)
			VALUES(@Dept_Name, @Dept_No, @Count_Emp, @SUM_Salary, @AVE_Salary)
		FETCH NEXT FROM Budget INTO @Dept_Name, @Dept_No, @COUNT_Emp, @SUM_Salary, @AVE_Salary
	END
END

CLOSE Budget
DEALLOCATE Budget;


EXEC SP_Report_NEW_Budget;
