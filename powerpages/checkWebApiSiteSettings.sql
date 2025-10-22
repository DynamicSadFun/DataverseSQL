/*
This SQL query is used to verify the presence of specific Power Pages Web API endpoints 
in the mspp_sitesetting table. It groups entries by their base API path 
(e.g., Webapi/mserp_vrmpendingvendorinvoicecreateentity) and checks whether each base path 
has the /enabled and /fields settings defined. The result shows a 1 if the setting exists, 
or 0 if it doesn't — helping to quickly validate Web API configuration completeness for Power Pages.
*/
SELECT SUBSTRING(
          mspp_name,
          CHARINDEX('/', mspp_name) + 1,
          CHARINDEX('/', mspp_name, CHARINDEX('/', mspp_name) + 1) - CHARINDEX('/', mspp_name) - 1
       )                                                              AS table_name,
       MAX(IIF(mspp_name LIKE '%enabled', 1, 0))                      AS enabled,
       MAX(IIF(mspp_name LIKE '%fields', 1, 0))                       AS fields,
       MAX(IIF(mspp_name LIKE '%disablecacheforvirtualentity', 1, 0)) AS disablecacheforvirtualentity
  FROM mspp_sitesetting -- use 'adx_sitesetting' instead if you have the legacy (standard) data model
 WHERE mspp_name LIKE 'Webapi%' 
   AND statecode = 0
 GROUP BY SUBSTRING(
             mspp_name,
             CHARINDEX('/', mspp_name) + 1,
             CHARINDEX('/', mspp_name, CHARINDEX('/', mspp_name) + 1) - CHARINDEX('/', mspp_name) - 1
          )
 ORDER BY table_name;
