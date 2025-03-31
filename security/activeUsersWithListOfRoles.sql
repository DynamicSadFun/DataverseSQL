--this query will show you users (non-apps) active in the system who have at least one role, 
--and the list of roles itself be presented in a single cell for convenience 
SELECT DISTINCT 
       su.systemuserid,
	     su.fullname, 
	     su.domainname,
       ISNULL(STUFF(
					(SELECT ', ' + r.name
					   FROM systemuserroles sur WITH(NOLOCK)
					   JOIN role r WITH(NOLOCK)
					     ON sur.roleid = r.roleid
					  WHERE sur.systemuserid = su.systemuserid
					  ORDER BY r.name
					    FOR XML PATH('')), 1, 2, ''
				   ), 
			 'No Roles'
	     ) AS roles
  FROM systemuser su
  JOIN systemuserroles surr WITH(NOLOCK)
    ON su.systemuserid = surr.systemuserid
  JOIN role rr WITH(NOLOCK)
	  ON surr.roleid = rr.roleid
 WHERE su.applicationid IS NULL -- remove Application User from this selection
   AND su.isdisabled = 0 -- active users
   AND su.accessmode = 0 -- read-write users (it means physical person)
 ORDER BY 2 
