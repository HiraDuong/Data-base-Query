--a
SELECT TênDA
FROM Dự án
WHERE Ngân_sách BETWEEN 50000 AND 100000

--b
SELECT Họtên
FROM Nhânviên
INNER JOIN Thamgia ON Nhânviên.MãNV = Thamgia.MãNV
INNER JOIN Dự án ON Thamgia.MãDA = Dự án.MãDA
WHERE Dự án.TênDA = 'Quản lý đào tạo'

--c
SELECT MãNV
FROM Thamgia
WHERE MãDA IN (
    SELECT MãDA
    FROM Dự án
    WHERE TênDA IN ('Quản lý đào tạo', 'Đào tạo từ xa')
    GROUP BY MãDA
    HAVING COUNT(DISTINCT MãNV) = 2
)

--d
SELECT MãNV
FROM Thamgia
WHERE MãDA = (
    SELECT MãDA
    FROM Dự án
    WHERE TênDA = 'Quản lý đào tạo'
)
AND MãNV NOT IN (
    SELECT MãNV
    FROM Thamgia
    WHERE MãDA = (
        SELECT MãDA
        FROM Dự án
        WHERE TênDA = 'Đào tạo từ xa'
    )
)

--e
SELECT MãP
FROM Phòng
WHERE MãP NOT IN (
    SELECT DISTINCT MãP
    FROM Nhânviên
    INNER JOIN Thamgia ON Nhânviên.MãNV = Thamgia.MãNV
)

--f
SELECT TênDA
FROM Dự án
WHERE MãDA IN (
    SELECT MãDA
    FROM Thamgia
    WHERE MãNV IN (
        SELECT MãNV
        FROM Nhânviên
        WHERE MãP = (
            SELECT MãP
            FROM Phòng
            WHERE TênP = 'NCKH'
        )
    )
    GROUP BY MãDA
    HAVING COUNT(DISTINCT MãNV) = (
        SELECT COUNT(*)
        FROM Nhânviên
        WHERE MãP = (
            SELECT MãP
            FROM Phòng
            WHERE TênP = 'NCKH'
        )
    )
)

--g
SELECT AVG(Dự án.Ngân_sách)
FROM Dự án
INNER JOIN Thamgia ON Dự án.MãDA = Thamgia.MãDA
WHERE Thamgia.MãNV = 'NV001'

--h
SELECT COUNT(DISTINCT MãNV)
FROM Thamgia
WHERE MãDA = (
    SELECT MãDA
    FROM Dự án
    WHERE TênDA = 'Quản lý đào tạo'
)

--i
SELECT TênDA
FROM Dự án
INNER JOIN Thamgia ON Dự án.MãDA = Thamgia.MãDA
GROUP BY Dự án.MãDA, TênDA
HAVING COUNT(DISTINCT Thamgia.MãNV) < 10

--j
SELECT TênDA
FROM Dự án
INNER JOIN Thamgia ON Dự án.MãDA = Thamgia.MãDA
GROUP BY Dự án.MãDA, TênDA
HAVING COUNT(DISTINCT Thamgia.MãNV) = (
    SELECT MAX(ThamgiaCount)
    FROM (
        SELECT COUNT(DISTINCT MãNV) AS ThamgiaCount
        FROM Thamgia
        GROUP BY MãDA
    ) AS Counts
)
