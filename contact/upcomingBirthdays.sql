--Identify contacts with upcoming birthdays within the next 30 days.

SELECT DISTINCT contactid, fullname, birthdate
  FROM contact
 WHERE MONTH(birthdate) = MONTH(DATEADD(day, 30, GETDATE()))
   AND DAY(birthdate) BETWEEN DAY(GETDATE()) AND DAY(DATEADD(day, 30, GETDATE()));
