--This simple query through the dependency table gives us the result in the form of two fields. 
--The first field is a flow that calls flows from field 2 as part of its actions, forming a parent-child relationship. 
SELECT DISTINCT w1.name AS ParentFlow,
                w2.name AS ChildFlow
  FROM dependency AS dep
  JOIN workflow AS w1
    ON dep.dependentcomponentobjectid = w1.workflowid
  JOIN workflow AS w2
    ON dep.requiredcomponentobjectid = w2.workflowid
 WHERE w1.categoryname = 'Modern Flow' -- only PA flows
   AND w2.categoryname = 'Modern Flow' -- only PA flows
   AND w1.statecode = 1 -- only active
   AND w2.statecode = 1 -- only active
