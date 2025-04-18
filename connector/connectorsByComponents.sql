-- This query helps to understand what types of connectors 
-- are used in the system by different types of components. 
-- Group by connector and component type, counts the number. 

-- Connectors used in Cloud Flows
WITH FlowConnectors AS (
    SELECT DISTINCT
           REPLACE(LOWER(JSON_VALUE(c.value, '$.api.name')), 'shared_', '') AS ConnectorName,
           'Flow'       AS Source, 
           w.workflowid AS SourceID
      FROM workflow w
     CROSS APPLY OPENJSON(w.clientdata, '$.properties.connectionReferences') AS c
     WHERE w.categoryname = 'Modern Flow'   -- PA flow 
	     AND w.statecode = 1                  -- Active 
),

-- Connectors used in Canvas Apps
CanvasConnectors AS (
    SELECT DISTINCT
           REPLACE(LOWER(JSON_VALUE(value, '$.id')), '/providers/microsoft.powerapps/apis/shared_', '') AS ConnectorName,
           'CanvasApp'      AS Source, 
           ca.canvasappid   AS SourceID
      FROM canvasapp ca
     CROSS APPLY OPENJSON(ca.connectionreferences)
),

-- Connectors declared in Connection References (regardless of usage)
ConnectionRefConnectors AS (
    SELECT DISTINCT
           REPLACE(LOWER(connectorid), '/providers/microsoft.powerapps/apis/shared_', '') AS ConnectorName,
           'ConnectionReference'    AS Source,
           cr.connectionreferenceid AS SourceID
      FROM connectionreference cr
     WHERE cr.connectionreferencelogicalname NOT LIKE 'msdyn_%' -- exclude OOB / Dynamics365 connectors
)

-- Combine all sources into one view
SELECT ConnectorName,
       Source,
       COUNT(*) AS UsageCount
  FROM (
        SELECT * FROM FlowConnectors
        UNION ALL
        SELECT * FROM CanvasConnectors
        UNION ALL
        SELECT * FROM ConnectionRefConnectors
     ) AS AllConnectors
 WHERE ConnectorName IS NOT NULL
 GROUP BY ConnectorName, Source
 ORDER BY 3 DESC, 2, 1
