USE BUDT703_Project_0507_04

--1) What are the total matches played per year?
SELECT YEAR(d.dteMatchDate) AS 'Year of Game', COUNT(r.scrId) AS 'Total matches played each year'
FROM Date d, Record r
WHERE d.dteId = r.dteId
GROUP BY YEAR(d.dteMatchDate)
ORDER BY YEAR(d.dteMatchDate)

--2) What is the total percentage of wins in each year?
WITH CalNum AS (
SELECT YEAR(d.dteMatchDate) AS 'Year of Game' , COUNT(r.scrId) AS 'Total Wins'
FROM Record r, Date d, Score s
WHERE d.dteId = r.dteId AND s.scrOutcome = 'W' AND r.scrId = s.scrId
GROUP BY YEAR(d.dteMatchDate)
),
CalDen AS (
SELECT YEAR(d.dteMatchDate) AS 'Year of Game', COUNT(r.scrId) AS 'Total Matches Played'
FROM Record r, Date d 
WHERE d.dteId = r.dteId
GROUP BY YEAR(d.dteMatchDate)
)
SELECT c1.[Year of Game], ROUND(100*CONVERT(FLOAT ,c1.[Total Wins])/CONVERT(FLOAT, c2.[Total Matches Played]),2) AS 'Win percentage'
FROM CalNum c1, CalDen c2
WHERE c1.[Year of Game] = c2.[Year of Game]
ORDER BY  c1.[Year of Game] 


--3) What is the total percentage of losses in each year? 
WITH CalNum AS (
SELECT YEAR(d.dteMatchDate) AS 'Year of Game' , COUNT(r.scrId) AS 'Total Losses'
FROM Record r, Date d, Score s
WHERE d.dteId = r.dteId AND s.scrOutcome = 'L' AND r.scrId = s.scrId
GROUP BY YEAR(d.dteMatchDate)
),
CalDen AS (
SELECT YEAR(d.dteMatchDate) AS 'Year of Game', COUNT(r.scrId) AS 'Total Matches Played'
FROM Record r, Date d 
WHERE d.dteId = r.dteId
GROUP BY YEAR(d.dteMatchDate)
)
SELECT c1.[Year of Game], ROUND(100*CONVERT(FLOAT ,c1.[Total Losses])/CONVERT(FLOAT, c2.[Total Matches Played]),2) AS 'Loss percentage'
FROM CalNum c1, CalDen c2
WHERE c1.[Year of Game] = c2.[Year of Game]
ORDER BY c1.[Year of Game] 

--4) What are the Top 5 teams that beat UMD the maximum time over the years?
WITH TotalMatches AS (
SELECT o.oppName AS 'Opponent Name', COUNT(r.scrId) AS 'Total Matches Played'
FROM Record r, Opponent o
WHERE o.oppId = r.oppId
GROUP BY o.oppName
),
MatchesLost AS (
SELECT o.oppName AS 'Opponent Name', COUNT(r.scrId) AS 'Total Losses'
FROM Record r, Opponent o, Score s
WHERE o.oppId = r.oppId AND s.scrOutcome = 'L' AND r.scrId = s.scrId
GROUP BY o.oppName
)

SELECT TOP (5) m.[Opponent Name],m.[Total Losses], t.[Total Matches Played] AS 'Total Matches Played' 
FROM TotalMatches t,  MatchesLost m
WHERE m.[Opponent Name]=t.[Opponent Name]
ORDER BY m.[Total Losses] DESC


--5) What are the Top 5 teams that UMD beat the most over the years?
WITH TotalMatches AS (
SELECT o.oppName AS 'Opponent Name', COUNT(r.scrId) AS 'Total Matches Played'
FROM Record r, Opponent o
WHERE o.oppId = r.oppId
GROUP BY o.oppName
),
MatchesWon AS (
SELECT o.oppName AS 'Opponent Name', COUNT(r.scrId) AS 'Total Wins'
FROM Record r, Opponent o, Score s
WHERE o.oppId = r.oppId AND s.scrOutcome = 'W' AND r.scrId = s.scrId
GROUP BY o.oppName
)

SELECT TOP (5) m.[Opponent Name],m.[Total Wins], t.[Total Matches Played] AS 'Total Matches Played' 
FROM TotalMatches t,  MatchesWon m
WHERE m.[Opponent Name]=t.[Opponent Name]
ORDER BY m.[Total Wins] DESC


