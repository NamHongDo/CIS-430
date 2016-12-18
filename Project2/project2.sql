CREATE TABLE PROJECT
(
	Pname		VARCHAR(20)		NOT NULL,
	Pnumber		INT				NOT NULL,
	Plocation	VARCHAR(20),
	Dnum		INT				NOT NULL,
	PRIMARY KEY (Pnumber),	
);

INSERT INTO PROJECT VALUES	('ProductX',1,'Bellaire',5),
							('ProductY',2,'Sugarland',5),
							('ProductZ',3,'Houston',5),
							('Computerization',10,'Stafford',4),
							('Reorganization',20,'Houston',1),
							('Newbenefits',30,'Stafford',4);
              
CREATE TABLE [DEPENDENT]
(
Essn			CHAR(9)			NOT NULL,
Dependent_name	VARCHAR(15)		NOT NULL,
Sex				CHAR,	
Bdate			DATE,
Relationship	VARCHAR(10),
PRIMARY KEY(Essn, Dependent_name)
);

INSERT INTO [DEPENDENT] VALUES	('123456789','Alice','F','31-Dec-78','Daughter'),
								('123456789','Elizabeth','F','05-May-57','Spouse'),
								('123456789','Michael','M','01-Jan-78','Son'),
								('333445555','Alice','F','05-Apr-76','Daughter'),
								('333445555','Joy','F','03-May-48','Spouse'),
								('333445555','Theodore','M','25-Oct-73','Son'),
								('987654321','Abner','M','29-Feb-32','Spouse');
                
CREATE TABLE DEPT_LOCATIONS
(
	Dnumber		INT				NOT NULL,
	Dlocation	VARCHAR(15)		NOT NULL,
	PRIMARY KEY ( Dnumber, Dlocation)
);

INSERT INTO DEPT_LOCATIONS VALUES	(1,'Houston'),
									(4,'Stafford'),
									(5,'Bellaire'),
									(5,'Sugarland'),
									(5,'Houston');
                  
CREATE TABLE WORKS_ON
(
	Essn		CHAR(9),
	Pno			INT		NOT NULL,
	[Hours]		INT,
	PRIMARY KEY (Essn,Pno)
);

INSERT INTO WORKS_ON VALUES	('123456789',1,32.5),
							('123456789',2,7.5),
							('333445555',2,10),
							('333445555',3,10),
							('333445555',10,10),
							('333445555',20,10),
							('453453453',1,20),
							('453453453',2,20),
							('666884444',3,40),
							('888665555',20,NULL),
							('987654321',20,15),
							('987654321',30,20),
							('987987987',10,35),
							('987987987',30,5),
							('999887777',10,10),
							('999887777',30,30);
              
 -- Adding PK FK constraint between tables           
 ALTER TABLE EMPLOYEE ADD
	FOREIGN KEY (Super_ssn)REFERENCES dbo.EMPLOYEE(Ssn),
	FOREIGN KEY (Dno)REFERENCES dbo.DEPARTMENT(Dnumber);

ALTER TABLE DEPARTMENT ADD
	FOREIGN KEY (Mgr_ssn)REFERENCES dbo.EMPLOYEE(Ssn);

ALTER TABLE DEPT_LOCATIONS ADD
	FOREIGN KEY (Dnumber) REFERENCES dbo.DEPARTMENT(Dnumber);

ALTER TABLE	PROJECT ADD
	FOREIGN KEY (Dnum) REFERENCES dbo.DEPARTMENT (Dnumber);

ALTER TABLE WORKS_ON ADD
	FOREIGN KEY (Essn) REFERENCES dbo.EMPLOYEE(Ssn),
	FOREIGN KEY (Pno) REFERENCES dbo.PROJECT(Pnumber);

ALTER TABLE [DEPENDENT] ADD
	FOREIGN KEY (Essn) REFERENCES dbo.EMPLOYEE(Ssn);
