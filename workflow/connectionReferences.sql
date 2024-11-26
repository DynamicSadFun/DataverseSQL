-- this query parses the contents of your PA flows, 
-- extracts connectors from them and groups your flows by them, 
-- counting how many flows belong to a particular connector.
WITH JsonData AS (
    -- Extract the connection references from the JSON clientdata field
    SELECT w.name AS FlowName, 
           JSON_VALUE(c.value, '$.api.name') AS ConnectorName
      FROM workflow w WITH(NOLOCK)
     CROSS APPLY OPENJSON(w.clientdata, '$.properties.connectionReferences') AS c
     WHERE w.categoryname = 'Modern Flow'
       AND w.statecode = 1 -- only active flows
)
-- Group the results by ConnectorName and count the number of flows for each connector
SELECT ConnectorName, 
       COUNT(FlowName) AS FlowCount
  FROM JsonData
 WHERE ConnectorName IS NOT NULL
 GROUP BY ConnectorName
 ORDER BY FlowCount DESC;
 
