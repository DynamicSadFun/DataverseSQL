/*
This SQL query is used to verify the presence of specific Power Pages Web API endpoints 
in the mspp_sitesetting table. It groups entries by their base API path 
(e.g., Webapi/mserp_vrmpendingvendorinvoicecreateentity) and checks whether each base path 
has the /enabled and /fields settings defined. The result shows a 1 if the setting exists, 
or 0 if it doesn't — helping to quickly validate Web API configuration completeness for Power Pages.
*/
SELECT LEFT(mspp_name, CHARINDEX('/', mspp_name, CHARINDEX('/', mspp_name) + 1) - 1)    AS base_path,
       MAX(IIF(mspp_name LIKE '%enabled', 1, 0))                                        AS enabled,
       MAX(IIF(mspp_name LIKE '%fields', 1, 0))                                         AS fields
  FROM mspp_sitesetting
 WHERE mspp_name LIKE 'Webapi%'
   AND statecode = 0 
   AND (
           mspp_name LIKE '%enabled' 
        OR mspp_name LIKE '%fields' )
GROUP BY LEFT(mspp_name, CHARINDEX('/', mspp_name, CHARINDEX('/', mspp_name) + 1) - 1)
ORDER BY 1
