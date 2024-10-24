--This query helps to find roles with a specific privilege
SELECT DISTINCT p.name, r.name
  FROM role r
  JOIN roleprivileges rp
    ON r.roleid = rp.roleid
  JOIN privilege p
    ON rp.privilegeid = p.privilegeid
 WHERE p.name LIKE '%readopportunity%' -- you can find by privilege name or role name
