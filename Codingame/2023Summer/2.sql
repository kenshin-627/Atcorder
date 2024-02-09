SELECT A.name AS NAME, COUNT(M.recruiterId) AS SCORE
FROM mutant M
JOIN agent A ON M.recruiterId = A.agentId
GROUP BY M.recruiterId, A.name
ORDER BY SCORE DESC
LIMIT 10;
