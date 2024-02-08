--IF-ELSIF istifadəsinə nümunə
--------------------------------------------
declare
 maas number := 6000;
begin
 if maas < 5000 then
 dbms_output.put_line('az maaş');
 elsif maas between 5000 and 10000 then
 dbms_output.put_line('Orta Maaş');
 else
 dbms_output.put_line('Çox Maaş');
 end if;
end;

--------------------------------------------
--CASE istifadəsine nümunə
--------------------------------------------

declare
 v_satis_deyeri number;
 v_komissiya number;
begin
 v_satis_deyeri := 150000;
 case
   when v_satis_deyeri > 200000 then
     v_komissiya := 0.2;
   when v_satis_deyeri >= 100000 and v_satis_deyeri < 200000 then
     v_komissiya := 0.15;
   when v_satis_deyeri >= 50000 and v_satis_deyeri < 100000 then
     v_komissiya := 0.1;
   when v_satis_deyeri > 30000 then
     v_komissiya := 0.05;
   else
     v_komissiya := 0;
 end case;
   dbms_output.put_line( 'Komissiya: %' || v_komissiya * 100);
end;

--------------------------------------------
--Basic loopslara nümunə
--------------------------------------------

declare
 v_say pls_integer := 0;
 v_ps_id pls_integer;
 v_ad varchar2(50);
 v_soyad varchar2(40);
 
begin
 loop
   v_say := v_say + 1;
   v_ps_id := dbms_random.value(5000, 5020);
   select ad, soyad into v_ad, v_soyad   from personel where personel_id = v_ps_id;
   dbms_output.put_line(v_ps_id || ': ' || v_ad || ' '|| v_soyad);
   exit when v_say = 10;
 end loop;
end;


--------------------------------------------
--While Döngüler
--------------------------------------------

declare
 v_grupsayi number := 0;
 v_deyer number := 10000;
 v_limit integer := 23;
 v_bitis boolean := false;
begin
 dbms_output.put_line('Dəyər:'|| v_deyer);
 while v_bitis = false loop
 v_grupsayi := v_grupsayi + 1;
 
 if v_deyer <= v_limit then
   v_bitis := true;
 else
   v_deyer := v_deyer - v_limit;
 end if;
 
 end loop;
   dbms_output.put_line('Limit:'|| v_limit);
   dbms_output.put_line('Grup Sayı: '|| v_grupsayi);
end;

--------------------------------------------
--İç İçe Döngüler
--------------------------------------------

declare
 i number := 2;
 j number;
 
begin
 loop
   j:= 2;
   loop
     exit when ((mod(i, j) = 0) or (j = i));
     j := j +1;
   end loop;
 
   if (j = i) then
   dbms_output.put_line(i || ' : tək sayıdır');
   end if;
       i := i + 1;
     exit when i = 50;
   end loop;
end;












