
CREATE TABLE Audit_Dept_Table(
	date_of_change		date,
	old_Dname			VARCHAR(15),
	new_Dname			VARCHAR(15),
	old_Dnumber			INT,
	new_Dnumber			INT,
	old_Mgrssn			CHAR(9),
	new_Mgrssn			CHAR(9),
	);

/*	2) Write(Create) triggers to implement Constraint EMPDEPTFK in
	Table Employee based on the following rules as defined in DDL for
	Employee as in Figure 4.2:
	FK Dno of Employee On Delete SET DEFAULT (= 1 ) and
	FK Dno of Employee On Update CASCADE of Dnumber PK of Department	*/

CREATE TRIGGER EMPDEPTFK_ONDELETE ON DEPARTMENT
FOR DELETE AS 
	BEGIN   
		UPDATE EMPLOYEE SET EMPLOYEE.Dno=DEFAULT
		FROM EMPLOYEE AS E
		JOIN DELETED AS D ON D.DNUMBER=E.DNO;
	END;
	GO

CREATE TRIGGER EMPDEPTFK_ONUPDATE ON DEPARTMENT
FOR UPDATE AS
	BEGIN
		DECLARE @NEW_DNUMBER INT
		SELECT @NEW_DNUMBER = I.Dnumber FROM INSERTED I
		UPDATE EMPLOYEE SET EMPLOYEE.Dno=@NEW_DNUMBER
		FROM EMPLOYEE AS E
		JOIN DELETED AS D ON D.DNUMBER=E.DNO;
	END;
	GO
  
  /*	3) Write (Create) Stored Procedure SP_Audit_Dept that inserts all the
history of the data of changes by the trigger you created in 1) above into
a table Audit_Dept_Table. See for the more specific instructions that are
given in 2 below.	*/

CREATE PROCEDURE SP_Audit_Dept
 @old_Dname		VARCHAR(15), 
 @new_Dname		VARCHAR(15), 
 @old_Dnumber	INT,
 @new_Dnumber	INT,
 @old_Mgrssn	CHAR(9), 
 @new_Mgrssn	CHAR(9) 
 AS
INSERT INTO Audit_Dept_Table VALUES (GETDATE(), @old_Dname, @new_Dname, @old_Dnumber, @new_Dnumber,@old_Mgrssn, @new_Mgrssn)

GO

USE [Company]
GO

/****** Object:  Trigger [EMPDEPTFK_ONUPDATE]    Script Date: 11/30/2016 4:51:27 PM ******/
DROP TRIGGER [dbo].[EMPDEPTFK_ONUPDATE]
GO

/****** Object:  Trigger [dbo].[EMPDEPTFK_ONUPDATE]    Script Date: 11/30/2016 4:51:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[EMPDEPTFK_ONUPDATE] ON [dbo].[DEPARTMENT]
FOR UPDATE AS
	BEGIN
		DECLARE @old_Dname		VARCHAR(15);
		DECLARE @old_Dnumber	INT;
		DECLARE @old_Mgrssn		CHAR(9);
		DECLARE @new_Dname		VARCHAR(15);
		DECLARE @new_Dnumber	INT;
		DECLARE @new_Mgrssn		CHAR(9);

		SELECT @NEW_DNUMBER = I.Dnumber FROM INSERTED I
		UPDATE EMPLOYEE SET EMPLOYEE.Dno=@NEW_DNUMBER
		FROM EMPLOYEE AS E
		JOIN DELETED AS D ON D.DNUMBER=E.DNO;

		DECLARE DD CURSOR FOR
		SELECT Dname,Dnumber,Mgr_ssn
		FROM deleted
		
		DECLARE ID CURSOR FOR
		SELECT Dname,Dnumber,Mgr_ssn
		FROM inserted

		OPEN DD 
			FETCH NEXT FROM DD INTO @old_Dname,@old_Dnumber,@old_Mgrssn
		OPEN ID
			FETCH NEXT FROM ID INTO @new_Dname,@new_Dnumber,@new_Mgrssn
		WHILE @@FETCH_STATUS=0
			BEGIN
				EXEC SP_Audit_Dept @old_Dname,@new_Dname, @old_Dnumber, @new_Dnumber, @old_Mgrssn,@new_Mgrssn;
				FETCH NEXT FROM DD INTO @old_Dname,@old_Dnumber,@old_Mgrssn
				FETCH NEXT FROM ID INTO @new_Dname,@new_Dnumber,@new_Mgrssn
			END
	END;
	CLOSE DD
	DEALLOCATE DD
	CLOSE ID
	DEALLOCATE ID;
GO

USE [Company]
GO

/****** Object:  Trigger [EMPDEPTFK_ONDELETE]    Script Date: 11/30/2016 1:05:04 PM ******/
DROP TRIGGER [dbo].[EMPDEPTFK_ONDELETE]
GO

/****** Object:  Trigger [dbo].[EMPDEPTFK_ONDELETE]    Script Date: 11/30/2016 1:05:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*	2) Write(Create) triggers to implement Constraint EMPDEPTFK in
	Table Employee based on the following rules as defined in DDL for
	Employee as in Figure 4.2:
	FK Dno of Employee On Delete SET DEFAULT (= 1 ) and
	FK Dno of Employee On Update CASCADE of Dnumber PK of Department	*/
USE [Company]
GO

CREATE TRIGGER [dbo].[EMPDEPTFK_ONDELETE] ON [dbo].[DEPARTMENT]
FOR DELETE AS 
	BEGIN
		DECLARE @old_Dname		VARCHAR(15);
		DECLARE @old_Dnumber	INT;
		DECLARE @old_Mgrssn		CHAR(9);

		UPDATE EMPLOYEE SET EMPLOYEE.Dno=DEFAULT
		FROM EMPLOYEE AS E
		JOIN DELETED AS D ON D.DNUMBER=E.DNO;

		DECLARE Department CURSOR FOR
		SELECT Dname,Dnumber,Mgr_ssn
		FROM deleted
		
		OPEN Department 
			FETCH NEXT FROM Department INTO @old_Dname,@old_Dnumber,@old_Mgrssn
		WHILE @@FETCH_STATUS=0
			BEGIN
				EXEC SP_Audit_Dept @old_Dname,NULL, @old_Dnumber,NULL, @old_Mgrssn, NULL;
				FETCH NEXT FROM Department INTO @old_Dname,@old_Dnumber,@old_Mgrssn
			END
	END;
	
	CLOSE Department
	DEALLOCATE Department;
GO




  
