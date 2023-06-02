--a
SELECT DISTINCT NCC.TênNCC
FROM NCC
INNER JOIN Cungcấp ON NCC.MSNCC = Cungcấp.MSNCC
INNER JOIN Mặthàng ON Cungcấp.MSMH = Mặthàng.MSMH
WHERE Mặthàng.Màusắc = 'đỏ'

--b
SELECT DISTINCT NCC.MSNCC
FROM NCC
INNER JOIN Cungcấp ON NCC.MSNCC = Cungcấp.MSNCC
INNER JOIN Mặthàng ON Cungcấp.MSMH = Mặthàng.MSMH
WHERE Mặthàng.Màusắc IN ('đỏ', 'xanh')

--c
SELECT NCC.MSNCC
FROM NCC
INNER JOIN Cungcấp ON NCC.MSNCC = Cungcấp.MSNCC
INNER JOIN Mặthàng ON Cungcấp.MSMH = Mặthàng.MSMH
WHERE Mặthàng.Màusắc IN ('đỏ', 'xanh')
GROUP BY NCC.MSNCC
HAVING COUNT(DISTINCT Mặthàng.MSMH) = 2

--d
SELECT Cungcấp.MSNCC
FROM Cungcấp
INNER JOIN Mặthàng ON Cungcấp.MSMH = Mặthàng.MSMH
WHERE Mặthàng.Màusắc = 'đỏ'
GROUP BY Cungcấp.MSNCC
HAVING COUNT(DISTINCT Mặthàng.MSMH) = (SELECT COUNT(*) FROM Mặthàng WHERE Màusắc = 'đỏ')

--e
SELECT Cungcấp.MSNCC
FROM Cungcấp
INNER JOIN Mặthàng ON Cungcấp.MSMH = Mặthàng.MSMH
WHERE Mặthàng.Màusắc IN ('đỏ', 'xanh')
GROUP BY Cungcấp.MSNCC
HAVING COUNT(DISTINCT Mặthàng.MSMH) = (SELECT COUNT(*) FROM Mặthàng WHERE Màusắc IN ('đỏ', 'xanh'))

--f
SELECT Cungcấp.MSNCC
FROM Cungcấp
INNER JOIN Mặthàng ON Cungcấp.MSMH = Mặthàng.MSMH
GROUP BY Cungcấp.MSNCC
HAVING COUNT(DISTINCT CASE WHEN Mặthàng.Màusắc = 'đỏ' THEN Mặthàng.MSMH END) = (SELECT COUNT(*) FROM Mặthàng WHERE Màusắc = 'đỏ')
OR COUNT(DISTINCT CASE WHEN Mặthàng.Màusắc = 'xanh' THEN Mặthàng.MSMH END) = (SELECT COUNT(*) FROM Mặthàng WHERE Màusắc = 'xanh')
--g
SELECT A.MSNCC AS Hãng1, B.MSNCC AS Hãng2
FROM Cungcấp AS A
INNER JOIN Cungcấp AS B ON A.MSMH = B.MSMH AND A.MSNCC <> B.MSNCC
WHERE A.Giátiền > B.Giátiền

--h
SELECT Cungcấp.MSMH
FROM Cungcấp
GROUP BY Cungcấp.MSMH
HAVING COUNT(DISTINCT Cungcấp.MSNCC) >= 2

--i
SELECT Cungcấp.MSMH
FROM Cungcấp
INNER JOIN NCC ON Cungcấp.MSNCC = NCC.MSNCC
WHERE NCC.TênNCC = 'Dustin'
ORDER BY Cungcấp.Giátiền DESC
LIMIT 1

--j
SELECT Cungcấp.MSMH
FROM Cungcấp
GROUP BY Cungcấp.MSMH
HAVING MAX(Cungcấp.Giátiền) < 200

