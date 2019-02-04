create table device_merk (
  id          varchar(64)  not null primary key,
  name        varchar(150) not null,
  description text
) engine = InnoDB;


insert into device_merk (id, name, description)
values ('001', 'ASUS', '-'),
       ('002', 'Xiaomi', '-'),
       ('003', 'Lenovo', '-'),
       ('004', 'IBM', '-'),
       ('005', 'Oracle', '-');
