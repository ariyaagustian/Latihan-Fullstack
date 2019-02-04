create table device_condition (
  id          varchar(64)  not null primary key,
  name        varchar(150) not null,
  description text
) engine = InnoDB;


insert into device_condition (id, name, description)
values ('001', 'Rusak', '-'),
       ('002', 'Baik', '-'),
       ('003', 'Hilang', '-'),
       ('004', 'Bla Bla Bla', '-'),
       ('005', 'Ble Ble Ble', '-');
