create or replace view application_name as select `itime`.`application_release`.`application_release_id` AS `id`,
       `itime`.`application_release`.`display_name`           AS `description`,
       `itime`.`application_release`.`life_cycle_type_id`     AS `life_cycle_type`
from `itime`.`application_release`
where (`itime`.`application_release`.`delflag` = 0);

create or replace view developer as select distinct `user`.`user_detail_id`     AS `id`,
                `itime`.`corporate`.`name`  AS `company_name`,
                `employee`.`developer_name` AS `pm_name`,
                `user`.`handphone`          AS `no_hp`,
                `employee`.`wa_number`      AS `no_hp_wa`,
                `employee`.`email`          AS `email`,
                `user`.`login_id`           AS `login_id`
from ((`itime`.`user_detail` `user` join `itime`.`vendor_pic` `employee` on ((`user`.`user_detail_id` = `employee`.`user_detail_id`)))
       join `itime`.`corporate` on ((`employee`.`corporate_id` = `itime`.`corporate`.`corporate_id`)));

create or replace view employee_letter as select uuid()                      AS `id`,
                                      `employee`.`id`             AS `id_employee`,
                                      `push`.`id`                 AS `id_letter`,
                                      `status`.`letter_status`    AS `status`,
                                      `push`.`letter_date`        AS `tanggal`,
                                      `types`.`letter_type`       AS `jenis_surat`,
                                      `employee`.`employee_email` AS `email`
                               from ((((`itime`.`resource_employee` `employee` join `itime`.`push_employee` on ((`employee`.`id` = `itime`.`push_employee`.`resource_employee_id`))) join `itime`.`letter_push` `push` on ((`itime`.`push_employee`.`id` = `push`.`push_employee_id`))) join `itime`.`letter_status` `status` on ((`push`.`letter_status_id` = `status`.`id`)))
                                      join `itime`.`letter_types` `types` on ((`push`.`letter_types_id` = `types`.`id`)))
                               union all
                               select uuid()                      AS `id`,
                                      `employee`.`id`             AS `id_employee`,
                                      `assignment`.`id`           AS `id_letter`,
                                      `status`.`letter_status`    AS `status`,
                                      `assignment`.`letter_date`  AS `tanggal`,
                                      `types`.`letter_type`       AS `jenis_surat`,
                                      `employee`.`employee_email` AS `email`
                               from (((`itime`.`resource_employee` `employee` join `itime`.`letter_assignment` `assignment` on ((`employee`.`id` = `assignment`.`resource_employee_id`))) join `itime`.`letter_status` `status` on ((`assignment`.`letter_status_id` = `status`.`id`)))
                                      join `itime`.`letter_types` `types`
                                           on ((`assignment`.`letter_types_id` = `types`.`id`)))
                               union all
                               select uuid()                      AS `id`,
                                      `employee`.`id`             AS `id_employee`,
                                      `monition`.`id`             AS `id_letter`,
                                      `status`.`letter_status`    AS `status`,
                                      `monition`.`letter_date`    AS `tanggal`,
                                      `types`.`letter_type`       AS `jenis_surat`,
                                      `employee`.`employee_email` AS `email`
                               from (((`itime`.`resource_employee` `employee` join `itime`.`letter_monition` `monition` on ((`employee`.`id` = `monition`.`resource_employee_id`))) join `itime`.`letter_status` `status` on ((`monition`.`letter_status_id` = `status`.`id`)))
                                      join `itime`.`letter_types` `types`
                                           on ((`monition`.`letter_types_id` = `types`.`id`)));

create or replace view employee_registration as select uuid()                                                                                    AS `id`,
       (case when (`others`.`id_sit_lead` is not null) then `others`.`id_sit_lead` else 666 end) AS `sit_lead`,
       (case when (`others`.`id_uat_lead` is not null) then `others`.`id_uat_lead` else 666 end) AS `uat_lead`
from `itime`.`registration_others` `others`;

create or replace view interviewer as select cast(conv(`itime`.`employee`.`employee_id`, 16, 10) as unsigned) AS `id`,
       `itime`.`employee`.`employee_name`                               AS `name`,
       `itime`.`employee`.`nip`                                         AS `nip`,
       `itime`.`employee`.`title`                                       AS `jabatan`,
       `itime`.`employee`.`department`                                  AS `unit_kerja`
from `itime`.`employee`;

create or replace view it_service_owners as select distinct `user`.`user_detail_id`            AS `id`,
                `itime`.`employee`.`employee_name` AS `emp_no_name`,
                `user`.`handphone`                 AS `no_hp`,
                `itime`.`employee`.`wa_number`     AS `no_hp_wa`,
                `user`.`email`                     AS `email`,
                `user`.`login_id`                  AS `login_id`
from (`itime`.`user_detail` `user`
       left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)));

create or replace view master_member as select distinct `user`.`user_detail_id`                                     AS `id`,
                `itime`.`employee`.`nip`                                    AS `nik`,
                `user`.`name`                                               AS `nama`,
                `user`.`email`                                              AS `email`,
                `user`.`login_id`                                           AS `login_id`,
                (case
                   when isnull(`itime`.`employee`.`title`) then `user`.`title`
                   else convert(`itime`.`employee`.`title` using utf8) end) AS `jabatan`,
                `itime`.`employee`.`wa_number`                              AS `wa_number`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

create or replace view new_remys_report as select `oh`.`action_date`                                                                  AS `Date_Time`,
       `oh`.`comment`                                                                      AS `Comment`,
       (select `itime`.`common_code`.`value`
        from `itime`.`common_code`
        where (`itime`.`common_code`.`property` = convert(`oh`.`action_code` using utf8))) AS `Action_Code`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` = `oh`.`from_environment_id`))       AS `From_Staging`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` = `oh`.`to_environment_id`))         AS `To_Staging`,
       (select lpad(`oh`.`deployment_set_id`, 8, 0))                                       AS `Deployment_Set`,
       (select group_concat(`itime`.`object_task`.`task_name` separator ', ')
        from (((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_task` on ((
            `itime`.`application_object`.`application_object_id` =
            `itime`.`application_object_task`.`application_object_id`)))
               join `itime`.`object_task`
                    on ((`itime`.`application_object_task`.`object_task_id` = `itime`.`object_task`.`object_task_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Task_Name`,
       (select group_concat(`itime`.`remys_project`.`name` separator ', ')
        from (((((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_task` on ((
            `itime`.`application_object`.`application_object_id` =
            `itime`.`application_object_task`.`application_object_id`))) join `itime`.`object_task` on ((
            `itime`.`application_object_task`.`object_task_id` =
            `itime`.`object_task`.`object_task_id`))) join `itime`.`registration` on ((
            `itime`.`object_task`.`registration_id` = `itime`.`registration`.`registration_id`)))
               join `itime`.`remys_project`
                    on ((`itime`.`registration`.`remys_project_id` = `itime`.`remys_project`.`remys_project_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Project_Code`,
       (select `itime`.`application_object`.`object_name`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Name`,
       (select `itime`.`application_object`.`object_type`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Type`,
       (select `itime`.`application_object_detail`.`size`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Size`,
       (select `itime`.`application_object_detail`.`created_date`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Load_Date`,
       (select `itime`.`application_object_detail`.`modified_date`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Modified_Date`,
       (select lpad(`itime`.`application_object_detail`.`load_version`, 4, 0)
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Load_Version`,
       (select lpad(`itime`.`application_object_detail`.`crc_version`, 4, 0)
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `CRC_Version`,
       (select `itime`.`application_object_detail`.`crc`
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `CRC`,
       (select `itime`.`application`.`name`
        from (((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_release` on ((
            `itime`.`application_object`.`application_release_id` =
            `itime`.`application_release`.`application_release_id`)))
               join `itime`.`application`
                    on ((`itime`.`application_release`.`application_id` = `itime`.`application`.`application_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Application_Name`,
       (select `itime`.`application_release`.`display_name`
        from ((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`)))
               join `itime`.`application_release` on ((`itime`.`application_object`.`application_release_id` =
                                                       `itime`.`application_release`.`application_release_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Release_Name`,
       (select `itime`.`user_detail`.`login_id`
        from `itime`.`user_detail`
        where (`itime`.`user_detail`.`user_detail_id` = `oh`.`action_user`))               AS `Login_Id`
from `itime`.`object_history` `oh`
order by `oh`.`application_object_detail_id`,`oh`.`object_history_id`;

create or replace view project_general as select `general`.`registration_id` AS `id`,
       `code`.`code`               AS `project_cr_code`,
       `code`.`project_name`       AS `project_cr_name`,
       `pm`.`employee_name`        AS `project_manager_name`
from ((`itime`.`registration_general` `general` join `itime`.`project_cr_code` `code` on ((`general`.`id_project_cr_code` = `code`.`id`)))
       join `itime`.`employee` `pm` on ((`general`.`id_project_manager` = `pm`.`employee_id`)))
where (`general`.`id_tpm_status` = 2);

create or replace view project_manager as select distinct `user`.`user_detail_id`               AS `id`,
                `user`.`name`                         AS `name`,
                `user`.`handphone`                    AS `no_hp`,
                `itime`.`employee`.`wa_number`        AS `no_hp_wa`,
                `itime`.`employee_group`.`group_name` AS `group_name`,
                `user`.`email`                        AS `email`,
                `user`.`login_id`                     AS `login_id`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

create or replace view registration_assigned as select distinct `general`.`registration_id`                                                                                AS `id`,
                `general`.`registration_no`                                                                                AS `registration_number`,
                `itime`.`remys_project`.`code`                                                                             AS `project_cr_code`,
                `itime`.`remys_project`.`name`                                                                             AS `project_name`,
                `book`.`book_date_from`                                                                                    AS `sit_uat_start_plan_date`,
                `book`.`book_date_to`                                                                                      AS `sit_uat_end_plan_date`,
                (select count(0)
                 from `itime`.`resource_book`
                 where (`itime`.`resource_book`.`registration_general_id` =
                        `general`.`registration_id`))                                                                      AS `available_tester`,
                (select count(0)
                 from `itime`.`resource_claim`
                 where `itime`.`resource_claim`.`book_resource_id` in (select `itime`.`resource_book`.`id`
                                                                       from `itime`.`resource_book`
                                                                       where (`itime`.`resource_book`.`registration_general_id` =
                                                                              `general`.`registration_id`)))               AS `claimed_tester`,
                (select count(0)
                 from `itime`.`resource_claim_script`
                 where `itime`.`resource_claim_script`.`resource_claim_id` in (select `itime`.`resource_claim`.`id`
                                                                               from `itime`.`resource_claim`
                                                                               where
                                                                                   `itime`.`resource_claim`.`book_resource_id` in
                                                                                   (select `itime`.`resource_book`.`id`
                                                                                    from `itime`.`resource_book`
                                                                                    where (`itime`.`resource_book`.`registration_general_id` =
                                                                                           `general`.`registration_id`)))) AS `assigned_tester`
from (((`itime`.`registration_general` `general` left join `itime`.`remys_project` on ((
    `itime`.`remys_project`.`remys_project_id` =
    `general`.`id_project_cr_code`))) left join `itime`.`resource_book` `book` on ((`book`.`registration_general_id` = `general`.`registration_id`)))
       left join `itime`.`registration_others` `others` on ((`others`.`reg_others_id` = `general`.`reg_others_id`)))
where (`general`.`id_tpm_status` = 2)
order by `registration_number`;

create or replace view registration_booked as select distinct `general`.`registration_id`                                                               AS `id`,
                `general`.`registration_no`                                                               AS `registration_number`,
                `itime`.`remys_project`.`name`                                                            AS `project_cr_code`,
                `itime`.`remys_project`.`project`                                                         AS `project_name`,
                `book`.`book_date_from`                                                                   AS `reserved_date`,
                `book`.`book_date_to`                                                                     AS `end_date`,
                `general`.`create_user`                                                                   AS `created_by`,
                `others`.`no_tester`                                                                      AS `need_tester`,
                (select count(0)
                 from `itime`.`resource_book`
                 where (`itime`.`resource_book`.`registration_general_id` =
                        `general`.`registration_id`))                                                     AS `total_tester`
from (((`itime`.`registration_general` `general` left join `itime`.`remys_project` on ((
    `itime`.`remys_project`.`remys_project_id` =
    `general`.`id_project_cr_code`))) left join `itime`.`resource_book` `book` on ((`book`.`registration_general_id` = `general`.`registration_id`)))
       left join `itime`.`registration_others` `others` on ((`others`.`reg_others_id` = `general`.`reg_others_id`)))
where (`general`.`id_tpm_status` = 2)
order by `registration_number`;

create or replace view registration_report as select `oh`.`action_date`                                                                  AS `Date_Time`,
       `oh`.`comment`                                                                      AS `Comment`,
       (select `itime`.`common_code`.`value`
        from `itime`.`common_code`
        where (`itime`.`common_code`.`property` = convert(`oh`.`action_code` using utf8))) AS `Action_Code`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` = `oh`.`from_environment_id`))       AS `From_Staging`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` = `oh`.`to_environment_id`))         AS `To_Staging`,
       (select lpad(`oh`.`deployment_set_id`, 8, 0))                                       AS `Deployment_Set`,
       (select group_concat(`itime`.`object_task`.`task_name` separator ', ')
        from (((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_task` on ((
            `itime`.`application_object`.`application_object_id` =
            `itime`.`application_object_task`.`application_object_id`)))
               join `itime`.`object_task`
                    on ((`itime`.`application_object_task`.`object_task_id` = `itime`.`object_task`.`object_task_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Task_Name`,
       (select group_concat(`itime`.`remys_project`.`name` separator ', ')
        from (((((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_task` on ((
            `itime`.`application_object`.`application_object_id` =
            `itime`.`application_object_task`.`application_object_id`))) join `itime`.`object_task` on ((
            `itime`.`application_object_task`.`object_task_id` =
            `itime`.`object_task`.`object_task_id`))) join `itime`.`registration` on ((
            `itime`.`object_task`.`registration_id` = `itime`.`registration`.`registration_id`)))
               join `itime`.`remys_project`
                    on ((`itime`.`registration`.`remys_project_id` = `itime`.`remys_project`.`remys_project_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Project_Code`,
       (select `itime`.`application_object`.`object_name`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Name`,
       (select `itime`.`application_object`.`object_type`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Type`,
       (select `itime`.`application_object_detail`.`size`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Size`,
       (select `itime`.`application_object_detail`.`created_date`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Load_Date`,
       (select `itime`.`application_object_detail`.`modified_date`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Modified_Date`,
       (select lpad(`itime`.`application_object_detail`.`load_version`, 4, 0)
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Load_Version`,
       (select lpad(`itime`.`application_object_detail`.`crc_version`, 4, 0)
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `CRC_Version`,
       (select `itime`.`application_object_detail`.`crc`
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `CRC`,
       (select `itime`.`application_release`.`display_name`
        from ((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`)))
               join `itime`.`application_release` on ((`itime`.`application_object`.`application_release_id` =
                                                       `itime`.`application_release`.`application_release_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Release_Name`,
       (select `itime`.`user_detail`.`login_id`
        from `itime`.`user_detail`
        where (`itime`.`user_detail`.`user_detail_id` = `oh`.`action_user`))               AS `Login_Id`
from `itime`.`object_history` `oh`
order by `oh`.`application_object_detail_id`,`oh`.`object_history_id`;

create or replace view registration_report_data as select `oh`.`action_date`                                                                  AS `Date_Time`,
       `oh`.`comment`                                                                      AS `Comment`,
       (select `itime`.`common_code`.`value`
        from `itime`.`common_code`
        where (`itime`.`common_code`.`property` = convert(`oh`.`action_code` using utf8))) AS `Action_Code`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` = `oh`.`from_environment_id`))       AS `From_Staging`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` = `oh`.`to_environment_id`))         AS `To_Staging`,
       (select lpad(`oh`.`deployment_set_id`, 8, 0))                                       AS `Deployment_Set`,
       (select group_concat(`itime`.`object_task`.`task_name` separator ', ')
        from (((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_task` on ((
            `itime`.`application_object`.`application_object_id` =
            `itime`.`application_object_task`.`application_object_id`)))
               join `itime`.`object_task`
                    on ((`itime`.`application_object_task`.`object_task_id` = `itime`.`object_task`.`object_task_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Task_Name`,
       (select group_concat(`itime`.`remys_project`.`name` separator ', ')
        from (((((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_task` on ((
            `itime`.`application_object`.`application_object_id` =
            `itime`.`application_object_task`.`application_object_id`))) join `itime`.`object_task` on ((
            `itime`.`application_object_task`.`object_task_id` =
            `itime`.`object_task`.`object_task_id`))) join `itime`.`registration` on ((
            `itime`.`object_task`.`registration_id` = `itime`.`registration`.`registration_id`)))
               join `itime`.`remys_project`
                    on ((`itime`.`registration`.`remys_project_id` = `itime`.`remys_project`.`remys_project_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Project_Code`,
       (select `itime`.`application_object`.`object_name`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Name`,
       (select `itime`.`application_object`.`object_type`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Type`,
       (select `itime`.`application_object_detail`.`size`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Size`,
       (select `itime`.`application_object_detail`.`created_date`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Load_Date`,
       (select `itime`.`application_object_detail`.`modified_date`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Modified_Date`,
       (select lpad(`itime`.`application_object_detail`.`load_version`, 4, 0)
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Load_Version`,
       (select lpad(`itime`.`application_object_detail`.`crc_version`, 4, 0)
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `CRC_Version`,
       (select `itime`.`application_object_detail`.`crc`
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `CRC`,
       (select `itime`.`application_release`.`display_name`
        from ((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`)))
               join `itime`.`application_release` on ((`itime`.`application_object`.`application_release_id` =
                                                       `itime`.`application_release`.`application_release_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Release_Name`,
       (select `itime`.`user_detail`.`login_id`
        from `itime`.`user_detail`
        where (`itime`.`user_detail`.`user_detail_id` = `oh`.`action_user`))               AS `Login_Id`
from `itime`.`object_history` `oh`
order by `oh`.`application_object_detail_id`,`oh`.`object_history_id`;

create or replace view resource_attendance as select uuid()                                                                AS `id`,
       `t1`.`resource_employee_id`                                           AS `resource_employee_id`,
       `t1`.`jam_masuk`                                                      AS `jam_masuk`,
       if((`t1`.`jam_pulang` = `t1`.`jam_masuk`), NULL, `t1`.`jam_pulang`)   AS `jam_pulang`,
       if(((timestampdiff(MINUTE, `t1`.`jam_masuk`, `t1`.`jam_pulang`) - 60) < 0), 0,
          (timestampdiff(MINUTE, `t1`.`jam_masuk`, `t1`.`jam_pulang`) - 60)) AS `total_menit`
from `itime`.`resource_attendance_from` `t1`
order by `t1`.`resource_employee_id`,`t1`.`jam_masuk`,if((`t1`.`jam_pulang` = `t1`.`jam_masuk`), NULL, `t1`.`jam_pulang`);

create or replace view resource_attendance_from as select distinct `l`.`emp_id`                                                                                AS `resource_employee_id`,
                (select min(`itime`.`employee_attendance`.`waktu`)
                 from `itime`.`employee_attendance`
                 where ((`itime`.`employee_attendance`.`emp_id` = `l`.`emp_id`) and
                        (cast(`itime`.`employee_attendance`.`waktu` as date) =
                         cast(`l`.`waktu` as date))))                                                       AS `jam_masuk`,
                (select max(`itime`.`employee_attendance`.`waktu`)
                 from `itime`.`employee_attendance`
                 where ((`itime`.`employee_attendance`.`emp_id` = `l`.`emp_id`) and
                        (cast(`itime`.`employee_attendance`.`waktu` as date) =
                         cast(`l`.`waktu` as date))))                                                       AS `jam_pulang`
from `itime`.`employee_attendance` `l`;

create or replace view resource_task_assignment as select uuid()                    AS `id`,
       `rg`.`registration_id`    AS `registration_id`,
       `rg`.`registration_no`    AS `registration_no`,
       `rg`.`id_project_cr_code` AS `project_cr_code_id`,
       `rp`.`description`        AS `remys_description`,
       `re`.`name`               AS `resource_emp_name`,
       `condetail`.`work_email`  AS `email`,
       `vendor`.`name`           AS `vendor`,
       `jc`.`description`        AS `job_description`,
       `jt`.`description`        AS `title_description`,
       `rb`.`book_date_from`     AS `book_date_from`,
       `rb`.`book_date_to`       AS `book_date_to`,
       `tsn`.`test_script_total` AS `test_script_total`,
       `tsn`.`capacity_total`    AS `capacity_total`,
       `tsn`.`nik`               AS `nik`,
       `tsn`.`test_script_date`  AS `test_script_date`,
       `statusapproval`.`name`   AS `status_approval`,
       `tsn`.`note`              AS `note`,
       `tsn`.`assignment_date`   AS `assignment_date`,
       `statuswork`.`name`       AS `work_status`,
       `tsn`.`submit_by`         AS `submited_by`
from ((((((((((((`itime`.`registration_general` `rg` left join `itime`.`remys_project` `rp` on ((`rg`.`id_project_cr_code` = `rp`.`remys_project_id`))) left join `itime`.`resource_book` `rb` on ((`rb`.`registration_general_id` = `rg`.`registration_id`))) join `itime`.`resource_claim` `rc` on ((`rb`.`id` = `rc`.`book_resource_id`))) join `itime`.`resource_employee` `re` on ((`rb`.`resource_employee_id` = `re`.`id`))) left join `itime`.`job` `j` on ((`re`.`job_id` = `j`.`id`))) left join `itime`.`job_category` `jc` on ((`j`.`job_category_id` = `jc`.`id`))) left join `itime`.`job_title` `jt` on ((`j`.`job_title_id` = `jt`.`id`))) left join `itime`.`applicant` `a` on ((`re`.`applicant_id` = `a`.`id`))) left join `itime`.`personal_details` `pd` on ((`a`.`personal_detail_id` = `pd`.`id`))) left join `itime`.`contact_details` `condetail` on ((`a`.`contact_detail_id` = `condetail`.`id`))) left join `itime`.`vendors` `vendor` on ((`vendor`.`id` = `pd`.`vendor_id`)))
       left join ((`itime`.`test_script_new` `tsn` left join `itime`.`status_approval` `statusapproval` on ((`statusapproval`.`id` = `tsn`.`status_approval_id`))) left join `itime`.`status_approval` `statuswork` on ((`statuswork`.`id` = `tsn`.`work_status_id`)))
                 on (((`rg`.`registration_id` = `tsn`.`registration_general_id`) and (`tsn`.`nik` = `pd`.`no_ktp`))));

create or replace view resource_test_script_assignment as select uuid()                                                          AS `id`,
       `rg`.`registration_id`                                          AS `registration_id`,
       `rg`.`registration_no`                                          AS `registration_no`,
       `rg`.`id_project_cr_code`                                       AS `project_cr_code_id`,
       `rp`.`description`                                              AS `remys_description`,
       `re`.`name`                                                     AS `resource_emp_name`,
       `condetail`.`work_email`                                        AS `email`,
       `re`.`id`                                                       AS `resource_employee_id`,
       `vendor`.`name`                                                 AS `vendor`,
       `jc`.`description`                                              AS `job_description`,
       `jt`.`description`                                              AS `title_description`,
       `rb`.`book_date_from`                                           AS `book_date_from`,
       `rb`.`book_date_to`                                             AS `book_date_to`,
       sum(`tsn`.`test_script_total`)                                  AS `test_script_total`,
       sum(`tsn`.`capacity_total`)                                     AS `capacity_total`,
       `tsn`.`nik`                                                     AS `nik`,
       `statusapproval`.`name`                                         AS `status_approval`,
       `statusapproval`.`id`                                           AS `status_approval_id`,
       `tsn`.`note`                                                    AS `note`,
       `tsn`.`assignment_date`                                         AS `assignment_date`,
       `statuswork`.`name`                                             AS `work_status`,
       `statuswork`.`id`                                               AS `work_status_id`,
       `tsn`.`submit_by`                                               AS `submited_by`,
       (to_days(`rb`.`book_date_to`) - to_days(`rb`.`book_date_from`)) AS `duration`
from ((((((((((((((`itime`.`registration_general` `rg` left join `itime`.`remys_project` `rp` on ((`rg`.`id_project_cr_code` = `rp`.`remys_project_id`))) left join `itime`.`resource_book` `rb` on ((`rb`.`registration_general_id` = `rg`.`registration_id`))) join `itime`.`resource_claim` `rc` on ((`rb`.`id` = `rc`.`book_resource_id`))) join `itime`.`resource_employee` `re` on ((`rb`.`resource_employee_id` = `re`.`id`))) left join `itime`.`job` `j` on ((`re`.`job_id` = `j`.`id`))) left join `itime`.`job_category` `jc` on ((`j`.`job_category_id` = `jc`.`id`))) left join `itime`.`job_title` `jt` on ((`j`.`job_title_id` = `jt`.`id`))) left join `itime`.`applicant` `a` on ((`re`.`applicant_id` = `a`.`id`))) left join `itime`.`personal_details` `pd` on ((`a`.`personal_detail_id` = `pd`.`id`))) left join `itime`.`contact_details` `condetail` on ((`a`.`contact_detail_id` = `condetail`.`id`))) left join `itime`.`vendors` `vendor` on ((`vendor`.`id` = `pd`.`vendor_id`))) left join `itime`.`test_script_new` `tsn` on ((
    (`rg`.`registration_id` = `tsn`.`registration_general_id`) and
    (`tsn`.`nik` = `pd`.`no_ktp`)))) left join `itime`.`status_approval` `statusapproval` on ((`statusapproval`.`id` = `tsn`.`status_approval_id`)))
       left join `itime`.`status_approval` `statuswork` on ((`statuswork`.`id` = `tsn`.`work_status_id`)))
group by `rg`.`registration_id`,`rg`.`registration_no`,`project_cr_code_id`,`remys_description`,`resource_emp_name`,`email`,`rb`.`resource_employee_id`,`vendor`,`job_description`,`title_description`,`rb`.`book_date_from`,`rb`.`book_date_to`,`tsn`.`nik`,`status_approval`,`status_approval_id`,`tsn`.`note`,`tsn`.`assignment_date`,`work_status`,`work_status_id`,`submited_by`;

create or replace view rr as select cast(`itime`.`user_detail`.`user_detail_id` as char(50) charset utf8)              AS `user_id`,
       `itime`.`user_detail`.`name`                                                       AS `username`,
       `itime`.`role`.`name`                                                              AS `role`,
       group_concat(distinct `itime`.`application_release`.`display_name` separator '\n') AS `release`,
       `itime`.`application`.`name`                                                       AS `application`,
       `itime`.`application_group`.`name`                                                 AS `group`
from (((((((((`itime`.`user_detail` left join `itime`.`user_detail_role` on ((`itime`.`user_detail`.`user_detail_id` =
                                                                              `itime`.`user_detail_role`.`user_detail_id`))) left join `itime`.`role` on ((`itime`.`role`.`role_id` = `itime`.`user_detail_role`.`role_id`))) left join `itime`.`role_component_menu` on ((`itime`.`role`.`role_id` = `itime`.`role_component_menu`.`role_id`))) left join `itime`.`component_menu` on ((
    `itime`.`role_component_menu`.`component_menu_id` =
    `itime`.`component_menu`.`view_id`))) left join `itime`.`userdetail_releaserole` on ((
    `itime`.`user_detail`.`user_detail_id` =
    `itime`.`userdetail_releaserole`.`user_detail_id`))) left join `itime`.`releaserole_release` on ((
    `itime`.`userdetail_releaserole`.`releaserole_id` =
    `itime`.`releaserole_release`.`releaserole_id`))) left join `itime`.`application_release` on ((
    `itime`.`releaserole_release`.`application_release_id` =
    `itime`.`application_release`.`application_release_id`))) left join `itime`.`application` on ((
    `itime`.`application_release`.`application_id` = `itime`.`application`.`application_id`)))
       left join `itime`.`application_group` on ((`itime`.`application`.`application_group_id` =
                                                  `itime`.`application_group`.`application_group_id`)))
group by `itime`.`user_detail`.`name`,`itime`.`role`.`name`;

create or replace view sit_lead as select distinct `user`.`user_detail_id`            AS `id`,
                `itime`.`employee`.`nip`           AS `nik`,
                `itime`.`employee`.`employee_name` AS `name`,
                `user`.`email`                     AS `email`,
                `user`.`login_id`                  AS `login_id`,
                `itime`.`employee`.`title`         AS `jabatan`,
                `itime`.`employee`.`wa_number`     AS `wa_number`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

create or replace view testdua as select `itime`.`application_object`.`application_object_id`                                                    AS `application_object_id`,
       `itime`.`registration`.`date_creation`                                                                  AS `Registration_Created_Date`,
       (select `itime`.`application_group`.`name`
        from ((`itime`.`application_release` join `itime`.`application` on ((
            `itime`.`application_release`.`application_id` = `itime`.`application`.`application_id`)))
               join `itime`.`application_group` on ((`itime`.`application`.`application_group_id` =
                                                     `itime`.`application_group`.`application_group_id`)))
        where (`itime`.`application_release`.`application_release_id` =
               `itime`.`registration`.`application_release_id`))                                               AS `Group_Name`,
       (select `itime`.`application`.`name`
        from (`itime`.`application_release`
               join `itime`.`application`
                    on ((`itime`.`application_release`.`application_id` = `itime`.`application`.`application_id`)))
        where (`itime`.`application_release`.`application_release_id` =
               `itime`.`registration`.`application_release_id`))                                               AS `Application_Name`,
       (select `itime`.`application_release`.`name`
        from `itime`.`application_release`
        where (`itime`.`application_release`.`application_release_id` =
               `itime`.`registration`.`application_release_id`))                                               AS `Release_Name`,
       (select `rp`.`name`
        from `itime`.`remys_project` `rp`
        where (`rp`.`remys_project_id` = `itime`.`registration`.`remys_project_id`))                           AS `Project_Name`,
       `itime`.`object_task`.`task_name`                                                                       AS `Task_Name`,
       `itime`.`application_object`.`object_name`                                                              AS `Object_Name`,
       `itime`.`registration`.`dokumen_nota_migrasi_file_name`                                                 AS `Nomor_Nota`,
       `itime`.`registration`.`tanggal_nota_migrasi`                                                           AS `Tangga_Nota`,
       `itime`.`registration`.`sit_status_id`                                                                  AS `SIT_Status`,
       `itime`.`registration`.`uat_status_id`                                                                  AS `UAT_Status`,
       `itime`.`registration`.`promote_status_id`                                                              AS `Promote_Status`,
       `itime`.`registration`.`live_status_id`                                                                 AS `Live_Status`,
       `itime`.`object_history`.`action_date`                                                                  AS `Action_User`,
       (select `itime`.`common_code`.`value`
        from `itime`.`common_code`
        where (`itime`.`common_code`.`property` =
               convert(`itime`.`object_history`.`action_code` using utf8)))                                    AS `Action_Code`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` =
               `itime`.`object_history`.`from_environment_id`))                                                AS `From_Environment`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` =
               `itime`.`object_history`.`to_environment_id`))                                                  AS `To_Environment`,
       (select `itime`.`user_detail`.`login_id`
        from `itime`.`user_detail`
        where (`itime`.`user_detail`.`user_detail_id` =
               `itime`.`object_history`.`action_user`))                                                        AS `Action_by_User`,
       `itime`.`deploy_log`.`created_on`                                                                       AS `Deploy_Log_Date`,
       (select `itime`.`target`.`host`
        from `itime`.`target`
        where (`itime`.`target`.`target_id` = `itime`.`deploy_log`.`target_id`))                               AS `Target_Host`,
       (select `itime`.`target`.`path`
        from `itime`.`target`
        where (`itime`.`target`.`target_id` = `itime`.`deploy_log`.`target_id`))                               AS `Target_Path`,
       `itime`.`deploy_log`.`request`                                                                          AS `Request`,
       `itime`.`deploy_log`.`response`                                                                         AS `Response`
from ((((((`itime`.`registration` join `itime`.`object_task` on ((`itime`.`registration`.`registration_id` =
                                                                  `itime`.`object_task`.`registration_id`))) join `itime`.`application_object_task` on ((
    `itime`.`object_task`.`object_task_id` =
    `itime`.`application_object_task`.`object_task_id`))) join `itime`.`application_object` on ((
    `itime`.`application_object_task`.`application_object_id` =
    `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_detail` on ((
    `itime`.`application_object`.`application_object_id` =
    `itime`.`application_object_detail`.`application_object_id`))) join `itime`.`object_history` on ((
    `itime`.`application_object_detail`.`application_object_detail_id` =
    `itime`.`object_history`.`application_object_detail_id`)))
       left join `itime`.`deploy_log`
                 on ((`itime`.`object_history`.`deployment_set_id` = `itime`.`deploy_log`.`deployment_set_id`)))
where ((`itime`.`registration`.`uat_status_id` = 'UAT_STATUS_COMPLETED') and
       (`itime`.`registration`.`date_creation` like '2017%'))
order by `Group_Name`,`Application_Name`,`Release_Name`,`itime`.`registration`.`registration_id`,`itime`.`application_object`.`application_object_id`,`itime`.`application_object_detail`.`application_object_detail_id` desc,`itime`.`object_history`.`object_history_id` desc,`itime`.`deploy_log`.`deploy_log_id` desc;

create or replace view testsatu as select `itime`.`application_object`.`application_object_id`                                                    AS `application_object_id`,
       `itime`.`registration`.`date_creation`                                                                  AS `Registration_Created_Date`,
       (select `itime`.`application_group`.`name`
        from ((`itime`.`application_release` join `itime`.`application` on ((
            `itime`.`application_release`.`application_id` = `itime`.`application`.`application_id`)))
               join `itime`.`application_group` on ((`itime`.`application`.`application_group_id` =
                                                     `itime`.`application_group`.`application_group_id`)))
        where (`itime`.`application_release`.`application_release_id` =
               `itime`.`registration`.`application_release_id`))                                               AS `Group_Name`,
       (select `itime`.`application`.`name`
        from (`itime`.`application_release`
               join `itime`.`application`
                    on ((`itime`.`application_release`.`application_id` = `itime`.`application`.`application_id`)))
        where (`itime`.`application_release`.`application_release_id` =
               `itime`.`registration`.`application_release_id`))                                               AS `Application_Name`,
       (select `itime`.`application_release`.`name`
        from `itime`.`application_release`
        where (`itime`.`application_release`.`application_release_id` =
               `itime`.`registration`.`application_release_id`))                                               AS `Release_Name`,
       (select `rp`.`name`
        from `itime`.`remys_project` `rp`
        where (`rp`.`remys_project_id` = `itime`.`registration`.`remys_project_id`))                           AS `Project_Name`,
       `itime`.`object_task`.`task_name`                                                                       AS `Task_Name`,
       `itime`.`application_object`.`object_name`                                                              AS `Object_Name`,
       `itime`.`registration`.`dokumen_nota_migrasi_file_name`                                                 AS `Nomor_Nota`,
       `itime`.`registration`.`tanggal_nota_migrasi`                                                           AS `Tangga_Nota`,
       `itime`.`registration`.`sit_status_id`                                                                  AS `SIT_Status`,
       `itime`.`registration`.`uat_status_id`                                                                  AS `UAT_Status`,
       `itime`.`registration`.`promote_status_id`                                                              AS `Promote_Status`,
       `itime`.`registration`.`live_status_id`                                                                 AS `Live_Status`,
       `itime`.`object_history`.`action_date`                                                                  AS `Action_User`,
       (select `itime`.`common_code`.`value`
        from `itime`.`common_code`
        where (`itime`.`common_code`.`property` =
               convert(`itime`.`object_history`.`action_code` using utf8)))                                    AS `Action_Code`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` =
               `itime`.`object_history`.`from_environment_id`))                                                AS `From_Environment`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` =
               `itime`.`object_history`.`to_environment_id`))                                                  AS `To_Environment`,
       (select `itime`.`user_detail`.`login_id`
        from `itime`.`user_detail`
        where (`itime`.`user_detail`.`user_detail_id` =
               `itime`.`object_history`.`action_user`))                                                        AS `Action_by_User`,
       `itime`.`deploy_log`.`created_on`                                                                       AS `Deploy_Log_Date`,
       (select `itime`.`target`.`host`
        from `itime`.`target`
        where (`itime`.`target`.`target_id` = `itime`.`deploy_log`.`target_id`))                               AS `Target_Host`,
       (select `itime`.`target`.`path`
        from `itime`.`target`
        where (`itime`.`target`.`target_id` = `itime`.`deploy_log`.`target_id`))                               AS `Target_Path`,
       `itime`.`deploy_log`.`request`                                                                          AS `Request`,
       `itime`.`deploy_log`.`response`                                                                         AS `Response`
from ((((((`itime`.`registration` join `itime`.`object_task` on ((`itime`.`registration`.`registration_id` =
                                                                  `itime`.`object_task`.`registration_id`))) join `itime`.`application_object_task` on ((
    `itime`.`object_task`.`object_task_id` =
    `itime`.`application_object_task`.`object_task_id`))) join `itime`.`application_object` on ((
    `itime`.`application_object_task`.`application_object_id` =
    `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_detail` on ((
    `itime`.`application_object`.`application_object_id` =
    `itime`.`application_object_detail`.`application_object_id`))) join `itime`.`object_history` on ((
    `itime`.`application_object_detail`.`application_object_detail_id` =
    `itime`.`object_history`.`application_object_detail_id`)))
       left join `itime`.`deploy_log`
                 on ((`itime`.`object_history`.`deployment_set_id` = `itime`.`deploy_log`.`deployment_set_id`)))
where ((`itime`.`registration`.`uat_status_id` = 'UAT_STATUS_COMPLETED') and
       (`itime`.`registration`.`date_creation` like '2016%'))
order by `Group_Name`,`Application_Name`,`Release_Name`,`itime`.`registration`.`registration_id`,`itime`.`application_object`.`application_object_id`,`itime`.`application_object_detail`.`application_object_detail_id` desc,`itime`.`object_history`.`object_history_id` desc,`itime`.`deploy_log`.`deploy_log_id` desc;

create or replace view uat_lead as select distinct `user`.`user_detail_id`            AS `id`,
                `itime`.`employee`.`nip`           AS `nik`,
                `itime`.`employee`.`employee_name` AS `name`,
                `user`.`email`                     AS `email`,
                `user`.`login_id`                  AS `login_id`,
                `itime`.`employee`.`title`         AS `jabatan`,
                `itime`.`employee`.`wa_number`     AS `wa_number`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

create or replace view user_roles as select uuid() AS `id`,`itime`.`role`.`name` AS `roles_name`,`users`.`login_id` AS `users_login_id`
from ((`itime`.`user_detail` `users` join `itime`.`user_detail_role` on ((`users`.`user_detail_id` = `itime`.`user_detail_role`.`user_detail_id`)))
       join `itime`.`role` on ((`itime`.`user_detail_role`.`role_id` = `itime`.`role`.`role_id`)));

create or replace view very_new_remys_report as select `oh`.`action_date`                                                                  AS `Date_Time`,
       `oh`.`comment`                                                                      AS `Comment`,
       (select `itime`.`common_code`.`value`
        from `itime`.`common_code`
        where (`itime`.`common_code`.`property` = convert(`oh`.`action_code` using utf8))) AS `Action_Code`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` = `oh`.`from_environment_id`))       AS `From_Staging`,
       (select `itime`.`environment`.`name`
        from `itime`.`environment`
        where (`itime`.`environment`.`environment_id` = `oh`.`to_environment_id`))         AS `To_Staging`,
       (select lpad(`oh`.`deployment_set_id`, 8, 0))                                       AS `Deployment_Set`,
       (select group_concat(`itime`.`object_task`.`task_name` separator ', ')
        from (((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_task` on ((
            `itime`.`application_object`.`application_object_id` =
            `itime`.`application_object_task`.`application_object_id`)))
               join `itime`.`object_task`
                    on ((`itime`.`application_object_task`.`object_task_id` = `itime`.`object_task`.`object_task_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Task_Name`,
       (select group_concat(`itime`.`remys_project`.`name` separator ', ')
        from (((((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_task` on ((
            `itime`.`application_object`.`application_object_id` =
            `itime`.`application_object_task`.`application_object_id`))) join `itime`.`object_task` on ((
            `itime`.`application_object_task`.`object_task_id` =
            `itime`.`object_task`.`object_task_id`))) join `itime`.`registration` on ((
            `itime`.`object_task`.`registration_id` = `itime`.`registration`.`registration_id`)))
               join `itime`.`remys_project`
                    on ((`itime`.`registration`.`remys_project_id` = `itime`.`remys_project`.`remys_project_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Project_Code`,
       (select group_concat(`itime`.`registration`.`remys_project_description` separator ', ')
        from (((((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_object_task` on ((
            `itime`.`application_object`.`application_object_id` =
            `itime`.`application_object_task`.`application_object_id`))) join `itime`.`object_task` on ((
            `itime`.`application_object_task`.`object_task_id` =
            `itime`.`object_task`.`object_task_id`))) join `itime`.`registration` on ((
            `itime`.`object_task`.`registration_id` = `itime`.`registration`.`registration_id`)))
               join `itime`.`remys_project`
                    on ((`itime`.`registration`.`remys_project_id` = `itime`.`remys_project`.`remys_project_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Description`,
       (select `itime`.`application_object`.`object_name`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Name`,
       (select `itime`.`application_object`.`object_type`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Type`,
       (select `itime`.`application_object_detail`.`size`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Object_Size`,
       (select `itime`.`application_object_detail`.`created_date`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Load_Date`,
       (select `itime`.`application_object_detail`.`modified_date`
        from (`itime`.`application_object_detail`
               join `itime`.`application_object` on ((`itime`.`application_object_detail`.`application_object_id` =
                                                      `itime`.`application_object`.`application_object_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Modified_Date`,
       (select lpad(`itime`.`application_object_detail`.`load_version`, 4, 0)
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Load_Version`,
       (select lpad(`itime`.`application_object_detail`.`crc_version`, 4, 0)
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `CRC_Version`,
       (select `itime`.`application_object_detail`.`crc`
        from `itime`.`application_object_detail`
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `CRC`,
       (select `itime`.`application`.`name`
        from (((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`))) join `itime`.`application_release` on ((
            `itime`.`application_object`.`application_release_id` =
            `itime`.`application_release`.`application_release_id`)))
               join `itime`.`application`
                    on ((`itime`.`application_release`.`application_id` = `itime`.`application`.`application_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Application_Name`,
       (select `itime`.`application_release`.`display_name`
        from ((`itime`.`application_object_detail` join `itime`.`application_object` on ((
            `itime`.`application_object_detail`.`application_object_id` =
            `itime`.`application_object`.`application_object_id`)))
               join `itime`.`application_release` on ((`itime`.`application_object`.`application_release_id` =
                                                       `itime`.`application_release`.`application_release_id`)))
        where (`itime`.`application_object_detail`.`application_object_detail_id` =
               `oh`.`application_object_detail_id`))                                       AS `Release_Name`,
       (select `itime`.`user_detail`.`login_id`
        from `itime`.`user_detail`
        where (`itime`.`user_detail`.`user_detail_id` = `oh`.`action_user`))               AS `Login_Id`
from `itime`.`object_history` `oh`
order by `oh`.`application_object_detail_id`,`oh`.`object_history_id`;

create or replace view view_employee_group as select `itime`.`employee_group`.`employee_group_id` AS `employee_group_id`,
       `itime`.`employee_group`.`direktorat`        AS `direktorat`,
       `itime`.`employee_group`.`direktorat_name`   AS `direktorat_name`,
       `itime`.`employee_group`.`group_head`        AS `group_head`,
       `itime`.`employee_group`.`group_name`        AS `group_name`,
       `itime`.`employee_group`.`remark`            AS `remark`,
       `itime`.`employee_group`.`short_group_name`  AS `short_group_name`,
       `itime`.`employee_group`.`sub_dir`           AS `sub_dir`,
       `itime`.`employee_group`.`sub_dir_name`      AS `sub_dir_name`
from `itime`.`employee_group`;

create or replace view view_project_application_users as select `project`.`id`                           AS `id`,
       `project`.`view_user_pic_application_id` AS `users`,
       `project`.`view_user_tpm_id`             AS `tpm`
from `itime`.`project_application_users` `project`;

create or replace view view_test_script_new as select `tsn`.`id`                      AS `id`,
       `tsn`.`test_script_date`        AS `test_script_date`,
       `tsn`.`assignment_date`         AS `assignment_date`,
       `tsn`.`test_script_number`      AS `test_script_number`,
       `tsn`.`test_script_total`       AS `test_script_total`,
       `tsn`.`capacity_total`          AS `capacity_total`,
       `tsn`.`nik`                     AS `nik`,
       `tsn`.`submit_by`               AS `submit_by`,
       `tsn`.`note`                    AS `note`,
       `tsn`.`status_approval_id`      AS `status_approval_id`,
       `tsn`.`work_status_id`          AS `work_status_id`,
       `tsn`.`registration_general_id` AS `registration_general_id`
from `itime`.`view_test_script_new_from` `tsn`;

create or replace view view_test_script_new_from as select `tsn`.`id`                      AS `id`,
       `tsn`.`test_script_date`        AS `test_script_date`,
       `tsn`.`assignment_date`         AS `assignment_date`,
       `tsn`.`test_script_number`      AS `test_script_number`,
       `tsn`.`test_script_total`       AS `test_script_total`,
       `tsn`.`capacity_total`          AS `capacity_total`,
       `tsn`.`nik`                     AS `nik`,
       `tsn`.`submit_by`               AS `submit_by`,
       `tsn`.`note`                    AS `note`,
       `tsn`.`status_approval_id`      AS `status_approval_id`,
       `tsn`.`work_status_id`          AS `work_status_id`,
       `tsn`.`registration_general_id` AS `registration_general_id`
from (`itime`.`test_script_new` `tsn`
       join `itime`.`view_test_script_new_from_from` `tsn2` on ((`tsn2`.`id` = `tsn`.`id`)));

create or replace view view_test_script_new_from_from as select max(`itime`.`test_script_new`.`id`)          AS `id`,
       `itime`.`test_script_new`.`test_script_date` AS `test_script_date`
from `itime`.`test_script_new`
group by `itime`.`test_script_new`.`test_script_date`;

create or replace view view_test_team_structure as select row_count()                    AS `ID`,
       `rb`.`registration_general_id` AS `id_registration_general`,
       `jt`.`description`             AS `job_title`,
       `jc`.`description`             AS `job_description`,
       count(0)                       AS `count_resource_numbers`
from ((((`itime`.`resource_book` `rb` join `itime`.`resource_employee` `re` on ((`rb`.`resource_employee_id` = `re`.`id`))) join `itime`.`job` `j` on ((`re`.`job_id` = `j`.`id`))) join `itime`.`job_title` `jt` on ((`j`.`job_title_id` = `jt`.`id`)))
       join `itime`.`job_category` `jc` on ((`j`.`job_category_id` = `jc`.`id`)))
group by `id_registration_general`,`job_title`,`job_description`;

create or replace view view_user_environment as select distinct `user`.`user_detail_id`            AS `id`,
                `itime`.`employee`.`nip`           AS `nik`,
                `itime`.`employee`.`employee_name` AS `nama`,
                `user`.`email`                     AS `email`,
                `user`.`login_id`                  AS `login_id`,
                `itime`.`employee`.`title`         AS `jabatan`,
                `itime`.`employee`.`wa_number`     AS `wa_number`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

create or replace view view_user_environment_power as select distinct `user`.`user_detail_id`            AS `id`,
                `itime`.`employee`.`nip`           AS `nik`,
                `itime`.`employee`.`employee_name` AS `nama`,
                `user`.`email`                     AS `email`,
                `user`.`login_id`                  AS `login_id`,
                `itime`.`employee`.`title`         AS `jabatan`,
                `itime`.`employee`.`wa_number`     AS `wa_number`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

create or replace view view_user_pic_application as select distinct `itime`.`user_detail`.`user_detail_id`                                                AS `id`,
                `itime`.`user_detail`.`email`                                                         AS `email`,
                `itime`.`user_detail`.`login_id`                                                      AS `login_id`,
                (case when (`itime`.`user_detail`.`user_status` = 'USRACT') then TRUE else FALSE end) AS `is_enabled`,
                `itime`.`user_detail`.`name`                                                          AS `nama`,
                `itime`.`user_detail`.`title`                                                         AS `jabatan`,
                `itime`.`employee`.`wa_number`                                                        AS `wa_number`
from (((`itime`.`user_detail` left join `itime`.`user_detail_role` on ((`itime`.`user_detail`.`user_detail_id` =
                                                                        `itime`.`user_detail_role`.`user_detail_id`))) left join `itime`.`role` on ((`itime`.`user_detail_role`.`role_id` = `itime`.`role`.`role_id`)))
       left join `itime`.`employee` on ((`itime`.`user_detail`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
where (`itime`.`role`.`name` = 'ROLE_USER');

create or replace view view_user_team_automation as select distinct `user`.`user_detail_id`            AS `id`,
                `itime`.`employee`.`nip`           AS `nik`,
                `itime`.`employee`.`employee_name` AS `nama`,
                `user`.`email`                     AS `email`,
                `user`.`login_id`                  AS `login_id`,
                `itime`.`employee`.`title`         AS `jabatan`,
                `itime`.`employee`.`wa_number`     AS `wa_number`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

create or replace view view_user_team_release as select distinct `user`.`user_detail_id`            AS `id`,
                `itime`.`employee`.`nip`           AS `nik`,
                `itime`.`employee`.`employee_name` AS `nama`,
                `user`.`email`                     AS `email`,
                `user`.`login_id`                  AS `login_id`,
                `itime`.`employee`.`title`         AS `jabatan`,
                `itime`.`employee`.`wa_number`     AS `wa_number`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

create or replace view view_user_tpm as select distinct `itime`.`user_detail`.`user_detail_id`                                                AS `id`,
                `itime`.`user_detail`.`email`                                                         AS `email`,
                `itime`.`user_detail`.`login_id`                                                      AS `login_id`,
                (case when (`itime`.`user_detail`.`user_status` = 'USRACT') then TRUE else FALSE end) AS `is_enabled`,
                `itime`.`user_detail`.`name`                                                          AS `nama`,
                `itime`.`user_detail`.`title`                                                         AS `jabatan`,
                `itime`.`employee`.`wa_number`                                                        AS `wa_number`
from (((`itime`.`user_detail` left join `itime`.`user_detail_role` on ((`itime`.`user_detail`.`user_detail_id` =
                                                                        `itime`.`user_detail_role`.`user_detail_id`))) left join `itime`.`role` on ((`itime`.`user_detail_role`.`role_id` = `itime`.`role`.`role_id`)))
       left join `itime`.`employee` on ((`itime`.`user_detail`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
where (`itime`.`role`.`name` = 'ROLE_TPM');

create or replace view view_user_tpm_admin as select distinct `user`.`user_detail_id`            AS `id`,
                `itime`.`employee`.`nip`           AS `nik`,
                `itime`.`employee`.`employee_name` AS `nama`,
                `user`.`email`                     AS `email`,
                `user`.`login_id`                  AS `login_id`,
                `itime`.`employee`.`title`         AS `jabatan`,
                `itime`.`employee`.`wa_number`     AS `wa_number`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

create or replace view view_user_tpm_lead as select distinct `user`.`user_detail_id`            AS `id`,
                `itime`.`employee`.`nip`           AS `nik`,
                `itime`.`employee`.`employee_name` AS `nama`,
                `user`.`email`                     AS `email`,
                `user`.`login_id`                  AS `login_id`,
                `itime`.`employee`.`title`         AS `jabatan`,
                `itime`.`employee`.`wa_number`     AS `wa_number`
from ((`itime`.`user_detail` `user` left join `itime`.`employee` on ((`user`.`user_detail_id` = `itime`.`employee`.`user_detail_id`)))
       left join `itime`.`employee_group`
                 on ((`itime`.`employee`.`employee_group_id` = `itime`.`employee_group`.`employee_group_id`)));

