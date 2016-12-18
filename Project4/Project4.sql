--Q1: UPDATING DEPENDENT AND WORKS_ON
INSERT INTO [DEPENDENT] VALUES	('453453453','Joe','M',NULL,'Spouse'),
								('987654321','Erica','F',NULL,'Daughter');

INSERT INTO WORKS_ON VALUES		('987654321',10,0);

SELECT * FROM [DEPENDENT];

SELECT * FROM WORKS_ON;

--Part 2 Q1
/*For each department, list all the employees who are working in the department with the
employee’s first and last name and first and last name of his or her immediate supervisor. Include
all the departments and all the employees who do not have any supervisor. List the result in the
order of each department number and first name of each employee*/

SELECT E.Fname, E.Lname, S.Fname, S.Lname,D.Dname, D.Dnumber, E.Fname
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.Dno=D.Dnumber 
LEFT JOIN EMPLOYEE S
ON E.Super_ssn=S.Ssn
ORDER BY D.Dnumber, E.Fname;

-- Part 2 Q 1.1:
/*List the same information as Q1 with a change: List all the employees who do not have any
supervisor but do not list the departments that no employee is working for in the output. */

SELECT E.Fname, E.Lname, S.Fname, S.Lname, D.Dname , D.Dnumber, E.Fname
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.Dno=D.Dnumber 
LEFT JOIN EMPLOYEE S
ON E.Super_ssn=S.Ssn
ORDER BY D.Dnumber, E.Fname;

--PART 2: QUESTION 2
--Get SSN and the last name of married female employees who work on three or more projects 

SELECT DISTINCT E.SSN, E.Lname
FROM EMPLOYEE E, WORKS_ON W1, [DEPENDENT] D
	WHERE	E.Sex ='F'
	AND		E.Ssn=D.Essn 
	AND		D.Relationship='Spouse' 
	AND		E.SSN= W1.Essn 
	AND		W1.Essn IN	(SELECT W2.ESSN 
						FROM EMPLOYEE E2, WORKS_ON W2
						WHERE E2.Ssn=W2.Essn 
						GROUP BY W2.Essn
						HAVING COUNT(W2.Essn)>=3);
            
--Part 2 Q3
--List the name of employees who is working for ‘Research’ department and are married but have no children.
--Married = Select ESSN From Dependent Where relationship = ‘spouse’;
--Girls = Select ESSN From Dependent Where relationship = ‘daughter’;
--Boys = Select ESSN From Dependent Where relationship = ‘son’; 

SELECT DISTINCT E.Lname, E.Fname
FROM EMPLOYEE E, [DEPENDENT] D1, DEPARTMENT S
WHERE E.Ssn = D1.Essn 
	AND E.Dno=S.Dnumber
	AND S.Dname='research'
	AND D1.Essn NOT IN
			(SELECT D2.Essn
			FROM [DEPENDENT] D2
			WHERE D2.Relationship ='Son' OR D2.Relationship ='Daughter')
	AND D1.Essn IN
			(SELECT D3.Essn
			FROM [DEPENDENT] D3
			WHERE D3.Relationship = 'Spouse');
      
--Part 2 Question 4
--Get the last name of married employees who only have daughters. 
SELECT DISTINCT E.Lname, E.Fname
FROM EMPLOYEE E, [DEPENDENT] D1
WHERE E.Ssn = D1.Essn 
	AND D1.Essn NOT IN
			(SELECT D2.Essn
			FROM [DEPENDENT] D2
			WHERE D2.Relationship ='Son')
	AND D1.Essn IN
			(SELECT D3.Essn
			FROM [DEPENDENT] D3
			WHERE D3.Relationship = 'Spouse')
	AND D1.Essn IN
			(SELECT D4.Essn
			FROM [DEPENDENT] D4
			WHERE D4.Relationship = 'Daughter');
      
  --Assignment 4: Part 2  question 5
--Give the last name and ssn of those employees who work in any project(s) where there
--are more female than male employees.

SELECT E1.Lname, E1.Ssn
FROM Employee E1, WORKS_ON W1
WHERE E1.Ssn= W1.Essn
AND	(SELECT COUNT(*)
    FROM Employee E2, Works_On W2
    WHERE E2.Ssn=W2.Essn 
	AND E2.Sex = 'M' 
	AND W2.Pno = W1.Pno) < (SELECT COUNT(*)
							FROM Works_On W3, EMPLOYEE E3
							WHERE W3.Essn=E3.Ssn
							AND E3.Sex = 'F' 
							AND W3.Pno = W1.Pno);
