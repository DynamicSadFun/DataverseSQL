--We are trying to find all unmanaged components that are contained in a managed solution, but were also published in unmanaged solutions. 

WITH ManagedSolutions AS (
    SELECT manComp.objectid, manSol.friendlyname
      FROM solutioncomponent manComp
      JOIN solution manSol
        ON manSol.solutionid = manComp.solutionid
       AND manSol.ismanaged = 1
       AND manSol.isvisible = 1
),
UnmanagedComponents AS (
    SELECT DISTINCT
           s.friendlyname     AS [Unmanaged Solution Name],
           s.createdon        AS [Created On],
           s.createdbyname    AS [Created By],
           sc.objectid        AS [Unmanaged Component ID],
           sc.componenttype   AS [Unmanaged Component Type],
           ISNULL
           (
             CASE sc.componenttype
               WHEN 80 THEN 'App Module'
               WHEN 10430 THEN 'Connection Reference'
               ELSE sc.componenttypename   
             END, 
             'Other Component (please check the solution)'
           )                    AS [Unmanaged Component Name],
           managed.friendlyname AS [Contained in Managed Solution Name]
      FROM solution s
      JOIN solutioncomponent sc
        ON s.solutionid = sc.solutionid
      LEFT JOIN ManagedSolutions managed
        ON managed.objectid = sc.objectid
     WHERE s.ismanaged = 0
       AND s.isvisible = 1
       AND s.friendlyname NOT IN ('Active Solution', 'Default Solution', 'Common Data Services Default Solution')
)

SELECT [Unmanaged Solution Name], 
       [Created On], 
       [Created By], 
       [Unmanaged Component ID], 
       [Unmanaged Component Type],
       [Unmanaged Component Name],
       [Contained in Managed Solution Name]
  FROM UnmanagedComponents
 ORDER BY [Created On];
