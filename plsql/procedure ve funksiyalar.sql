--------------------------------------------
--Procedure parametr vermek (OUT)
--------------------------------------------
create or replace procedure personel_bilgi
 (
 p_persona_id in number,
 p_ad out varchar2,
 p_maas out number 
 )
is
begin
 select ad, maas into p_ad, p_maas 
 from personel
 where persoana_id = p_persona_id;
end;
declare
 v_ad varchar2(50);
 v_maas number;
 
begin
 personel_bilgi(5020, v_ad, v_maas);
 dbms_output.put_line(v_ad || ': ' || v_maas);
end;

--------------------------------------------
--Funksiya istifadesi
--------------------------------------------
create or replace function get_manager (p_emp_id number)
return varchar2
result_cache
is
 v_manager_name varchar2(100);
begin
 select first_name || ' ' || last_name 
 into v_manager_name
 from employees
 where employee_id = p_emp_id;
 
 return v_manager_name;
end;

create or replace function get_total_orders(
 p_year pls_integer
) 
return number
is
 v_total_orders number := 0;
begin
 -- get total sales
 select sum(unit_price * quantity)
 into v_total_orders
 from order_details
 inner join orders using (order_id)
 where shipped_date is not null
 group by extract(year from order_date)
 having extract(year from order_date) = p_year;
 
 return v_total_orders;
end





