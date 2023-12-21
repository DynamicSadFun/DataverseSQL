--We are trying to find all unmanaged components that are contained in a managed solution, but were also published in unmanaged solutions. 

SELECT DISTINCT 
       s.friendlyname                   AS [Unmanaged Solution Name], 
       s.createdon                      AS [Created On], 
       s.createdbyname                  AS [Created By],  
       sc.objectid                      AS [Unmanaged Component ID],
       sc.componenttype                 AS [Unmanaged Component],
       CASE sc.componenttype
        WHEN 80 THEN 'App Module'
        WHEN 10430 THEN 'Connection Reference'
        ELSE sc.componenttypename     
       END                              AS [Unmanaged Component Type],
       --managed.objectid                 AS [Managed Component ID],
       managed.friendlyname             AS [This Component Contains In Managed Solution Name]
  FROM solution s
  JOIN solutioncomponent sc 
    ON s.solutionid = sc.solutionid
  LEFT JOIN (
    SELECT manSol.friendlyname, manComp.objectid
      FROM solutioncomponent manComp
      JOIN solution manSol
        ON manSol.solutionid = manComp.solutionid
     WHERE manSol.ismanaged = 1
       AND manSol.isvisible = 1
   ) AS managed
    ON managed.objectid = sc.objectid
 WHERE s.ismanaged = 0
   AND s.isvisible = 1
   AND s.friendlyname NOT IN ('Active Solution', 'Default Solution', 'Common Data Services Default Solution')
 ORDER BY s.createdon
