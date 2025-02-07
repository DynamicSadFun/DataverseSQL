-- get all owner by functional (not user data) components
-- for plugins, model-driven apps and some other stuff we don't have ownerid field

SELECT w.categoryname           AS Category, 
       w.owneridname            AS OwnerName, 
       COUNT(DISTINCT w.name)   AS CountOfComponents
  FROM workflow w WITH(NOLOCK)
 WHERE type = 1
   AND statecode = 1
 GROUP BY w.owneridname, w.categoryname
 UNION
SELECT 'Connection Reference', 
       owneridname, 
       COUNT(DISTINCT connectionreferenceid)
  FROM connectionreference WITH(NOLOCK)
 WHERE statecode = 0 
 GROUP BY owneridname
 UNION
SELECT 'Report', 
       owneridname, 
       COUNT(DISTINCT reportid)
  FROM report s WITH(NOLOCK)
 GROUP BY owneridname
 UNION
SELECT 'Template', 
       owneridname, 
       COUNT(DISTINCT templateid)
  FROM template s WITH(NOLOCK)
 GROUP BY owneridname
 UNION
SELECT 'View', 
       owneridname, 
       COUNT(DISTINCT userqueryid)
  FROM userquery s WITH(NOLOCK)
 GROUP BY owneridname
 UNION
SELECT 'Custom API', 
       owneridname, 
       COUNT(DISTINCT customapiid)
  FROM customapi r WITH(NOLOCK)
 WHERE r.statecode = 0
 GROUP BY owneridname
 UNION
SELECT 'Canvas App', 
       owneridname, 
       COUNT(DISTINCT canvasappid)
  FROM canvasapp r WITH(NOLOCK)
 GROUP BY owneridname
 ORDER BY 3 DESC, 1, 2
 
