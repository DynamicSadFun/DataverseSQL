--This query extracts information from the metadata and allows us to see which entities and fields we have created by the system (OOB) and which we have created (custom)

SELECT DISTINCT 
       e.displayname AS [Entity Name], 
       IIF(e.iscustomentity = 0, 'OOB', 'Custom') AS [Is It Custom Entity?], 
       a.displayname AS [Field Name], 
       IIF(a.iscustomattribute = 0, 'OOB', 'Custom') AS [Is It Custom Field?]
  FROM metadata.attribute a
  JOIN metadata.entity e
    ON a.entitylogicalname = e.logicalname
 WHERE e.displayname IS NOT NULL
   AND a.isauditenabled = 1  -- You can remove this filter if you don't need it, but it is useful to understand, among other things, whether the field value is written to the audit
   AND e.isauditenabled = 1  -- You can remove this filter if you don't need it, but it is useful to understand, among other things, whether the entity value is written to the audit
   AND a.displayname IS NOT NULL
 ORDER BY 1, 3
 
