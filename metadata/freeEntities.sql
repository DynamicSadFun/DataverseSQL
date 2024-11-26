--identifying custom entities that are part of a specific solution 
--but are not associated with any workflows or plugin steps

SELECT DISTINCT e.logicalname AS [Entity Logical Name],
                e.objecttypecode AS [Object Type Code]
  FROM metadata.entity AS e
  LEFT JOIN workflow AS w
    ON e.logicalname = w.primaryentity
  LEFT JOIN sdkmessagefilter AS sdk
    ON e.logicalname = sdk.primaryobjecttypecode
   AND sdk.workflowsdkstepenabled = 1 -- exclude OOB plugins
 WHERE e.iscustomentity = 1 -- get only custom entities
   AND e.metadataid IN (
            SELECT sc.objectid
              FROM solution AS s
              JOIN publisher AS p
                ON s.publisherid = p.publisherid
              JOIN solutioncomponent AS sc
                ON s.solutionid = sc.solutionid
             WHERE p.customizationprefix = 'PREFIX_YOUR_ORG' -- put prefix of your publisher here
               AND s.friendlyname NOT IN ('Active Solution', 'Default Solution', 'Common Data Services Default Solution') -- exclude Default Solutions
       )
   AND w.workflowid IS NULL -- exclude processes
   AND sdk.sdkmessagefilterid IS NULL -- exclude plugins
ORDER BY logicalname;
