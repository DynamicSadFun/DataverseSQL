--as you know, there should be no more than one attachment under webfiles, 
--but there are often collisions. 
--This simple query will allow you to understand which webfiles have more than one attachment. 
SELECT x.adx_name AS filename, COUNT(DISTINCT a.annotationid) AS count_of_notes
  FROM annotation a
  JOIN adx_webfile x ON a.objectid = x.adx_webfileid
 WHERE x.statecode = 0
   --AND adx_websiteid = 'GUID_PORTAL' -- you can filter it by your portal
 GROUP BY x.adx_name
HAVING COUNT(a.annotationid) > 1
