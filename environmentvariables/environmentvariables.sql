-- List all Environment Variables (Definitions and their active values)
SELECT DISTINCT
    evd.environmentvariabledefinitionid AS DefinitionId,
    evd.schemaname AS SchemaName,
    evd.displayname AS DisplayName,
    evd.defaultvalue AS DefaultValue,
    evv.value AS CurrentValue,
    evd.type AS DataType,
    evd.statecode AS StateCode,
    evv.createdon AS ValueCreatedOn,
    evv.modifiedon AS ValueModifiedOn
FROM 
    environmentvariabledefinition evd
LEFT JOIN 
    environmentvariablevalue evv
    ON evd.environmentvariabledefinitionid = evv.environmentvariabledefinitionid
ORDER BY 
    evd.displayname;
