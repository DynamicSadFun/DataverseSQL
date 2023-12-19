-- this query will allow us to find all the processes that are manually executed in the system. 
-- That is, they have no trigger, no initiating events
SELECT DISTINCT
       w.workflowid,
       w.name,
       w.modename,
       w.categoryname
  FROM workflow w WITH(NOLOCK)
  JOIN solutioncomponent sc WITH(NOLOCK)
    ON sc.objectid = w.workflowid  
  JOIN solution s WITH(NOLOCK)
    ON s.solutionid = sc.solutionid
 WHERE s.publisherid = 'SET_YOUR_PUBLISHER_GUID'   -- you can remove this condition, but note that then the result will contain data including OOB processes
   AND type = 1                                    -- definition
   AND statecode = 1                               -- activated
   AND w.triggeroncreate = 0                       -- no trigger for create event
   AND w.triggerondelete = 0                       -- no trigger for delete event
   AND w.triggeronupdateattributelist IS NULL      -- no trigger for update event
   AND w.subprocess = 0                            -- exclude the possibility of calling this process as a Child process for others workflows
   AND w.ondemand = 1                              -- run manually = yes
