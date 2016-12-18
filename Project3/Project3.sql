-- Add yourself and the related info into Employee, Dependent and Works_on
INSERT INTO EMPLOYEE VALUES ('NAM','H','DO','259470411','06-Jul-89','009 Crazybug , Brooklyn, OH','M', 999999,'123456789',4);

INSERT INTO [DEPENDENT] VALUES ('259470411','LIEN','F','08-Aug-86','Spouse');

INSERT INTO WORKS_ON VALUES('259470411',10,300)

--Q1:Retrieve the name and address of all the female managers
SELECT e.Fname, e.Lname, e.Address 
FROM EMPLOYEE e, DEPARTMENT d 
WHERE e.Sex='F' AND e.Ssn=d.Mgr_ssn;

--Q2:Make a list of all project numbers for projects that involve an employee whose last name is 'Smith',
-- either as a worker or as a manager of the department that controls the project
(SELECT DISTINCT p.Pnumber
FROM PROJECT p, DEPARTMENT d, EMPLOYEE e
WHERE p.Dnum=d.Dnumber AND d.Mgr_ssn=e.Ssn AND e.Lname='Smith')
UNION
(SELECT p.Pnumber
FROM PROJECT p, WORKS_ON w, EMPLOYEE e
WHERE p.Pnumber=w.Pno AND w.Essn=e.Ssn AND e.Lname='Smith');

--Q3: Retieve the name and address and his/her department name of the highest ranked employee
--who does not report to anybody in the company
SELECT e.Fname, e.Lname, e.[Address], d.Dname
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.Super_ssn is NULL AND e.Dno = d.Dnumber;

--Q4: For each department, list all the employees who are working in the department with the employee's
-- first and last name and first and last name of his or her immediate supervisor. List the result in 
--the order of each department number and department name.
-- EXTRA POINT: include all employees who do not have any supervisor as well in the list
SELECT  e.Fname, e.Lname, s.Fname, s.Lname
FROM Employee e
JOIN Department d
ON e.Dno = d.Dnumber
LEFT JOIN Employee s
ON e.Super_ssn = s.Ssn
ORDER BY d.Dnumber, d.Dname;

-- Q5: List the name of managers who have no dependents
SELECT e.Fname, e.Lname
FROM EMPLOYEE e, DEPARTMENT d
WHERE  e.Ssn=d.Mgr_ssn AND e.Ssn NOT IN (SELECT d.Essn
					FROM [DEPENDENT] d);
					
