--This query will allow you to find all components that have been added and/or changed as part of the solutions on your environment recently. 
--Filter by date and check it out.

SELECT DISTINCT 
       s.friendlyname,
       s.createdon,
       s.createdbyname,
       sc.objectid,
       sc.componenttypename,
       sc.createdon,
       sc.createdonbehalfbyname,
       sc.modifiedon,
       sc.modifiedonbehalfbyname
  FROM solutioncomponent AS sc
  JOIN solution AS s
    ON sc.solutionid = s.solutionid 
 WHERE sc.modifiedon > 'YYYY-MM-DD'
 
