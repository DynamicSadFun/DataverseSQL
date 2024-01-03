--Identify contacts that might be slipping away due to lack of recent interaction

SELECT DISTINCT c.contactid, c.fullname, MAX(a.modifiedon) AS LastActivityDate
  FROM contact c
  JOIN activitypointer a
    ON c.contactid = a.regardingobjectid
 GROUP BY c.contactid, c.fullname
HAVING DATEDIFF(month, MAX(a.modifiedon), GETDATE()) > 6; -- More than 6 months
