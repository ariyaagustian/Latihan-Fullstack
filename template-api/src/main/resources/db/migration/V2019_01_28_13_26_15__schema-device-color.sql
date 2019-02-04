create table device_color (
  id          varchar(64)  not null primary key,
  name        varchar(150) not null,
  description text,
  color_code varchar(64)
) engine = InnoDB;


insert into device_color(id, name, description, color_code)
values ('001', 'Putih', 'Warna Putih', '#ffffff'),
       ('002', 'Hitam', 'Warna Hitam', '#000000'),
       ('003', 'Merah', 'Warna Merah', '#ff0000'),
       ('004', 'Kuning', 'Warna Kuning', '#ffff00'),
       ('005', 'Hijau', 'Warna Hijau', '#00ff00');
