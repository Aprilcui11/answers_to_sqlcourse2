/* 175. Combine Two Tables*/
SELECT FirstName, LastName, City, State
FROM Person
LEFT JOIN Address
ON Person.PersonId = Address.PersonId

/* 176. Second Highest Salary */
SELECT MAX(Salary) 
FROM Employee
WHERE Salary NOT IN (SELECT MAX(Salary) FROM Employee )

/* 182. Duplicate Emails */
SELECT Email
FROM Person
GROUP BY Email 
HAVING count(Id) > 1

/* 183. Customers who never order */
SELECT Customers.Name AS Customers 
FROM (Customers LEFT JOIN Orders ON Customers.Id = Orders.CustomerId) 
WHERE Orders.CustomerId IS NULL

/*196. Delete Duplicate Emails */
DELETE p2
FROM Person p1, Person p2
WHERE p1.Email = p2.Email AND p1.Id < p2.Id

/*197. Rising Temperature*/
/* Trick: SELF JOIN - select the table two times!!! */
SELECT w2.Id
FROM Weather w1, Weather w2
WHERE TO_DAYS(w2.Date)-TO_DAYS(w1.Date)=1 AND w1.Temperature < w2.Temperature

/* 181. Employees Earning More Than Their Managers */
SELECT e1.Name AS Employee
FROM (Employee e1 LEFT JOIN Employee e2 ON e1.ManagerId=e2.Id)
WHERE e1.Salary > e2.Salary

/* 180 Consecutive Numbers */
SELECT DISTINCT l1.Num AS ConsecutiveNums
FROM Logs l1, Logs l2, Logs l3
WHERE l3.Id-l2.Id=1 AND l2.Id-l1.Id=1 AND l3.Num=l2.Num AND l2.Num=l1.Num

/* 178. Rank Scores */

/* Nth Highest Salary */
/* Answer 1 */
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  set N=N-1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT (
        SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC
        LIMIT 1 OFFSET N
      )
  );
END
/* Answer 2 */
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  SET N=N-1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT DISTINCT Salary 
      FROM Employee e1
      WHERE N = 
      (SELECT COUNT(DISTINCT e2.Salary)
      FROM Employee e2
      WHERE e2.Salary > e1.Salary)
  );
END

/* 185. Department Top Three Salaries */
SELECT Department.Name AS Department, Table1.Name AS Employee, Table1.Salary
FROM
(SELECT *
FROM Employee e1
WHERE 3>
    (SELECT COUNT(DISTINCT e2.Salary)
    FROM Employee e2
    WHERE e2.Salary > e1.Salary AND e1.DepartmentId=e2.DepartmentId)) Table1
JOIN Department
ON Department.Id=Table1.DepartmentId

