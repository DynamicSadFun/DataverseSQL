--This query is useful for marketing purposes, helping you identify potential contacts that haven't been targeted in any campaign yet.

SELECT DISTINCT c.contactid, c.fullname, c.emailaddress1 
  FROM contact c 
  LEFT JOIN listmember lm 
    ON c.contactid = lm.entityid 
 WHERE lm.entityid IS NULL 
   AND c.statecode = 0; -- 0 typically stands for active in state code
