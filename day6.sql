CREATE TABLE siparisler  (
siparis_id int,  
sirket_id int,  
siparis_tarihi date
);

INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
INSERT INTO siparisler VALUES(22, 102, ' 2020-04-18');
INSERT INTO siparisler VALUES(33, 103, ' 2020-04-19');
INSERT INTO siparisler VALUES(44, 104, ' 2020-04-20');
INSERT INTO siparisler VALUES(55,  105, ' 2020-04-21');

CREATE TABLE sirketler 
(
sirket_id int, 
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota'); 
INSERT INTO sirketler VALUES(101, 'Honda'); 
INSERT INTO sirketler VALUES(102, 'Ford'); 
INSERT INTO sirketler VALUES(103, 'Hyundai');

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi 
from sirketler inner join siparisler
on sirketler.sirket_id=siparisler.sirket_id

/*
2 Tablodaki datalari Birlestirmek icin kullanilir.
Su ana kadar gordugumuz Union,Intersect ve Minus sorgu sonuclari icin kullanilir
Tablolar icin ise JOIN kullanilir
5 Cesit Join vardir
1) INNER JOIN iki Tablodaki ortak datalari gosterir
2) LEFT JOIN Ilk datada olan tum recordlari gosterir
3) RIGHT JOIN Ikinci tabloda olan tum recordlari gosterir
4) FULL JOIN Iki tablodaki tum recordlari gosterir
5) SELF JOIN Bir tablonun kendi icinde Join edilmesi ile olusur
*/

/*
    NOT :
    1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken 
	Tablo_adi.field_adi seklinde yazin
    2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
    3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
    
    1) Left Join’de ilk tablodaki tum record’lar gosterilir.
    2) Ilk tablodaki datalara 2.tablodan gelen ek datalar varsa bu ek datalar 
	ortak datalar icin gosterilir ancak
ortak olmayan datalar icin o kisimlar bos kalir
    3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu istedigimize
	karar verip once onu yazmaliyiz
 */
 
 -- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirketler INNER JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;
-- LEFT JOIN
-- Iki Tabloda sirket_id'si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;
-- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve siparis_tarihleri ile yeni bir tablo olusturun
/*
    NOT :
    1)Right Join’de ikinci tablodaki tum record’lar gosterilir.
    2)Ikinci tablodaki datalara 1.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir
    ancak ortak olmayan datalar icin o kisimlar bos kalir
*/
-- RIGHT JOIN
SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirketler RIGHT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;
-- FULL JOIN
SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirketler FULL JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

	
CREATE TABLE personel2 
(
id int,
isim varchar(20), 
title varchar(60), 
yonetici_id int
);
INSERT INTO personel2 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel2 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel2 VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel2 VALUES(4, 'Fatma Can', 'CEO', 5);

-- Her personelin yanina yonetici ismini yazdiran bir tablo olusturun

SELECT p1.isim AS personel_ismi, p2.isim AS yonetici_ismi
FROM personel2 p1 INNER JOIN personel2 p2
ON p1.yonetici_id = p2.id;


-- 								LIKE Condition
/*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
*/

CREATE TABLE musteriler1  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1001, 'Ali', 62000);
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1002, 'Ayse', 57500);
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1004, 'Fatma', 42000);
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
insert into musteriler1 (id, isim, gelir) values (1006, 'ahmet', 66000);

-- 1) % => 0 veya birden fazla karakter belirtir
-- SORU : Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin

select * from musteriler1
where isim like 'A%';

select * from musteriler1
where isim ilike 'A%'

--ilike taki i ignore manasinda kullaniliyor. bu cok önemli. 
--ayrica LIKE yerine ~~ sembollerini kullanabiliriz.
--ignore icin kullandigimiz i yerine de * kullanilabilir.
/*
LIKE: Sorgulama yaparken belirli patternleri(KAlıp ifadelerle sorgu) kullanabilmezi sağlar 
ILIKE: Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir.
LIKE = ~~ 
ILIKE = ~~* 
NOT LIKE = !~~ 
NOT ILIKE = !~~* 
NOT REGEXP_LIKE = !~* 
NOT REGEXP_LIKE = !~
*/
--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler WHERE isim ~~ '%e'
--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler WHERE isim like '%er%'
--Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim ~~ '_atma'
--Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim like '_a%'
--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim ~~ '__s%'
-- REGEXP_LIKE (~) KULLANIMI
CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3);  
INSERT INTO kelimeler VALUES (1005, 'adem', 4);  
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hAt', 5); 
-- SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan
--3 harfli kelimelerin tum bilgilerini  yazdiran
-- QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* 'h[ai]t'
-- SORU : Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan
--3 harfli kelimelerin  tum bilgilerini  yazdiran 
-- QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* 'h[a-k]t'
-- SORU : a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* '^[as]'
-- SORU : m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* '[mf]$'
-- UPPER – LOWER - INITCAP
-- Kelimeler tablosundaki kelime sutunundaki verileri önce hepsi büyük harf, 
--sonra küçük harf ve ilk harfleri 
-- büyük harf olucak şekilde yazdıralım
SELECT UPPER(kelime) as büyükkelime FROM kelimeler
SELECT LOWER(kelime) as kelime FROM kelimeler
SELECT INITCAP(kelime) as kelime FROM kelimeler 
-- INITCAP istediğimiz sutundaki verilerin ilk harfini büyük yazar
-- Musteriler tablosundan bütün isimleri büyük harf yapınız
SELECT UPPER(isim) FROM musteriler1
/*
Eğer birden fazla sütundaki verileri büyük küçük harf yapmak istersek
select lower(title),UPPER(isim) from personel şekilde yapabiliriz
*/
select lower(title),UPPER(isim) from personel2