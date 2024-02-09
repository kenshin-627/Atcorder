-- SQL request(s)​​​​​​‌​‌​​‌​​​​‌​​​‌‌​​​‌​​‌​‌ below
-- SELECT * FROM schedule
SELECT s1.studentId, s1.name, s1.avgGrade
FROM student s1
JOIN studentsChatsMap scm ON s1.studentId = scm.studentId
JOIN onlineChat oc ON scm.chatId = oc.chatId
JOIN roomAccessHistory rah ON s1.studentId = rah.studentId
JOIN room r ON rah.roomId = r.roomId
WHERE
    oc.createdAt >= '3961-03-05 15:00:00'
    AND scm.chatId IN (
        SELECT chatId
        FROM studentsChatsMap
        GROUP BY chatId
        HAVING COUNT(*) = 7
    )
GROUP BY s1.studentId, s1.name, s1.avgGrade
-- HAVING
--     AVG(rah.exitedAt - rah.enteredAt) >= (
--         SELECT AVG(rah2.exitedAt - rah2.enteredAt)
--         FROM roomAccessHistory rah2
--         WHERE rah2.roomId = r.roomId
--     )
    AND SUM(
        CASE
            WHEN (
                SELECT COUNT(*)
                FROM schedule sc
                WHERE sc.classId = s1.classId AND sc.day = 'Monday' AND sc.hour = 15
            ) >= 3 THEN 1
            ELSE 0
        END
    ) < 3
    -- AND (
    --     SELECT PERCENT_RANK() WITHIN GROUP (ORDER BY s2.height DESC)
    --     FROM student s2
    --     WHERE s2.studentId = s1.studentId
    -- ) <= 0.25
    -- AND (
    --     s1.name LIKE '%M%' OR s1.name LIKE '%W%'
    -- )
    -- AND (
    --     SELECT COUNT(*)
    --     FROM student s3
    --     WHERE s3.classId = s1.classId AND s3.bedroomId = s1.bedroomId
    -- ) >= 3
