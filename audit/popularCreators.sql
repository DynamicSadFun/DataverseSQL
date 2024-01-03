--Identify which users are most active in creating records across the system

SELECT su.systemuserid, su.fullname, COUNT(DISTINCT a.auditid)
  FROM systemuser su
  JOIN audit a
    ON su.systemuserid = a.userid
 WHERE a.action = 1 -- Assuming 1 is the code for create
 GROUP BY su.systemuserid, su.fullname
