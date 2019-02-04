create table device_category (
  id          varchar(64)  not null primary key,
  name        varchar(150) not null,
  description text
) engine = InnoDB;
