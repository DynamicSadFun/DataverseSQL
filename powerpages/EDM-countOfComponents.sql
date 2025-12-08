--This query is designed for the Power Pages Enhanced Data Model.
--Allows you to count the number of components across all types quickly.
SELECT pc.powerpagecomponenttypename, COUNT(*) AS cnt
  FROM powerpagecomponent pc
 WHERE pc.statecode = 0
 GROUP BY pc.powerpagecomponenttypename
 ORDER BY 2 DESC
