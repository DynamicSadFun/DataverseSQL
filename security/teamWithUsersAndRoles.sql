-- This query allows you to quickly find all teams that have members and have security roles assigned to those teams

SELECT DISTINCT su.fullname AS UserName, t.name AS TeamName, r.name AS RoleName
  FROM team t
  JOIN teamroles tr
    ON tr.teamid = t.teamid
  JOIN role r
    ON tr.roleid = r.roleid
  JOIN teammembership tm
    ON tm.teamid = t.teamid
  JOIN systemuser su
    ON su.systemuserid = tm.systemuserid
