--Extract and count unique domains from email addresses in the contact entity.
SELECT SUBSTRING(emailaddress1, CHARINDEX('@', emailaddress1) + 1, LEN(emailaddress1)) AS Domain,
       COUNT(*) AS DomainCount
  FROM Contact
 WHERE emailaddress1 IS NOT NULL
 GROUP BY SUBSTRING(emailaddress1, CHARINDEX('@', emailaddress1) + 1, LEN(emailaddress1)) 
 ORDER BY DomainCount DESC
