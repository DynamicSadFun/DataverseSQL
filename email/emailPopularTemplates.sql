--Determine which email templates are most used in sent emails.

SELECT et.templateid, et.title, COUNT(e.activityid) AS TimesUsed
  FROM email e
  JOIN template et
    ON e.templateid = et.templateid
 GROUP BY et.templateid, et.title
 ORDER BY TimesUsed DESC;
