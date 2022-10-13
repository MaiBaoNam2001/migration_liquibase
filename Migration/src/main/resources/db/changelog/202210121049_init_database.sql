create table if not exists project
(
    id   varchar(8) not null,
    name varchar(255),
    area varchar(255),
    primary key (id)
);

create table if not exists building
(
    id         varchar(8) not null,
    name       varchar(255),
    project_id varchar(8),
    primary key (id),
    index fk_building_project (project_id) using BTREE,
    constraint fk_building_project foreign key (project_id) references project (id)
);

create table if not exists floor
(
    id         varchar(8) not null,
    name       varchar(255),
    building_id varchar(8),
    primary key (id),
    index fk_floor_building (building_id) using BTREE,
    constraint fk_floor_building foreign key (building_id) references building (id)
);

create table if not exists apartment
(
    id       varchar(8) not null,
    name     varchar(255),
    floor_id varchar(8),
    primary key (id),
    index fk_apartment_floor (floor_id) using BTREE,
    constraint fk_apartment_floor foreign key (floor_id) references floor (id)
);

create table if not exists customer
(
    id            varchar(8) not null,
    name          varchar(255),
    date_of_birth date,
    gender        varchar(255),
    phone         varchar(255),
    email         varchar(255),
    address       varchar(255),
    type          varchar(255),
    identity_card json,
    primary key (id),
    unique index uq_customer_phone (phone) using BTREE,
    unique index uq_customer_email (email) using BTREE
);

create table if not exists apartment_register
(
    customer_id   varchar(8) not null,
    apartment_id  varchar(8) not null,
    is_host       bit,
    register_date date,
    primary key (customer_id, apartment_id),
    index fk_apartment_register_customer (customer_id) using BTREE,
    constraint fk_apartment_register_customer foreign key (customer_id) references customer (id),
    constraint fk_apartment_register_apartment foreign key (apartment_id) references apartment (id)
);

create table if not exists parking_area
(
    id         varchar(8) not null,
    name       varchar(255),
    project_id varchar(8),
    primary key (id),
    unique index uq_parking_area_project_id (project_id) using BTREE,
    index fk_parking_area_project (project_id) using BTREE,
    constraint fk_parking_area_project foreign key (project_id) references project (id)
);

create table if not exists parking_type
(
    id    int(11) not null,
    name  varchar(255),
    price double,
    unit  varchar(255),
    primary key (id)
);

create table if not exists parking_register
(
    customer_id     varchar(8) not null,
    parking_area_id varchar(8) not null,
    license_plate   varchar(255),
    brand_name      varchar(255),
    color           varchar(255),
    vehicle_type    varchar(255),
    register_date   date,
    parking_type_id int(11),
    primary key (customer_id, parking_area_id),
    unique index uq_parking_register_license_plate (license_plate) using BTREE,
    index fk_parking_register_parking_type (parking_type_id) using BTREE,
    index fk_parking_register_customer (customer_id) using BTREE,
    constraint fk_parking_register_parking_type foreign key (parking_type_id) references parking_type (id),
    constraint fk_parking_register_customer foreign key (customer_id) references customer (id),
    constraint fk_parking_register_parking_area foreign key (parking_area_id) references parking_area (id)
);

create table if not exists role
(
    id   int(11) not null,
    name varchar(255),
    primary key (id),
    unique index uq_role_name (name) using BTREE
);

create table if not exists user
(
    username varchar(255) not null,
    phone    varchar(255),
    email    varchar(255),
    password varchar(255),
    role_id  int(11),
    primary key (username),
    unique index uq_user_phone (phone) using BTREE,
    unique index uq_user_email (email) using BTREE,
    index fk_user_role (role_id) using BTREE,
    constraint fk_user_role foreign key (role_id) references role (id)
);