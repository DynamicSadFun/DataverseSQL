-- This query allows you to find tables that are contained in certain solutions. 
-- The query relies on the solutioncomponent table, which serves as a bridge between the solution and entity metadata. 
-- Also, note that here we can see which tables are out-of-the-box and which are custom.
-- Make the data filtering as you see fit. 

SELECT DISTINCT 
       e.displayname    AS [Entity Name],
       e.logicalname    AS [Logical Name], 
       IIF( e.iscustomentity != 0 
            AND e.logicalname NOT LIKE 'adx%' 
            AND e.logicalname NOT LIKE 'msdyn%', 
           'Custom', 
           'OOB'
       )                AS [Is It Custom Entity?]
       sol.friendlyname AS [Solution Name]      
  FROM metadata.entity e WITH(NOLOCK)
  JOIN solutioncomponent sc WITH(NOLOCK)
    ON sc.objectid = e.metadataid
  JOIN solution sol WITH(NOLOCK)
    ON sc.solutionid = sol.solutionid
 WHERE e.displayname IS NOT NULL
   AND sol.friendlyname IN ('ADD_YOUR_SOLUTIONS')
 ORDER BY 1, 3
