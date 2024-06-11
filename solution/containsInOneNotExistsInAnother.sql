--This query will show components that are contained in one solution but are not contained in another.
--A kind of reconciliation to avoid incorrect Solution Layering. 

SELECT DISTINCT sc1.objectid, sc1.componenttypename
  FROM solution s1
  JOIN solutioncomponent sc1
    ON s1.solutionid = sc1.solutionid
 WHERE s1.friendlyname = 'YOUR_SOLUTION_NAME_#1'
   AND NOT EXISTS
(
    SELECT TOP 1 1
      FROM solution s
      JOIN solutioncomponent sc
        ON s.solutionid = sc.solutionid
     WHERE s.friendlyname = 'YOUR_SOLUTION_NAME_#2'
       AND sc.objectid = sc1.objectid
)
