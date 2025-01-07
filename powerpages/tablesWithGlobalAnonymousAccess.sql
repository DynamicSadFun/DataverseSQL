--This query retrieves tables to which, on the portal side, any anonymous member has access to read the data. 
--First, every table we want to access via WebAPI must have a corresponding configuration in the adx_sitesetting table.
--Second, we have a role called Anonymous Users. This role is assigned to those tables that we want to access anonymously.
--And third, the regulator of this anonymous access is the adx_entitypermission table. 
--It contains the level configuration, in particular the Global attribute and the read property - yes or no for anonymous reading of data on this or that table.

WITH Settings AS (
    SELECT DISTINCT 
           REPLACE(REPLACE(s.adx_name, 'Webapi/', ''), '/enabled', '')  AS entityName, 
           f.adx_value                                                  AS entityFields, 
           s.adx_websiteidname                                          AS sitename
      FROM adx_sitesetting s WITH(NOLOCK)
      JOIN adx_sitesetting f WITH(NOLOCK)
        ON REPLACE(REPLACE(s.adx_name, 'Webapi/', ''), '/enabled', '') = REPLACE(REPLACE(f.adx_name, 'Webapi/', ''), '/fields', '')
       AND s.adx_websiteid = f.adx_websiteid
       AND f.statecode = 0
       AND f.adx_name LIKE 'Webapi%fields'
     WHERE s.adx_name LIKE 'Webapi%enabled'
       AND s.statecode = 0 in
       AND s.adx_value = 'true'
)

SELECT DISTINCT s.entityName, s.entityFields, s.sitename
  FROM adx_entitypermission a WITH(NOLOCK)
  JOIN adx_entitypermission_webrole aw WITH(NOLOCK)
    ON a.adx_entitypermissionid = aw.adx_entitypermissionid
  JOIN adx_webrole w WITH(NOLOCK)
    ON w.adx_webroleid = aw.adx_webroleid
  JOIN Settings s
    ON s.entityName = a.adx_entitylogicalname
   AND s.sitename = w.adx_websiteidname
 WHERE a.adx_scopename = 'Global'
   AND a.adx_read = 1
   AND a.statecode = 0
   AND w.statecode = 0 
   AND w.adx_name = 'Anonymous Users'
