-- This query calculates the total number of activities (emails, phone calls, tasks, etc.) 
-- linked to contacts for each account and retrieves the top five accounts with the most engaged contacts.
SELECT TOP 5
       acc.name AS [Account Name],
       COUNT(act.createdon) AS cnt
  FROM account acc
  JOIN contact con 
    ON acc.accountid = con.parentcustomerid
  JOIN activitypointer act 
    ON con.contactid = act.regardingobjectid
 GROUP BY acc.name
 ORDER BY 2 DESC
