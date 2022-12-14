
Create or replace function toplamaF (x numeric, y numeric)
returns numeric
language plpgsql
as
$$
Begin
return x+y;
end
$$

select * from toplamaF(4,6);

Create or replace function konininHacmi (r numeric, h numeric)
returns numeric
language plpgsql
as
$$
Begin
return 3.14*r*r*h/3;
end
$$