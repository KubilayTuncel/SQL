do $$
declare
	selected_film film%rowtype;
	input_film_id film.id%type :=3;
begin
	select * from film into selected_film where id = input_film_id;
	
	if not found then
		raise notice 'Girmis oldugunuz id li film bulunamadi : %', input_film_id;
	else 
		raise notice 'Film ismi : %', selected_film.title;
	end if;
end $$;

/*
Task : 1 id li film varsa ;
			süresi 50 dakikanın altında ise Short,
			50<length<120 ise Medium,
			length>120 ise Long yazalım
			*/

do $$
declare
	selected_film film%rowtype;
	input_film_id film.id%type :=1;
	len_description varchar(50);
begin
	select * from film into selected_film where id = input_film_id;
	
	if not found then
		raise notice 'Film bulunamadi';
	else 
		if selected_film.length>0 and selected_film.length <= 50 then
				len_description='Kisa';
			elseif selected_film.length>50 and selected_film.length<=120 then
				len_description='Orta';
			elseif selected_film.length>120 then
				len_description='Uzun';
			else 
				len_description='Tanimlanamiyor';
		end if;
		
	raise notice ' % filminin süresi : %  ', selected_film.title, len_description;
	end if;

end $$;

-- Task : Filmin türüne göre çocuklara uygun olup olmadığını ekrana yazalım

do $$
declare
	tur film.type%type;
	uyari varchar(50);

begin
	select type into tur from film where id = 1;
	
	if found then
		case tur
			when 'Korku' then
				uyari='cocuklar icin uygun degil';
			when 'Macera' then
				uyari='cocuklar icin uygun';
			when 'Animasyon' then
				uyari='cocuklar icin tavsiye edilir';
			else 
				uyari='Tanimlanamadi';
			end case;
			raise notice '%', uyari;
	end if;

end $$;

-- loop u sonlandırmak için loopun içine if yapısını kullanabiliriz
<<label>>
loop
   statements;
   if condition then
      exit;
   end if;
end loop;

-- nested loop 

<<outer>>
loop 
   statements;
   <<inner>>
   loop
     /* ... */
     exit <<inner>>
   end loop;
end loop;


do $$
declare
	n integer :=11;
	counter integer :=0;
	i integer :=0;
	j integer :=1;
	fib integer :=0;
	
begin
	if(n<1) then
		fib:=0;
	end if;
	loop 
		exit when counter = n;
		counter := counter + 1;
		select j, i+j into i,j;
		fib :=i;
	raise notice '%',fib;
	end loop;	

end$$


[ <<label>> ]
while condition loop
   statements;
end loop;

-- Task : 0 dan 4 e kadar counter değerlerini ekrana basalım

do $$
declare
	n integer:=4;
	counter integer :=0;
begin
	while counter<n loop
		counter:=counter+1;
		
	raise notice '%',counter;
	end loop;
end $$;

--2.cevap
do $$
declare 
   counter integer := 0;
begin
   while counter < 5 loop
      raise notice 'Counter %', counter;
      counter := counter + 1;
   end loop;
end$$;

-- **************  FOR LOOP *********************

-- syntax :

[ <<label>> ]
for loop_counter in [ reverse ] from.. to [ by step ] loop
    statements
end loop [ label ];

--Örnek (in)
do $$
begin
	for counter in 1..5 loop 
		raise notice 'counter : %',counter;
	end loop;

end $$;

--Örnek (reverse)
do $$
begin
	for counter in reverse 5..1 loop
		raise notice 'counter : %',counter;
	end loop;

end $$;

--Örnek by step
do $$
begin
	for counter in reverse 9..1 by 2 loop
		raise notice 'counter : %',counter;
	end loop;
end $$;

-- Örnek : DB de loop kullanımı

-- syntax :
[ <<label>> ]
for target in query loop
    statements
end loop [ label ];

-- Task : Filmleri süresine göre sıraladığımızda en uzun 2 filmi gösterelim

do $$
declare
	v_film film%rowtype;
begin
	for v_film in (select * from film order by length desc limit 2) loop
		raise notice '% Filminin süresi %',v_film.title, v_film.length;
	end loop;
end $$;

-- ******************EXIT***************
exit when counter > 10

if counter>10 then
	exit;
end if;

--ikiside ayni isi yapiyor üst taraftaki daha kullanisli

-- Örnek

do $$
begin
	<<inner_block>>
	begin
		exit inner_block;
		raise notice 'Inner block tan Merhaba';
	end ;
	raise notice 'outer block dan Merhaba';
end $$;

-- ***********Continue************
-- mevcut iterasyonu atlamak için kullanılır
-- Syntax :
continue [loop_label] [when condition] -- [] bu kısımlar opsiyoneldir

--Örnek

do $$
declare
	counter integer :=0;
begin
	loop 
		counter :=counter+1;
		exit when counter > 10;
		continue when mod(counter,2)=0;
		raise notice 'counter : %',counter;
	end loop;

end $$;





	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	