--------------------------------------------
--Trigger İle Log Tutmaq
--------------------------------------------
create table residence_log
(
 islem_tipi varchar2(20),
 islem_saati date default sysdate,
 evvelki_dept_id number,
 evvelki_dept_ismi varchar2(100),
 yeni_dept_id number,
 yeni_dept_ismi varchar2(100),
 istifadeci varchar2(30) 
);
create or replace trigger trg_res_log
before insert or update or delete on residence_log
for each row
begin
 if INSERTING then
   insert into residence_log (islem_tipi,yeni_dept_id,yeni_dept_ismi,isdifadeci)
   values ('Insert', :new.dept_id, :new.dept_ismi, user);
   elsif DELETING then
   insert into residence_log (islem_tipi,evveli_dept_id,evvelki_dept_ismi,istifadeci)
   values ('Delete', :old.dept_id, :old.dept_ismi, user);
 elsif UPDATING then
   insert into residence_log 
    (islem_tipi,evveli_dept_id,evvelki_dept_ismi,yeni_dept_id,yeni_dept_ismi,istifadeci)
   values ('Update', :old.dept_id, :old.dept_ismi, 
   :new.dept_id, :new.dept_ismi, user);
 end if; 
end;

--------------------------------------------
--Trigger İçinde Procedure istifadesi
--------------------------------------------
create or replace procedure write_dml_log
(
 p_dml_type varchar2,
 p_table_name varchar2,
 p_column_name varchar2,
 p_column_old_value varchar2,
 p_column_new_value varchar2
)
is
begin
 insert into table_dml_log(dml_type, table_name, 
 column_name, column_old_value, column_new_value)
 values(p_dml_type, p_table_name, p_column_name, 
 p_column_old_value, p_column_new_value);
 
end;
create or replace trigger trg_cars
before update on cars
referencing new as new old as old
for each row
begin
 if UPDATING then
   if :new.brand <> :old.brand then
   write_dml_log('U', 'CARS', 'BRAND', :old.brand, :new.brand);
 end if;
   if :new.price <> :old.price then
   write_dml_log('U', 'CARS', 'PRICE', :old.price, :new.price);
 end if;
   if :new.discount <> :old.discount then
   write_dml_log('U', 'CARS', 'DISCOUNT', :old.discount, :new.discount);
   end if;
 end if;
end

--------------------------------------------
--Compound Trigger
--------------------------------------------
create or replace trigger trg_total_discount
 for insert or update on product_segment
 compound trigger
 v_total_discount number;
 before statement is
 begin
 
 -- get the total discount 
 select sum (discount) into v_total_discount 
 from product_segment;
 
 end before statement;
 
 before each row is
 begin
 
 -- check total discount
 if v_total_discount + :new.discount - :old.discount > 0.25 then 
 :new.discount := :old.discount;
 end if;
 
 end before each row;
 
end



