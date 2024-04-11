--For example you have some flow with link:
--https://make.powerautomate.com/environments/ENV_GUID/solutions/SOLUTION_GUID/flows/FLOW_GUID/details?utm_source=solution_explorer
--but how can you find this flow in the Dataverse db?
--This is the answer:

SELECT DISTINCT workflowid, w.categoryname, name, w.resourceid
  FROM workflow w
 WHERE categoryname = 'Modern Flow'
   AND type = 1
   AND statecode = 1
   AND w.resourceid = 'FLOW_GUID' -- you can also change this filter to "AND w.resourceid IS NOT NULL" for getting of all your PA flows
