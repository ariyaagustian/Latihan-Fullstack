create table device (
  id          varchar(64)  not null primary key,
  name        varchar(150) not null,
  description text,
  color_id varchar(64),
  merk_id varchar(64),
  category_id varchar(64),
  condition_id varchar(64),
  status_loan_id varchar(64),
  unit_capacity_id varchar(64)
) engine = InnoDB;

alter table device
  add constraint fk_device_merk foreign key (merk_id)
    references device_merk (id) on update cascade on delete restrict;

alter table device
  add constraint fk_device_color foreign key (color_id)
    references device_color (id) on update cascade on delete restrict;

alter table device
  add constraint fk_device_category foreign key (category_id)
    references device_category (id) on update cascade on delete restrict;

alter table device
  add constraint fk_device_status_loan foreign key (status_loan_id)
    references device_loan_status (id) on update cascade on delete restrict;

alter table device
  add constraint fk_device_condition foreign key (condition_id)
    references device_condition (id) on update cascade on delete restrict;

alter table device
  add constraint fk_device_unit_capacity foreign key (unit_capacity_id)
    references device_unit_capacity (id) on update cascade on delete restrict;

