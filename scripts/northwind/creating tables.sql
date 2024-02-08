CREATE TABLE categories (
    category_id smallint NOT NULL PRIMARY KEY,
    category_name varchar2(15) NOT NULL,
    description varchar2(500)
);

CREATE TABLE customers (
    customer_id char(5) NOT NULL PRIMARY KEY,
    company_name varchar2(40) NOT NULL,
    contact_name varchar2(30),
    contact_title varchar2(30),
    address varchar2(60),
    city varchar2(15),
    region varchar2(15),
    postal_code varchar2(10),
    country varchar2(15),
    phone varchar2(24),
    fax varchar2(24)
);

CREATE TABLE employees (
    employee_id smallint NOT NULL PRIMARY KEY,
    last_name varchar2(20) NOT NULL,
    first_name varchar2(10) NOT NULL,
    title varchar2(30),
    title_of_courtesy varchar2(25),
    birth_date date,
    hire_date date,
    address varchar2(60),
    city varchar2(15),
    region varchar2(15),
    postal_code varchar2(10),
    country varchar2(15),
    home_phone varchar2(24),
    extension varchar2(4),
    notes varchar2(500),
    reports_to smallint,
    FOREIGN KEY (reports_to) REFERENCES employees
);

CREATE TABLE suppliers (
    supplier_id smallint NOT NULL PRIMARY KEY,
    company_name varchar2(40) NOT NULL,
    contact_name varchar2(30),
    contact_title varchar2(30),
    address varchar2(60),
    city varchar2(15),
    region varchar2(15),
    postal_code varchar2(10),
    country varchar2(15),
    phone varchar2(24),
    fax varchar2(24),
    homepage varchar2(500)
);

CREATE TABLE products (
    product_id smallint NOT NULL PRIMARY KEY,
    product_name varchar2(40) NOT NULL,
    supplier_id smallint,
    category_id smallint,
    quantity_per_unit varchar2(20),
    unit_price real,
    units_in_stock smallint,
    units_on_order smallint,
    reorder_level smallint,
    discontinued integer NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories,
    FOREIGN KEY (supplier_id) REFERENCES suppliers
);

CREATE TABLE region (
    region_id smallint NOT NULL PRIMARY KEY,
    region_description varchar2(20) NOT NULL
);

CREATE TABLE shippers (
    shipper_id smallint NOT NULL PRIMARY KEY,
    company_name varchar2(40) NOT NULL,
    phone varchar2(24)
);

CREATE TABLE orders (
    order_id smallint NOT NULL PRIMARY KEY,
    customer_id char(5),
    employee_id smallint,
    order_date date,
    required_date date,
    shipped_date date,
    ship_via smallint,
    freight real,
    ship_name varchar2(40),
    ship_address varchar2(60),
    ship_city varchar2(15),
    ship_region varchar2(15),
    ship_postal_code varchar2(10),
    ship_country varchar2(15),
    FOREIGN KEY (customer_id) REFERENCES customers,
    FOREIGN KEY (employee_id) REFERENCES employees,
    FOREIGN KEY (ship_via) REFERENCES shippers
);

CREATE TABLE territories (
    territory_id varchar2(20) NOT NULL PRIMARY KEY,
    territory_description varchar(20) NOT NULL,
    region_id smallint NOT NULL,
	FOREIGN KEY (region_id) REFERENCES region
);

CREATE TABLE employee_territories (
    employee_id smallint NOT NULL,
    territory_id varchar2(20) NOT NULL,
    PRIMARY KEY (employee_id, territory_id),
    FOREIGN KEY (territory_id) REFERENCES territories,
    FOREIGN KEY (employee_id) REFERENCES employees
);

CREATE TABLE order_details (
    order_id smallint NOT NULL,
    product_id smallint NOT NULL,
    unit_price real NOT NULL,
    quantity smallint NOT NULL,
    discount real NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (product_id) REFERENCES products,
    FOREIGN KEY (order_id) REFERENCES orders
);

CREATE TABLE us_states (
    state_id smallint NOT NULL PRIMARY KEY,
    state_name varchar2(100),
    state_abbr varchar2(2),
    state_region varchar2(50)
);
