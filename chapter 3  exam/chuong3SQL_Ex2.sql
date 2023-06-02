-- a 
SELECT Họtên, Tuổi
FROM Nhânviên
INNER JOIN Làmviệc ON Nhânviên.MSNV = Làmviệc.MSNV
INNER JOIN Phòng ON Làmviệc.MSP = Phòng.MSP
WHERE Phòng.TênPhòng IN ('Tổ chức', 'Kế hoạch')
-- b 
SELECT MSP, COUNT(MSNV) AS SốNhânViên
FROM Làmviệc
GROUP BY MSP
HAVING COUNT(MSNV) > 20
-- c
SELECT DISTINCT Nhânviên.Họtên
FROM Nhânviên
INNER JOIN Làmviệc ON Nhânviên.MSNV = Làmviệc.MSNV
INNER JOIN Phòng ON Làmviệc.MSP = Phòng.MSP
WHERE Nhânviên.Lương > ALL (SELECT Ngânquỹ FROM Phòng)

--d 
SELECT MSTrưởngphòng
FROM Phòng
GROUP BY MSTrưởngphòng
HAVING MIN(Ngânquỹ) > 1000000
--e
SELECT MAX(Phòng.Ngânquỹ), Nhânviên.Họtên
FROM Phòng
INNER JOIN Nhânviên ON Phòng.MSTrưởngphòng = Nhânviên.MSNV
-- f
SELECT MSTrưởngphòng
FROM Phòng
GROUP BY MSTrưởngphòng
HAVING SUM(Ngânquỹ) > 5000000
