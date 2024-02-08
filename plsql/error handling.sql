--------------------------------------------
--Raise_Application_Error
--------------------------------------------


declare
 e_stock_price_exceed_level1 exception;
 pragma exception_init (e_stock_price_exceed_level1, -20001);
 e_stock_price_exceed_level2 exception;
 pragma exception_init (e_stock_price_exceed_level2, -20002);
 e_stock_price_exceed_level3 exception;
 pragma exception_init (e_stock_price_exceed_level3, -20003);
 
 cursor c_products is
   select product_name, 
   unit_price*units_in_stock as stock_price
   from products;
   v_prod_info varchar2(150);
begin
 
 for v_product_row in c_products loop
 
 v_prod_info := v_product_row.product_name||': '||v_product_row.stock_price;
 
 begin 
 if v_product_row.stock_price between 2000 and 3000 then
 --raise e_stock_price_exceed_level1;
   raise_application_error(-20001,'Alarm!!! Stock Price Level1: ' || v_prod_info);
 elsif v_product_row.stock_price between 3000 and 4000 then
 --raise e_stock_price_exceed_level2;
   raise_application_error(-20002,'Alarm!!! Stock Price Level2: ' || v_prod_info);
 elsif v_product_row.stock_price > 4000 then
   raise_application_error(-20003,'Critical Alarm!!! Stock Price Level3: ' || 
v_prod_info);
 end if;
 
 exception
 when e_stock_price_exceed_level1 then
 dbms_output.put_line('!!!Alarm!!! Stock Price Level1: ' || v_prod_info);
 when e_stock_price_exceed_level2 then
 dbms_output.put_line('!!!Alarm!!! Stock Price Level2: ' || v_prod_info);
 when e_stock_price_exceed_level3 then
 dbms_output.put_line(SQLERRM);
 end; 
 end loop;
 
end
