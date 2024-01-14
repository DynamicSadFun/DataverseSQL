--Summarize Opportunity Value by Stage and Owner
--This provides a summary of the total estimated value of opportunities, grouped by their stage in the sales process and owner.

SELECT DISTINCT 
       o.ownerid, 
       s.name AS StageName, 
       SUM(o.estimatedvalue) AS TotalValue
  FROM opportunity o
  JOIN processstage s 
    ON o.stageid = s.processstageid
 GROUP BY o.ownerid, s.name;
