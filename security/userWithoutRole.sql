--This helps in auditing and ensuring all users have appropriate access and roles.

SELECT DISTINCT 
       su.systemuserid, 
       su.fullname, 
       IIF(sur.roleid IS NOT NULL, 'User has some role', 'No roles') AS result
  FROM systemuser su  
  LEFT JOIN systemuserroles sur 
    ON su.systemuserid = sur.systemuserid 
 WHERE su.applicationid IS NULL -- remove Application User from this selection
   AND su.isdisabled = 0        -- active users
   AND su.accessmode = 0        -- read-write users (it means physical person)
 ORDER BY 2
