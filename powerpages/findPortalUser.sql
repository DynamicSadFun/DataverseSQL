-- select Portal user from system users
-- we need to check the exact applicationiduri - it should contain API://GUID information about your tenant and azure id
SELECT DISTINCT 
       systemuserid,
       fullname,
       domainname,
       applicationid,
       applicationiduri, *
  FROM systemuser
 WHERE applicationid IS NOT NULL
   AND applicationiduri LIKE 'api%'
   AND isdisabled = 0
   AND emailrouteraccessapproval = 0
 ORDER BY fullname;
