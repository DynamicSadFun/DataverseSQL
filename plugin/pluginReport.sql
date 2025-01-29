-- full analyze about your plugins
SELECT DISTINCT 
       step.sdkmessageprocessingstepid                  AS [PluginStepId],
       step.eventhandlername                            AS [HandlerName],
       step.Name                                        AS [PluginstepName],
       step.plugintypeidname                            AS [PluginTypeName],
       IIF(step.modename = 'Synchronous', 'YES', 'NO')  AS [Sync?],
       step.stagename                                   AS [StageName],
       step.sdkmessageidname                            AS [Event],
       filter.primaryobjecttypecodename                 AS [PrimaryEntity],
       step.FilteringAttributes                         AS [FilteringFields],
       s.friendlyname                                   AS [SolutionName]
  FROM sdkmessageprocessingstep step WITH(NOLOCK)
  JOIN sdkmessagefilter filter WITH(NOLOCK)
    ON step.sdkmessagefilterid = filter.sdkmessagefilterid
  JOIN solutioncomponent sc WITH(NOLOCK)
    ON sc.objectid = step.sdkmessageprocessingstepid
  JOIN solution s WITH(NOLOCK)
    ON sc.solutionid = s.solutionid
 WHERE step.statecode = 0 -- Active steps
   AND s.friendlyname NOT IN ('Active Solution', 'Basic Solution', 'System Solution', 'Default Solution') -- put here your solutions
 ORDER BY step.stagename, step.sdkmessageidname
