--This helps in auditing and ensuring all users have appropriate access and roles.

SELECT DISTINCT su.systemuserid, su.fullname 
  FROM systemuser su  
  LEFT JOIN systemuserroles sur 
    ON su.systemuserid = sur.systemuserid 
 WHERE sur.systemuserid IS NULL 
   AND su.isdisabled = 0 -- Assuming isdisabled flag is 0 for enabled users
 ORDER BY 2
