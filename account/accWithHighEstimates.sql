--Find accounts with associated open opportunities totaling a high value.

SELECT a.accountid, a.name, SUM(o.estimatedvalue) AS TotalEstimatedValue
  FROM account a
  JOIN opportunity o
    ON a.accountid = o.accountid -- think about o.accountid field. Maybe in your system you're using CustomerID field? Then you should use it here. 
 WHERE o.statecode = 0 -- Assuming 0 for open opportunities and active accounts
   AND a.statecode = 0
 GROUP BY a.accountid, a.name
HAVING SUM(o.estimatedvalue) > 100000; -- Modify as per what constitutes 'high value'
