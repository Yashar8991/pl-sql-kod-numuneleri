
-- bu funksiya daxilinde procedure ile adi email numunesidir


create or replace function create_emp_email (emp_id number)
return varchar2
is
 v_first_name employees.first_name%type;
 v_last_name employees.last_name%type;
 v_email varchar2(27);
 v_hosting varchar2(12) := 'dbhunter.net';
 v_return_msg varchar2(200);
 -- declare and define procedure
   procedure create_email 
     ( 
       name1 varchar2,
       name2 varchar2,
   company varchar2
     ) 
   is
 error_message varchar2(35) := '...email address is too long...';
 
     begin
     v_email := lower(name1) || '.' || lower(name2) || '@' || company;
     v_return_msg := v_email;
 
       exception
         when value_error then
             v_return_msg := error_message;
 
       end create_email;
 
begin
 
 select first_name, last_name
 into v_first_name, v_last_name
 from employees
 where employee_id = emp_id;
 
 create_email(v_first_name, v_last_name, v_hosting); 
 
 return v_return_msg;
 
end
