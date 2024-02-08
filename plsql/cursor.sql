--------------------------------------------
--Cursor - Record Birlikde istifadesi
--------------------------------------------
declare
 cursor c_personel is
 select ad, soyad, maas from personel
 where unvan = 'UZMAN';
 
 v_per_record c_personel%rowtype;
 
begin
 open c_personel;
 
 loop
 fetch c_personel into v_per_record;
 exit when c_personel%notfound;
 
 dbms_output.put_line(v_per_record.ad ||' '||
 v_per_record.soyad || ': '||
v_per_record.maas);
 end loop;
 
 close c_personel;
end

--------------------------------------------
--For Loop ile cursor istifadesi
--------------------------------------------
--Yöntem-1
declare
 cursor c_product is
 select segment as segment_name, 
 count(*) product_count,
 sum(price) sum_price
 from product p, product_segment ps
 where p.segment_id = ps.id
 group by segment;
 
begin
 for v_product in c_product loop
 
 dbms_output.put_line(
 v_product.segment_name ||': Count: '||
 v_product.product_count || ', Sum Price: '||
 v_product.sum_price);
 end loop;
 
end;





