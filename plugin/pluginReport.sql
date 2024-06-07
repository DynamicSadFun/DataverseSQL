-- find our plugins with modename (Sync / Async) and autodelete logs flag

SELECT DISTINCT asyncautodeletename, plugin.modename, plugin.name, solution.friendlyname
  FROM sdkmessageprocessingstep plugin WITH(NOLOCK)
  JOIN solutioncomponent sc WITH(NOLOCK)
    ON sc.objectid = plugin.sdkmessageprocessingstepid
  JOIN solution WITH(NOLOCK)
    ON sc.solutionid = solution.solutionid
-- put your solution or publisher name into condition
 WHERE solution.friendlyname = 'YOUR_SOLUTION_NAME'
    OR solution.publisheridname = 'YOUR_PUBLISHER_NAME'
