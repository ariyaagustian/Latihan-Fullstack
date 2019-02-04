create table device_loan_status (
  id          varchar(64)  not null primary key,
  name        varchar(150) not null,
  description text
) engine = InnoDB;


insert into device_loan_status (id, name, description)
values ('001', 'Loan', '-'),
       ('002', 'Free', '-'),
       ('003', 'Can not Loan', '-'),
       ('004', 'Bla Bla Bla', '-'),
       ('005', 'Ble Ble Ble', '-');
