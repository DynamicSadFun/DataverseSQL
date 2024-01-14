--Overdue Tasks by User
--This query identifies tasks that are overdue and groups them by the owner, which can be useful for follow-ups and performance reviews.

SELECT t.ownerid, 
       su.fullname, 
       COUNT(t.activityid) AS OverdueTasks
  FROM task t
  JOIN systemuser su 
    ON t.ownerid = su.systemuserid
 WHERE t.statecode = 0 -- State '0' for 'Open'; tasks past their due date
   AND t.scheduledend < GETDATE() 
 GROUP BY t.ownerid, su.fullname;
