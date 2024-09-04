--this script will allow you to analyze the processes in your system in detail.
--Note that here it contains the entity on which the process is based, 
--a description of how the process is executed (synchronous or asynchronous), 
--and a smart field for extracting the “Runs only manually” indicator.

SELECT DISTINCT w.workflowid, 
                w.name, 
                CASE 
                   WHEN (w.mode = 0 AND w.ondemand = 0) THEN 'OffDemand-Async'
                   WHEN (w.mode = 1 AND w.ondemand = 0) THEN 'OffDemand-Sync'
                   WHEN (w.mode = 0 AND w.ondemand = 1) THEN 'OnDemand-Async'
                   WHEN (w.mode = 1 AND w.ondemand = 1) THEN 'OnDemand-Sync'
                   ELSE NULL
                END AS [Workflow Type],
                IIF((w.triggeroncreate = 0
                    AND w.triggerondelete = 0
                    AND w.triggeronupdateattributelist IS NULL
                    AND w.subprocess = 0 
                    AND w.ondemand = 1), 'Yes', 'No') AS RunOnlyManual, 
                w.primaryentityname AS [Main Entity],
                w.owneridname AS [Owner], 
                w.createdbyname AS [Creator]
  FROM workflow w WITH(NOLOCK)
 WHERE w.type = 1
   AND w.statecode = 1
   AND w.categoryname = 'Workflow'
