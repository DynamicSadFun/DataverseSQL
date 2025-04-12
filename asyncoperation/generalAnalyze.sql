--In the event of an overflow of Capacity and 
--in particular, your AsyncOperation table, 
--this query will show a preliminary result 
--for which data can be painlessly deleted from the system

SELECT operationtypename, statecodename, COUNT(AsyncOperationId)
  FROM AsyncOperation
    --1	    System Event
    --9	    Collect SQM data
    --10    Workflow Operation
    --12	Update Match Code
    --25	Generate Full Text Catalog
    --27	Update Contract States
 WHERE OperationType IN (1, 9, 10, 12, 25, 27) 
   AND StateCode = 3 -- Completed
   AND StatusCode IN (30, 32)   -- Succeeded and Canceled 
 GROUP BY operationtypename, statecodename
