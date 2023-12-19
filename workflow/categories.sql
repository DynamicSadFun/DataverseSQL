SELECT w.categoryname, COUNT(DISTINCT w.workflowid)
  FROM workflow w WITH(NOLOCK)
 WHERE type = 1        -- definition
   AND statecode = 1   -- activated
   AND w.workflowid NOT IN (
        -- this query cuts off all those processes that belong to the system
        -- For your part, you should find identifiers of non-your publishers and add them to the IN clause. 
        SELECT w.workflowid
          FROM workflow w WITH(NOLOCK)
          JOIN solutioncomponent sc WITH(NOLOCK) 
            ON w.workflowid = sc.objectid  -- join the component and workflow tables in order to exclude all those processes contained in the OOB solutions
          JOIN solution s WITH(NOLOCK)
            ON sc.solutionid = s.solutionid
        WHERE s.publisherid IN (  '11fe0dab-932b-4eb9-896b-3a5efbf96209'    -- Dynamics 365
                                , '51ddbfa1-f4a3-4630-a01f-9e835b7588f2'    -- Dynamics Marketing
                                , '6dc5d729-99e6-41f4-a1ea-80c9940a05e5'    -- Microsoft
                                , 'd21aab70-79e7-11dd-8874-00188b01e34f'    -- MicrosoftCorporation
                                , 'd21aab72-79e7-11dd-8874-00188b01e34f'    -- Publisher for Microsoft First Party Solutions
                                )            
           )      
 GROUP BY w.categoryname
 ORDER BY w.categoryname
