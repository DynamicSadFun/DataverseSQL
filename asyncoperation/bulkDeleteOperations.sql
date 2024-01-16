-- Checking how many bulk delete operations in the system we have and general analyze by them

SELECT DISTINCT bd.name, 
                async.createdon, 
                async.completedon, 
                async.executiontimespan, 
                bd.successcount, 
                bd.failurecount
  FROM bulkdeleteoperation bd WITH(NOLOCK)
  JOIN asyncoperation async WITH(NOLOCK)
    ON bd.asyncoperationid = async.asyncoperationid
 WHERE async.operationtype = 13 -- bulk delete processes
   AND bd.name = 'NAME_OF_YOUR_OPERATION' -- you can comment this row if you wanna get all of them
