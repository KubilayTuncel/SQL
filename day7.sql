CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

--Müsteri_ürün tablosundan urun isimlerini tekrarsiz(grup olarak) yaziniz.
select distinct urun_isim from musteri_urun;

--kac cesit meyve vadir

select count (distinct urun_isim) from musteri_urun;

-- Musteri urun tablosundan ilk 3 kaydi listeleyiniz.
select * from musteri_urun order by urun_id fetch next 3 row only;

--LIMIT
select * from musteri_urun order by urun_id limit 3;

--Musteri urun tablosundan son üc kaydi listeleyiniz.

select * from musteri_urun order by urun_id desc limit 3;

CREATE TABLE maas
(
id int,
musteri_isim varchar(50),
maas int
);
INSERT INTO maas VALUES (10, 'Ali', 5000);
INSERT INTO maas VALUES (10, 'Ali', 7500);
INSERT INTO maas VALUES (20, 'Veli', 10000);
INSERT INTO maas VALUES (30, 'Ayse', 9000);
INSERT INTO maas VALUES (20, 'Ali', 6500);
INSERT INTO maas VALUES (10, 'Adem', 8000);
INSERT INTO maas VALUES (40, 'Veli', 8500);
INSERT INTO maas VALUES (20, 'Elif', 5500);

--En yüksek 2. maasi bulunuz.

select * from maas order by maas desc offset 1 limit(1)
--satir atlamaj istedigimizde offset komutunu kullaniriz.

--Maas tablosundan 4. satirdan sonrasini aliniz

select * from maas order by maas desc offset 3 limit(4);

/*
					ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */
 
 CREATE TABLE personel4  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel4 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel4 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel4 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel4 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel4 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel4 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel4 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel4

--1) add default deger ile tabloya bir field ekleme

alter table personel4 add ulke varchar(30) default 'Türkiye'

alter table personel4 add  adres varchar(50) default 'null'

alter table personel4 drop column adres

alter table personel4 rename column ulke to ulke_ismi

--rename ile tablo ismi de degisebilir
alter table personel4 rename to isci1

select * from isci1

--5) type/set sütunlarının özelliklerini değiştirme
alter table isci1 alter column sehir type varchar (30),
alter column maas set not null;

/*
Eger numeric data tipine sahip bir sutunun data turune string bir data turu atamak istersek
TYPE varchar(30) USING(maas::varchar(30)) bu formati kullaniriz
*/

alter table isci1
ALTER COLUMN maas
TYPE varchar(30) USING(maas::varchar(30))

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);

/*
	-->	TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT)
	Transaction baslatmak icin BEGIN komutu kullanmamiz gerekir ve Transaction'i sonlandirmak icin
	COMMIT komutunu calistirmaliyiz.
*/
-- Serial data turu otomatik olarak birden baslayarak sirali olarak sayi atamasi yapar
		   -- INSERT INTO ile tabloya veri eklerken serial data turunu
		   --kullandigim veri degeri yerine DEFAULT yazariz
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;