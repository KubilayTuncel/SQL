CREATE TABLE ogrenciler5
(
ogrenci_no char(7),-- Uzunluğunu bildiğimiz stringler için CHAR kullanılır
isim varchar(20), -- Uzunluğunu bilmediğimiz stringler için VARCHAR kullanırız
soyisim varchar(25),
not_ort real,-- Ondalıklı sayılar için kullanılır(Double gibi)
kayit_tarih date);
-- VAROLAN BİR TABLODAN YENİ BİR TABLO OLUŞTURMA
CREATE TABLE NOTLAR
AS
SELECT isim,not_ort FROM ogrenciler5;
select * from notlar;
--INSERT- TABLO İÇİNE VERİ EKLEME
INSERT INTO notlar VALUES ('Osman',95.5);
INSERT INTO notlar VALUES ('Sumeyye',95.5);
INSERT INTO notlar VALUES ('Salih',95.5);
INSERT INTO notlar VALUES ('Hakan',95.5);
INSERT INTO notlar VALUES ('Adem',95.5);
select * from notlar;

--Constraint
--Unique

create table talebeler
(
talebe_no char(7) unique,
talebe_isim varchar(20) not null,
soyisim varchar(25),
not_ort real,
kayit_tarih date);

select * from talebeler;

insert into talebeler values ('1234567', 'Erol','Evren',75.5,now());
insert into talebeler values ('1234568', 'Ahmet','Keten',75.5,now());
insert into talebeler (talebe_no,soyisim,not_ort) values ('1234569','Akin',85.5) --Not Null kisitlamasi oldugu icin bu veri eklenemez
-- PRIMARY KEY atamasi : bu islem farkli tablolari yani table lari birbirine baglamak icin kullanilir
CREATE TABLE ogrenciler8
(
ogrenci_no char(7) PRIMARY KEY, 
isim varchar(20) , 
soyisim varchar(25),
not_ort real,
kayit_tarih date 
);

--primary key i atamanin 2. yolu
CREATE TABLE ogrenciler9
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarih date,
CONSTRAINT ogr PRIMARY KEY(ogrenci_no)
	
);

--Foreign key promary key ile baglamak istedigimiz child klas i baglamada kullanilir

create table devoloperlar1
(
devoloper_id char(8) Primary key,
devolaper_ismi varchar(20),
iletisim_bilgileri varchar(25)
);

create table testerlar1 
(
tester_id char(8),
bugticket_id char(8),
foreign key (tester_id) references devoloperlar1(devoloper_id)
);

create table calisanlar1 
( calisanlar_id char(6) primary key,
 isim varchar(20) unique,
 maas int not null,
 ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10006', 'Canan Yaş', 5000, '2019-04-12');
INSERT INTO calisanlar1 VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('', 'osman', 2000, '2018-04-14');

create table adresler1 
(adres_id char(6),
 sokak varchar(100),
 cadde varchar (20),
 sehir varchar(20),
 foreign key (adres_id) references calisanlar1(calisanlar_id)
);

INSERT INTO adresler1 VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler1 VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler1 VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler1 VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- FK'ye null değeri atanabilir.
INSERT INTO adresler1 VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler1 VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

select * from calisanlar1;
select * from adresler1;

--calisanlar tablosundan maasi 5000 den buyuk olan isimleri listeleyiniz

select isim from calisanlar1 where maas > 5000;

--ismi velihan olan kisinin tüm verilerini listeleyin

select * from calisanlar1 where (isim='Veli Han');


CREATE TABLE ogrenciler6
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler6 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler6 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler6 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler6 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Ali', 99);

delete from ogrenciler6 where isim='Nesibe Yilmaz' or isim='Mustafa Bak';

select * from ogrenciler6;

