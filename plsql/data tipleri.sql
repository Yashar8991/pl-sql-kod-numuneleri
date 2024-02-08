--------------------------------------------
--record data tipi
--------------------------------------------
declare
 type type_perso is record
 (
 ad personel.ad%type,
 soyad personel.soyad%type,
 maas personel.maas%type,
 giris personel.giris_tarihi%type
 );
 
 v_personel type_perso;
 
begin
 select ad, soyad, maas, giris_tarihi into v_personel
 from personel where personel_id = 5010; 
 dbms_output.put_line('Adı: '|| v_personel.ad);
 dbms_output.put_line('Soyadı: '|| v_personel.soyad);
 dbms_output.put_line('Maaşı: '|| v_personel.maas);
 dbms_output.put_line('İzin Günü: '|| v_personel.giris);
end;


--------------------------------------------
-- rowtype data tipi insert ucun istifade edilebiler
--------------------------------------------

create table personel_ayrilan as
select personel_id, ad, soyad, dept_id, cikis_tarixi
from personel where 1=0;
declare
 v_per_ayr personel_ayrilan%rowtype;
begin
 select personel_id, ad, soyad, 
 dept_id, cikis_tarihi into v_per_ayr
 from personel where personel_id = 5020;
 
 insert into personel_ayrilan values v_per_ayr;
 commit;
end;

--------------------------------------------
--Associative Arrays
--------------------------------------------

declare
 type ulke is table of varchar2(30)
 index by varchar2(2);
 t_olkeler olke;
 v_index varchar2(2);
 
begin
 t_olkeler('TR') := 'Türkiye';
 t_olkeler('UK') := 'United Kingdom';
 t_olkeler('FR') := 'France';
 t_olkeler('DE') := 'Germany';
 t_olkeler('US') := 'Amerika';
 t_olkeler('AU') := 'Avustralya';
 
 v_index := t_olkeler.first;
 
 while v_index is not null loop
 
 dbms_output.put_line(v_index || ': '|| t_olkeler(v_index));
 v_index := t_olkeler.next(v_index);
 
 end loop;
 
end;


declare
 type student_type is table of varchar2(50)
 index by varchar2(50);
 v_students student_type;
 v_students_count pls_integer;
 v_engineers_count pls_integer := 0;
 
 v_key varchar2(50);
 
 v_name varchar2(50);
 v_course_name varchar2(50);
 
begin
 
 select count(*) 
 into v_students_count 
 from student;
 
 for i in 1..v_students_count loop
 
 select name, course_name 
 into v_name, v_course_name from student 
 where id = i;
 
 v_students(v_name) := v_course_name;
 
 end loop;
 v_key := v_students.first;
 
 while v_key is not null loop
 
 if (lower(v_students(v_key)) like '%engineer%') then
 dbms_output.put_line(v_key || ': '|| v_students(v_key));
 v_engineers_count := v_engineers_count + 1;
 end if;
 
 v_key := v_students.next(v_key);
 
 end loop;
 
 dbms_output.put_line('----------------------------------');
 dbms_output.put_line('All students count: ' || v_students.count);
 dbms_output.put_line('Engineer students count: ' || v_engineers_count);
end






  








