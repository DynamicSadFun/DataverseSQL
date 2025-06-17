--This query helps to understand how frequently you're interacting with contacts by counting activities associated with each contact over the months.

SELECT c.contactid, 
       c.fullname, 
       a.activitytypecodename,
       MONTH(a.createdon) AS InteractionMonth, 
       YEAR(a.createdon)  AS InteractionYear, 
       COUNT(*)           AS InteractionCount
  FROM contact c
  JOIN activitypointer a 
    ON c.contactid = a.regardingobjectid
 GROUP BY c.contactid, c.fullname, a.activitytypecodename, MONTH(a.createdon), YEAR(a.createdon)
 ORDER BY InteractionYear, InteractionMonth, c.fullname, InteractionCount DESC;
