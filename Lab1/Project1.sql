CREATE DATABASE Company
GO

CREATE TABLE Employee
(
	 Fname		VARCHAR(20)	NOT NULL,
	 Minit		CHAR,  
	 Lname		VARCHAR(20)	NOT NULL,
	 Ssn		CHAR(9)		NOT NULL,
	 Bdate		DATE,
	 [Address]	VARCHAR(30),
	 Sex		CHAR		NOT NULL,
	 Salary		DECIMAL(10,2),
	 Super_ssn	VARCHAR(9)	NULL,
	 Dno		INT			NOT NULL,
);

--Inserting info into table employee according to given table

INSERT INTO Employee VALUES	('John','B','Smith','123456789','09-Jan-55','731 Fondren, Houston,TX','M','30000','987654321','5'),
							('Franklin','T','Wong','333445555','08-Dec-45','638 Voss, Houston, TX','M','40000','888665555','5'),
							('Joyce','A','English','453453453','31-Jul-62','5631 Rice,Houston,TX','F','25000','333445555','5'),
							('Ramesh','K','Narayan','666884444','15-Sep-52','975 Fire,Oak,Humble,TX','M','38000','333445555','5'),
							('James','E','Borg','888665555','10-Nov-27','450 Stone,Houston,TX','M','55000',NULL,'1'),
							('Jennifer','S','Wallace','987654321','20-Jun-31','291 Berry,Bellaire,TX','F','43000','888665555','4'),
							('Ahmad','V','Jabbar','987987987','29-Mar-59','980 Dallas,Houston,TX','M','25000','987654321','4'),
							('Alicia','J','Zelaya','999887777','19-Jul-58','3321 Castle,SPring,TX','F','25000','987654321','4');

--Create table Department with appropriate attributes
CREATE TABLE Department
	(DNAME VARCHAR(15) NOT NULL,
	 DNUMBER CHAR(1) NOT NULL,
	 MGRSSN CHAR(9) NOT NULL,
	 MGRSTARTDATE DATE NOT NULL)
GO


--Inserting info into table Department according to given table

INSERT INTO Department VALUES('Headquarters','1','888665555','19-Jun-71'),
('Administration', '4', '987654321' ,'01-Jan-85'),
('Research', '5', '333445555', '22-May-78'),
('Automation', '7', '123456789', '06-Oct-05')

