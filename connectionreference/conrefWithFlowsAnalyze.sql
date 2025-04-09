--This SQL query allows you to analyze Connection References in your system, 
--in particular, which ones are involved in your PA flows and which ones you can painlessly get rid of

WITH JsonData AS (
    -- Extract the connection references from the JSON clientdata field
    SELECT w.name AS FlowName, 
           JSON_VALUE(c.value, '$.connection.connectionReferenceLogicalName') AS ConRefName
      FROM workflow w WITH(NOLOCK)
     CROSS APPLY OPENJSON(w.clientdata, '$.properties.connectionReferences') AS c
     WHERE w.categoryname = 'Modern Flow'
       AND w.statecode = 1 -- only active flows
)
SELECT cr.connectionreferencedisplayname                                            AS DisplayName,
       cr.connectionreferencelogicalname                                            AS LogicalName,
       REPLACE(cr.connectorid, '/providers/Microsoft.PowerApps/apis/shared_', '')   AS ConnectorName,
       COUNT(j.FlowName)                                                            AS CountOfFlows,
       IIF(cr.ismanaged = 1, 'Yes', 'No')                                           AS IsManaged,
       cr.createdon                                                                 AS CreationDate,
       cr.createdbyname                                                             AS CreatedBy,
       cr.owneridname                                                               AS OwnerName,
       cr.statecodename                                                             AS Status,
       CASE 
            WHEN COUNT(j.FlowName) = 0 AND cr.ismanaged = 1
                THEN 'Can be removed, but via repository and release'
            WHEN COUNT(j.FlowName) = 0 AND cr.ismanaged = 0
                THEN 'Can be removed directly from the environment, manually'
            ELSE 'Cannot be removed because it is used in some flows'
       END                                                                          AS Comment
  FROM JsonData j
 RIGHT JOIN connectionreference cr
    ON j.ConRefName = cr.connectionreferencelogicalname    
 WHERE cr.connectionreferencelogicalname NOT LIKE 'msdyn_%' -- make sense to exclude Dynamics OOB con refs
 GROUP BY cr.connectionreferencedisplayname,
          cr.connectionreferencelogicalname, 
          cr.ismanaged,
          REPLACE(cr.connectorid, '/providers/Microsoft.PowerApps/apis/shared_', ''),
          cr.createdon,
          cr.createdbyname,
          cr.owneridname,
          cr.statecodename
 ORDER BY 4 DESC
