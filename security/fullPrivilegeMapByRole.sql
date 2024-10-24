--this query will allow you to retrieve all entities and their full privilege map for a specific role. 
--Where there is a privilege, the word Yes will be indicated, otherwise No. 

SELECT e.Name AS EntityName,
       COALESCE(MAX(CASE WHEN p.AccessRight = 32 AND r.name IS NOT NULL THEN 'Yes' END), 'No') AS CreateAccess,
       COALESCE(MAX(CASE WHEN p.AccessRight = 1 AND r.name IS NOT NULL THEN 'Yes' END), 'No') AS ReadAccess,
       COALESCE(MAX(CASE WHEN p.AccessRight = 2 AND r.name IS NOT NULL THEN 'Yes' END), 'No') AS WriteAccess,
       COALESCE(MAX(CASE WHEN p.AccessRight = 65536 AND r.name IS NOT NULL THEN 'Yes' END), 'No') AS DeleteAccess,
       COALESCE(MAX(CASE WHEN p.AccessRight = 4 AND r.name IS NOT NULL THEN 'Yes' END), 'No') AS AppendAccess,
       COALESCE(MAX(CASE WHEN p.AccessRight = 16 AND r.name IS NOT NULL THEN 'Yes' END), 'No') AS AppendToAccess,
       COALESCE(MAX(CASE WHEN p.AccessRight = 524288 AND r.name IS NOT NULL THEN 'Yes' END), 'No') AS AssignAccess,
       COALESCE(MAX(CASE WHEN p.AccessRight = 262144 AND r.name IS NOT NULL THEN 'Yes' END), 'No') AS ShareAccess
  FROM Entity e WITH(NOLOCK)
  LEFT JOIN PrivilegeObjectTypeCodes potc WITH(NOLOCK) 
    ON e.ObjectTypeCode = potc.ObjectTypeCode
  LEFT JOIN Privilege p WITH(NOLOCK) 
    ON potc.PrivilegeId = p.PrivilegeId
  LEFT JOIN RolePrivileges rp WITH(NOLOCK) 
    ON p.PrivilegeId = rp.PrivilegeId
  LEFT JOIN Role r WITH(NOLOCK) 
    ON rp.RoleId = r.RoleId AND r.name = 'SECURITY_ROLE_NAME'
 GROUP BY e.Name
 ORDER BY e.Name;
