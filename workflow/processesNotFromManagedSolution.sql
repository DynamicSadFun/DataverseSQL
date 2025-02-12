--With this query, we retrieve all processes in our system 
--that are contained in Unmanaged solutions (including Default/Active) 
--and are not contained in any Managed solution. 
--Also, these processes usually have Managed = 0 to indicate that they were created manually. 

SELECT DISTINCT w.name              AS FlowName
                ,w.categoryname     AS ProcessType
                ,w.statecodename    AS Status
                ,w.owneridname      AS Owner
                ,w.createdon        AS CreatedOn
                ,w.createdbyname    AS CreatedBy
                ,w.modifiedon       AS ModifiedOn
                ,w.modifiedbyname   AS ModifiedBy
                ,s.friendlyname     AS SolutionName
  FROM workflow w WITH(NOLOCK)
  JOIN solutioncomponent sc WITH(NOLOCK)
    ON sc.objectid = w.workflowid
  JOIN solution s WITH(NOLOCK) 
    ON sc.solutionid = s.solutionid
   AND s.isvisible = 1   
   AND s.friendlyname IS NOT NULL
   AND s.ismanaged = 0
 WHERE w.ismanaged = 0 
   AND w.workflowid NOT IN -- here we needa exclude managed solutions and managed components
   (SELECT manComp.objectid
      FROM solutioncomponent manComp
      JOIN solution manSol
        ON manSol.solutionid = manComp.solutionid
     WHERE manSol.ismanaged = 1
       AND manSol.isvisible = 1)
 
