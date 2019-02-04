create table device_unit_capacity (
  id          varchar(64)  not null primary key,
  name        varchar(150) not null,
  description text
) engine = InnoDB;


insert into device_unit_capacity (id, name, description)
values ('001', 'KG', '-'),
       ('002', 'G', '-'),
       ('003', 'Ons', '-'),
       ('004', 'Bla Bla Bla', '-'),
       ('005', 'Ble Ble Ble', '-');
