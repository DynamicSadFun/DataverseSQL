--This query allows us to select users with a last logon date (via audit), 
--and as a bonus, provides a comma-separated, single-cell selection of their roles.

SELECT MAX(aud.dt) 		AS MaxDateTimeLogin,
	     su.systemuserid 	AS UserID,
	     su.fullname	AS UserName, 
	     su.domainname	AS UserDomain,
	     ISNULL(STUFF(
				(
				 SELECT ', ' + r.name
				   FROM systemuserroles sur WITH(NOLOCK)
				   JOIN role r WITH(NOLOCK)
				     ON sur.roleid = r.roleid
				  WHERE sur.systemuserid = su.systemuserid
				  ORDER BY r.name
				    FOR XML PATH('')
				), 1, 2, ''
			), 
		'No Roles')	AS UserRoles
  FROM systemuser su WITH(NOLOCK)
  JOIN (
        SELECT a.objectid, MAX(a.createdon) AS DT 
          FROM audit a WITH(NOLOCK)
         WHERE a.action = 64 	-- action User Access via Web
         GROUP BY a.objectid
       ) aud
    ON su.systemuserid = aud.objectid
 WHERE su.applicationid IS NULL -- remove Application User from this selection
   AND su.isdisabled = 0        -- active users
   AND su.accessmode = 0        -- read-write users (it means physical person)
 GROUP BY su.systemuserid,
          su.fullname, 
          su.domainname
