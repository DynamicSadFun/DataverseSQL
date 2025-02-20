--Query to get a list of active contacts who have web roles and authentication capabilities in our organization's Power Pages Portal. 

SELECT DISTINCT 
       c.contactid          AS ContactID, 
       c.fullname           AS ContactName, 
       emailaddress1        AS ContactEmail, 
       w.adx_name           AS WebRoleName, 
       w.adx_websiteidname  AS PortalName
  FROM contact c WITH (NOLOCK)
  JOIN adx_webrole_contact wc WITH (NOLOCK)
    ON wc.contactid = c.contactid
  JOIN adx_webrole w WITH(NOLOCK)
    ON w.adx_webroleid = wc.adx_webroleid
   AND w.statecode = 0 
  JOIN adx_externalidentity e WITH (NOLOCK)
    ON c.contactid = e.adx_contactid
   AND e.statecode = 0                          -- Ensure external identity is active
   AND e.adx_externalidentityid IS NOT NULL
 WHERE c.statecode = 0 
   AND c.emailaddress1 IS NOT NULL
   AND c.adx_identity_logonenabled = 1          -- check if the login is enabled for the user
   AND c.adx_identity_username IS NOT NULL      -- check if the user has valid login credentials
   AND c.adx_identity_securitystamp IS NOT NULL -- check if the user has valid login credentials
