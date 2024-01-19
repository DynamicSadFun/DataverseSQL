-- This query will show you which of your managed components are contained in multiple managed solutions. 
-- It is not uncommon for a single component to be in multiple solutions. It makes sense to rule this out. 
-- Unfortunately, there is no means to show the names of the solutions at once in this query. 
-- You need to take the objectid, add it to the filter and select s.friendlyname
-- In the same way, you can use the objectid and the name of the entity to create a query to retrieve the name of this component.

SELECT sc.componenttype, 
       sc.componenttypename, 
       sc.objectid,
       COUNT(s.friendlyname)
  FROM solution s
  JOIN solutioncomponent sc
    ON s.solutionid = sc.solutionid
 WHERE s.ismanaged = 1
   AND s.isvisible = 1
   AND s.publisherid = 'YOUR_PUBLISHER_GUID'
 GROUP BY sc.componenttype, sc.componenttypename, sc.objectid
HAVING COUNT(s.friendlyname) > 1
 ORDER BY 4 DESC

