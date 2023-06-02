--1 
CREATE TABLE Sinh viên (
    MSSV INT PRIMARY KEY,
    Họtên VARCHAR(255),
    Ngày_sinh DATE,
    Quê_quán VARCHAR(255)
);

CREATE TABLE Môn_học (
    MSMH INT PRIMARY KEY,
    TênMH VARCHAR(255),
    TênGV VARCHAR(255)
);

CREATE TABLE Đăngký (
    MSMH INT,
    MSSV INT,
    Điểm FLOAT CHECK (Điểm >= 0 AND Điểm <= 10),
    FOREIGN KEY (MSMH) REFERENCES Môn_học(MSMH),
    FOREIGN KEY (MSSV) REFERENCES Sinh viên(MSSV),
    PRIMARY KEY (MSMH, MSSV)
);
------------------------------------
--2

--a 
SELECT TênMH
FROM Môn_học

--b
SELECT MSSV, Họtên, Ngày_sinh
FROM Sinh viên
WHERE Quê_quán = 'Hà Nội'

--c
SELECT MSSV
FROM Đăngký
WHERE MSMH IN ('M1', 'M2')

--d
SELECT TênMH
FROM Môn_học
WHERE MSMH IN (
    SELECT MSMH
    FROM Đăngký
    WHERE MSSV = 20042325
)

--e
SELECT DISTINCT S.Họtên
FROM Sinh viên S
INNER JOIN Đăngký D ON S.MSSV = D.MSSV
INNER JOIN Môn_học M ON D.MSMH = M.MSMH
WHERE M.TênGV = 'Lê Quân'

--f
SELECT M.TênMH, D.Điểm
FROM Sinh viên S
INNER JOIN Đăngký D ON S.MSSV = D.MSSV
INNER JOIN Môn_học M ON D.MSMH = M.MSMH
WHERE S.Họtên = 'Nguyễn Văn A'

--g
SELECT S.MSSV
FROM Sinh viên S
INNER JOIN Đăngký D ON S.MSSV = D.MSSV
INNER JOIN Môn_học M ON D.MSMH = M.MSMH
WHERE NOT EXISTS (
    SELECT MSMH
    FROM Môn_học
    WHERE TênGV = 'Lê Quân'
    EXCEPT
    SELECT MSMH
    FROM Đăngký
    WHERE MSSV = S.MSSV
)

--h
SELECT TênMH
FROM Môn_học
WHERE MSMH NOT IN (
    SELECT DISTINCT MSMH
    FROM Đăngký
)

--i
SELECT MSSV
FROM Đăngký
GROUP BY MSSV
HAVING COUNT(DISTINCT MSMH) >= 5

--j
SELECT AVG(Điểm)
FROM Đăngký
WHERE MSSV = (
    SELECT MSSV
    FROM Sinh viên
    WHERE Họtên = 'Nguyễn Văn A'
)

--k
SELECT S.Họtên
FROM Sinh viên S
INNER JOIN Đăngký D ON S.MSSV = D.MSSV
INNER JOIN Môn_học M ON D.MSMH = M.MSMH
WHERE M.TênMH = 'CSDL'
ORDER BY D.Điểm DESC
LIMIT 1
