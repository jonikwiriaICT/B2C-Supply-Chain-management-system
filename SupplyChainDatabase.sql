create table tb
create table tbl_raw_material_type
(
material_type_id bigint identity(1,1) primary key,
rec_id as material_type_id,
material_name varchar(200),
material_description varchar(max),
created_date date default(getdate()),
created_time time default(getdate())
)
create table tbl_raw_material
(
material_id bigint identity(1,1) primary key,
rec_id as material_id,
raw_material_name varchar(200),
price decimal(18,2),
raw_material_description varchar(max),
material_type_id bigint,
constraint fk_material_type_id foreign key(material_type_id) references tbl_raw_material_type(material_type_id),
created_date date default(getdate()),
created_time time default(getdate())
)


create table tbl_currency(
currency_id bigint identity(1,1) primary key,
rec_id as currency_id,
currency_name varchar(200),
currency_code nvarchar(100), unique,
currency_description varchar(max) ,
created_date date default(getdate()),
created_time time default(getdate())
)

create table tbl_branch
(
branch_id bigint identity(1,1) primary key,
currency_id bigint,
constraint fk_branch_currencyID foreign key(currency_id) references tbl_currency(currency_id),
branch_name varchar(200) unique,
branch_address varchar(300),
branch_latitude decimal(18,2),
branch_longitude decimal(18,2),
contact_person varchar(200),
city varchar(200),
state varchar(200),
zipcode varchar(200),
phone_no varchar(20) unique,
email varchar(200) unique,
created_date date default(getdate()),
created_time time default(getdate())
)

create table tbl_payment_method
(
)
