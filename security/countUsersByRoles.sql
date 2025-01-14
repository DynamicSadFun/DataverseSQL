SELECT r.name, COUNT(DISTINCT su.systemuserid) AS CountOfUsers
  FROM systemuser su
  JOIN systemuserroles sur
    ON su.systemuserid = sur.systemuserid
  JOIN role r
    ON r.roleid = sur.roleid
 WHERE su.applicationid IS NULL -- remove Application User from this selection
   AND su.isdisabled = 0        -- active users
   AND su.accessmode = 0        -- read-write users (it means physical person)
 GROUP BY r.name
