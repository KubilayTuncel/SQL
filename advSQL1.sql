-- aciklama
/* 
burada aciklama yapabiliyoruz.
*/
-- ******* Degisken Tanimlama ***********
do $$ -- anonymous blok, dolar isaretini özel karakterler öncesinde '' isaretlerini kullanmamak icin
declare
	counter integer := 1; --counter isminde degisken olusturuldu ve default degeri verildi.
	first_name varchar(50) :='Ahmet';
	last_name varchar(50)  :='Gök';
	payment numeric(4,2) :=20.5; -- 20.50 4,2 yazdigimizda toplam 4 karakter olmali ve 2 ise virgülden sonraki
								 -- kac basamak olmasi gerektigini gösteriyor. ilk kisma ise 1 den 38 kadar deger girilebiliyor
begin
	raise notice '% % % has been paid % USD',
	-- console da göstermek istedigimiz ksimlar icin bu raise notice yaziyoruz
	-- ayrica % isareti degerleri gösteriyor ve asagida bu % lere gelecek degerleri sirayla yaziyoruz.
		counter,
		first_name,
		last_name,
		payment;
end $$ ;

do $$
	declare
	counter integer :=1;
	name1 varchar(50) :='Ahmet';
	name2 varchar(50) :='Mehmet';
	payment numeric(3,0) :=120;
begin
	raise notice '% % ve % Beyler % TL ye bilet aldilar.',
		counter,
		name1,
		name2,
		payment;
end $$ ;
	
-- ************Bekletme Komudu***********

do $$
declare
	create_at time := now();
begin
	raise notice '%', create_at;
	perform pg_sleep(5); -- 5 saniye bekle
	raise notice '%', create_at;
end $$;
	
	
-- *************Tablodan Data Tipini Kopyalama *************
do $$
declare
	film_title film.title%type; -- dinamik olarak film tablosundaki title data türünü dinamik olarak atmis olduk
	featured_title film.title%type;
begin
	-- 1 id li filmin ismini getirelim.
	select title from film into film_title where id=1;
	raise notice 'Film title with id 1 : %', film_title;
end $$;
	
-- *************Row Type ******

do $$
declare
	selected_actor actor%rowtype;
begin
	-- id si 1 olan actoru getir
	select * from actor into selected_actor where id=1;
	
	raise notice 'The actor name is : % %',
		selected_actor.first_name,
		selected_actor.last_name;
end $$;
	
-- ************ Record Type ******** sadece bazi datalari almak istiyorsak bu sistemle yapiyoruz

do $$
declare
	rec record;
begin
	-- filmi seciyoruz
	select id, title, type
	into rec from film where id=2;
	
	raise notice '% % %', rec.id, rec.title, rec.type;
end $$;

-- ************ Ic Ice Blok Yapilari **********

do $$
<<outer_block>>
declare -- outer block
	counter integer :=0;
begin
	counter:=counter+1;
	raise notice 'counter degerim : %',counter;
	
	declare -- inner block
		counter integer :=0;
	begin
		counter :=counter+10;
		raise notice 'ic blokdaki counter degerim : %', counter;
		raise notice 'dis blokdaki counter degerim : %', outer_block.counter;
	end;
	raise notice 'dis blokdaki counter degerim : %', counter;

end $$;

-- ********* Constant ********
-- selling_price := net_price + net_price * vat;

do $$
declare
	vat constant numeric :=0.1; --bu sekilde bu ifade degistirilemez demis oluyoruz.
	net_price numeric :=20.5;
begin
	raise notice 'Satis fiyati : %', net_price*(1+vat);
end $$;

-- constant bir ifadeye RT de deger verebilir miyim ???

do $$
declare
	start_at constant time :=now();
begin
	raise notice 'blogun calisma zamani : %', start_at;
end $$;

-- ************Control Structures******

-- ************ if Statement *********

if condition then
		statement;
end if;

-- Task : 0 id li filmi bulalim eger yoksa ekrana uyari yazisi verelim.

do $$
declare
	selected_film film%rowtype;
	input_film_id film.id%type :=0;
begin
	select * from film into selected_film where id = input_film_id;
	
	if not found then
		raise notice 'Girdiginiz id li film bulunamadi : %',input_film_id;
	end if;
end $$;



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	