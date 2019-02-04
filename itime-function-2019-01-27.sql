create procedure check_emp_offdays(IN p_employee_id int, IN p_check_date date)
proc_label: BEGIN
    DECLARE valid_message VARCHAR(255);
    DECLARE iCount INT;

    
    SET valid_message = 'invalid';

    
    SELECT COUNT(id) INTO iCount
    FROM absence_submission
    WHERE resource_employee_id = p_employee_id
      AND p_check_date >= start_date
      AND p_check_date <= end_date;

    IF iCount > 0
    THEN
      SET valid_message = 'Employee sedang mengambil cuti/leave untuk tanggal ini';
    ELSE

      SELECT COUNT(id) INTO iCount FROM work_off_days WHERE p_check_date = date;
      
      IF iCount > 0
      THEN
        SET valid_message = 'Tanggal ini adalah tanggal off-days';
      ELSE
        SET valid_message = 'valid';
      END IF;
    END IF;

    
    SELECT valid_message;
  END;

create procedure get_emp_availability_day(IN p_resource_employee_id int, IN p_start_date date, IN p_end_date date, IN p_show_result bit, IN p_uid decimal(13,3))
BEGIN
    DECLARE uid_gen DECIMAL(13,3);
    DECLARE v_finished INTEGER DEFAULT 0;
    DECLARE v_tanggal VARCHAR(10);
    DECLARE availability_desc, t_date_name, t_aval_name VARCHAR(50);
    DECLARE tanggal_cursor CURSOR FOR
        SELECT cur_date
        FROM
            (SELECT ADDDATE('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) cur_date FROM
                (SELECT 0 t0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
                (SELECT 0 t1 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
                (SELECT 0 t2 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
                (SELECT 0 t3 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
                (SELECT 0 t4 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4
            ) v
        WHERE cur_date BETWEEN p_start_date AND p_end_date;


    IF p_show_result = 1 THEN
        SET uid_gen = UNIX_TIMESTAMP(CURTIME(3));
    ELSE
        SET uid_gen = p_uid;
    END IF;

    
    OPEN tanggal_cursor;
    BEGIN
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
        REPEAT
            FETCH tanggal_cursor INTO v_tanggal;
            
            IF v_finished = 0 THEN
                SET availability_desc = '';
                
                IF (SELECT COUNT(id) FROM work_off_days WHERE v_tanggal = date) > 0 THEN
                    SELECT description INTO availability_desc FROM work_off_days WHERE v_tanggal = date;
                END IF;
                
                IF (
                        SELECT COUNT(id) FROM absence_submission WHERE
                        approval_status IN (11, 10) AND 
                        resource_employee_id = p_resource_employee_id AND
                        (v_tanggal >= start_date AND v_tanggal <= end_date)
                    ) > 0
                THEN
                    SELECT
                        IFNULL(LR.description, '') INTO availability_desc
                    FROM
                        absence_submission AS ASU LEFT JOIN leave_reason AS LR ON LR.id = ASU.leave_reason_id
                    WHERE
                        approval_status IN (11, 10) AND 
                        ASU.resource_employee_id = p_resource_employee_id AND
                        (v_tanggal >= ASU.start_date AND v_tanggal <= ASU.end_date);
                END IF;

                INSERT INTO leave_reason_proc (id, resource_employee_id, date, availability)
                VALUES (uid_gen, p_resource_employee_id, v_tanggal, availability_desc);
            END IF;
        UNTIL v_finished = 1 END REPEAT;
    END;
    CLOSE tanggal_cursor;
    
    IF p_show_result = 1 THEN
        SELECT resource_employee_id, date, availability FROM leave_reason_proc WHERE id = uid_gen;
        DELETE FROM leave_reason_proc WHERE id IN (uid_gen);
    END IF;
END;

create procedure get_emp_availability_day_all(IN p_start_date date, IN p_end_date date)
BEGIN
    DECLARE uid_gen DECIMAL(13,3);
    DECLARE v_finished INTEGER DEFAULT 0;
    DECLARE v_emp_id INT;
    DECLARE emp_id_cursor CURSOR FOR SELECT DISTINCT
    (id)
FROM resource_employee;

    SET uid_gen = UNIX_TIMESTAMP(CURTIME(3));

    OPEN emp_id_cursor;

    BEGIN

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

        REPEAT
            FETCH emp_id_cursor INTO v_emp_id;

            
            IF v_finished = 0 THEN
CALL get_emp_availability_day(v_emp_id, p_start_date, p_end_date, 0, uid_gen);
END IF;
UNTIL v_finished = 1 END REPEAT;
END;
    CLOSE emp_id_cursor;

SELECT
    resource_employee_id,
    date,
    availability
FROM leave_reason_proc
WHERE id = uid_gen;
DELETE
    FROM leave_reason_proc
WHERE id IN (uid_gen);
END;

create procedure get_leave_cut_year(IN p_employee_id int, IN p_available_dayleave int, IN p_propose_dayleave int, IN p_cur_year int, IN p_is_approved int, OUT out_status_message varchar(255))
BEGIN
    DECLARE
        cur_yearly_tolerance_days
        , yearly_leave_prev2
        , yearly_leave_prev1
        , yearly_leave_cur
        , diff_leave_day 
    INT;



SELECT
    SUM(LR.tolerance_days) INTO cur_yearly_tolerance_days
FROM resource_employee_vendor AS REV
    INNER JOIN leave_reason AS LR
        ON REV.vendor_id = LR.vendor_id
WHERE REV.resource_employee_id = p_employee_id
AND LR.cut_year_period = 1
AND LR.periodicity = 2;
 



    
    SET yearly_leave_prev2 = 0;
    SET yearly_leave_prev1 = 0;
    SET yearly_leave_cur = 0;
    SET diff_leave_day = p_propose_dayleave - p_available_dayleave;
    SET out_status_message = 'valid';

SELECT
    quota_left INTO yearly_leave_prev2
FROM resource_employee_leave
WHERE resource_employee_id = p_employee_id
AND year = p_cur_year - 2;

SELECT
    quota_left INTO yearly_leave_prev1
FROM resource_employee_leave
WHERE resource_employee_id = p_employee_id
AND year = p_cur_year - 1;
    
    IF ( SELECT
        COUNT(id)
    FROM resource_employee_leave
    WHERE resource_employee_id = p_employee_id
    AND year = p_cur_year) = 0 THEN
INSERT INTO resource_employee_leave (resource_employee_id, year, quota_left)
    VALUES (p_employee_id, p_cur_year, cur_yearly_tolerance_days);
END IF;
SELECT
    quota_left INTO yearly_leave_cur
FROM resource_employee_leave
WHERE resource_employee_id = p_employee_id
AND year = p_cur_year;



    IF diff_leave_day > 0 THEN

        IF yearly_leave_prev2 >= diff_leave_day THEN 

            IF p_is_approved = 1 THEN
UPDATE resource_employee_leave
SET quota_left = quota_left - diff_leave_day
WHERE resource_employee_id = p_employee_id
AND year = p_cur_year - 2;
END IF;

ELSE

            
            SET diff_leave_day = diff_leave_day - yearly_leave_prev2;
            
            IF p_is_approved = 1 THEN
UPDATE resource_employee_leave
SET quota_left = 0
WHERE resource_employee_id = p_employee_id
AND year = p_cur_year - 2;
END IF;


            IF yearly_leave_prev1 >= diff_leave_day THEN

                IF p_is_approved = 1 THEN
UPDATE resource_employee_leave
SET quota_left = quota_left - diff_leave_day
WHERE resource_employee_id = p_employee_id
AND year = p_cur_year - 1;
END IF;

ELSE
                SET diff_leave_day = diff_leave_day - yearly_leave_prev1;

                IF p_is_approved = 1 THEN
UPDATE resource_employee_leave
SET quota_left = 0
WHERE resource_employee_id = p_employee_id
AND year = p_cur_year - 1;
END IF;


                IF yearly_leave_cur >= diff_leave_day THEN
                    IF p_is_approved = 1 THEN
UPDATE resource_employee_leave
SET quota_left = quota_left - diff_leave_day
WHERE resource_employee_id = p_employee_id
AND year = p_cur_year;
END IF;

ELSE
                    SET out_status_message = 'invalid - jatah cuti dan tahunan sudah tidak mencukupi (cut-year)';

                END IF;
 

            END IF;
 

        END IF;
 

    END IF;

END;

create procedure get_leave_propose_available(IN p_employee_id int, IN p_leave_reason_id int, IN p_leave_start_date date, IN p_leave_end_date date, IN p_tolerance_days int, IN p_cut_off_month_status int, OUT out_total_dayleave_propose int, OUT out_available_dayleave_left int)
BEGIN
    DECLARE
        total_dayleave_propose, 
        available_dayleave_left,
        count_submission
    INT;

    DECLARE
        month_first_date,
        month_last_date
    DATE;

    SET month_last_date = LAST_DAY(p_leave_start_date);
    SET month_first_date = DATE_ADD(DATE_ADD(LAST_DAY(p_leave_end_date), INTERVAL 1 DAY), INTERVAL - 1 MONTH);



SELECT
    CASE WHEN p_cut_off_month_status = 0 THEN (
                DATEDIFF(p_leave_end_date, p_leave_start_date) + 1
                -
                IFNULL((SELECT
                        COUNT(id)
                    FROM work_off_days
                    WHERE date >= p_leave_start_date
                    AND date <= p_leave_end_date), 0)
                ) WHEN p_cut_off_month_status = 1 THEN (
                DATEDIFF(month_last_date, p_leave_start_date) + 1
                -
                IFNULL((SELECT
                        COUNT(id)
                    FROM work_off_days
                    WHERE date >= p_leave_start_date
                    AND date <= month_last_date), 0)
                ) WHEN p_cut_off_month_status = 2 THEN (
                DATEDIFF(p_leave_end_date, month_first_date) + 1
                -
                IFNULL((SELECT
                        COUNT(id)
                    FROM work_off_days
                    WHERE date >= month_first_date
                    AND date <= p_leave_end_date), 0)
                ) END INTO total_dayleave_propose;




SELECT
    COUNT(ASU.id) INTO count_submission
FROM absence_submission AS ASU
WHERE

ASU.leave_reason_id = p_leave_reason_id
AND ASU.resource_employee_id = p_employee_id
AND CASE p_cut_off_month_status WHEN 0 THEN MONTH(ASU.start_date) = MONTH(p_leave_start_date) WHEN 1 THEN MONTH(ASU.start_date) = MONTH(p_leave_start_date) WHEN 2 THEN MONTH(ASU.end_date) = MONTH(p_leave_end_date) ELSE 1 = 1 END;


    
    IF (count_submission = 0) THEN
        SET available_dayleave_left = p_tolerance_days;
    ELSE
SELECT
    CASE WHEN p_cut_off_month_status = 0 THEN p_tolerance_days -
                (
                SUM(DATEDIFF(ASU.end_date, ASU.start_date) + 1)
                -
                SUM((SELECT
                        COUNT(id)
                    FROM work_off_days
                    WHERE date >= ASU.start_date
                    AND date <= ASU.end_date))
                ) WHEN p_cut_off_month_status = 1 THEN p_tolerance_days -
                (
                SUM(DATEDIFF(LAST_DAY(ASU.start_date), ASU.start_date) + 1)
                -
                SUM((SELECT
                        COUNT(id)
                    FROM work_off_days
                    WHERE date >= ASU.start_date
                    AND date <= LAST_DAY(ASU.start_date)))
                ) WHEN p_cut_off_month_status = 2 THEN p_tolerance_days -
                (
                SUM(DATEDIFF(ASU.end_date, DATE_ADD(DATE_ADD(LAST_DAY(ASU.end_date), INTERVAL 1 DAY), INTERVAL -1 MONTH)) + 1)
                -
                SUM((SELECT
                        COUNT(id)
                    FROM work_off_days
                    WHERE date >= DATE_ADD(DATE_ADD(LAST_DAY(ASU.end_date), INTERVAL 1 DAY), INTERVAL -1 MONTH)
                    AND date <= ASU.end_date))
                ) END INTO available_dayleave_left
FROM absence_submission AS ASU
WHERE

ASU.leave_reason_id = p_leave_reason_id
AND ASU.resource_employee_id = p_employee_id
AND CASE p_cut_off_month_status WHEN 0 THEN MONTH(ASU.start_date) = MONTH(p_leave_start_date) WHEN 1 THEN MONTH(ASU.start_date) = MONTH(p_leave_start_date) WHEN 2 THEN MONTH(ASU.end_date) = MONTH(p_leave_end_date) ELSE 1 = 1 END;
END IF;

    SET out_total_dayleave_propose = total_dayleave_propose;
    SET out_available_dayleave_left = available_dayleave_left;
    
END;

create procedure is_leave_valid(IN p_employee_id int, IN p_leave_reason_id int, IN p_leave_start_date date, IN p_leave_end_date date, IN p_is_approved int)
proc_label:BEGIN
    DECLARE is_approved INT;
 
    DECLARE
        cur_periodicity 
        , total_dayleave_propose 
        , available_dayleave_left 
        , count_submission 
        , tolerance_days 
        , p_cut_off_month_status 
    INT;

    DECLARE
        month_first_date,
        month_last_date
    DATE;
    DECLARE
        is_cut_year_period
    BIT;
    DECLARE
        valid_message,
        cut_year_message
    VARCHAR(255);


    
    SET valid_message = 'invalid';

    SET is_approved = p_is_approved;
 




    
    IF DATEDIFF(p_leave_end_date, p_leave_start_date) < 0 THEN
        SET valid_message = 'invalid (tgl awal harus lebih kecil dari tgl akhir)';
SELECT
    valid_message;
        LEAVE proc_label;
    END IF;




SELECT
    LR.periodicity,
    IFNULL(LR.cut_year_period, 0),
    LR.tolerance_days INTO cur_periodicity,
is_cut_year_period,
tolerance_days
FROM resource_employee_vendor AS REV
    INNER JOIN leave_reason AS LR
        ON REV.vendor_id = LR.vendor_id
WHERE LR.id = p_leave_reason_id
AND REV.resource_employee_id = p_employee_id;



    
    
    
    IF cur_periodicity = 1 THEN

        
        IF MONTH(p_leave_start_date) = MONTH(p_leave_end_date) THEN

            SET p_cut_off_month_status = 0;
CALL get_leave_propose_available(p_employee_id,
p_leave_reason_id,
p_leave_start_date,
p_leave_end_date,
tolerance_days,
p_cut_off_month_status,
total_dayleave_propose,
available_dayleave_left);

            IF (is_cut_year_period = 1 AND total_dayleave_propose > available_dayleave_left) THEN

CALL get_leave_cut_year(p_employee_id,
available_dayleave_left,
total_dayleave_propose,
YEAR(p_leave_start_date),
is_approved,
cut_year_message);
                SET valid_message = cut_year_message;

            ELSE 

                IF available_dayleave_left < 0 THEN
                    SET valid_message = '1. invalid (jatah cuti/leave untuk bulan ini tidak mencukupi)';
                    SET available_dayleave_left = 0;
                ELSE
                    IF total_dayleave_propose > available_dayleave_left THEN
                        SET valid_message = '2. invalid (cuti yang diajukan lebih besar dari sisa jatah cuti yang tersedia)';
                        SET available_dayleave_left = 0;
                    ELSE
                        SET valid_message = 'valid';
                    END IF;
                END IF;

            END IF;
 

        END IF;
 


        
        IF MONTH(p_leave_start_date) > MONTH(p_leave_end_date) THEN
            SET valid_message = '3. invalid (tgl awal harus lebih kecil dari tgl akhir)';
            LEAVE proc_label;
        END IF;


        
        IF MONTH(p_leave_end_date) > MONTH(p_leave_start_date) AND MONTH(p_leave_end_date) - MONTH(p_leave_start_date) = 1 THEN

            
            SET p_cut_off_month_status = 1;
CALL get_leave_propose_available(p_employee_id,
p_leave_reason_id,
p_leave_start_date,
p_leave_end_date,
tolerance_days,
p_cut_off_month_status,
total_dayleave_propose,
available_dayleave_left);

            IF (is_cut_year_period = 1 AND total_dayleave_propose > available_dayleave_left) THEN

CALL get_leave_cut_year(p_employee_id,
available_dayleave_left,
total_dayleave_propose,
YEAR(p_leave_start_date),
is_approved,
cut_year_message);
                SET valid_message = cut_year_message;


            ELSE 

                IF available_dayleave_left < 0 THEN
                    SET valid_message = '4. invalid (jatah cuti/leave untuk tgl awal bulan ini tidak mencukupi)';
                    SET available_dayleave_left = 0;
                ELSE
                    IF total_dayleave_propose > available_dayleave_left THEN
                        SET valid_message = '5. invalid (cuti yang diajukan lebih besar dari sisa jatah cuti yang tersedia untuk tgl awal)';
                        SET available_dayleave_left = 0;
                    ELSE
                        SET valid_message = 'valid';
                    END IF;
                END IF;

            END IF;
 



            
            IF valid_message = 'valid' THEN
                SET p_cut_off_month_status = 2;
CALL get_leave_propose_available(p_employee_id,
p_leave_reason_id,
p_leave_start_date,
p_leave_end_date,
tolerance_days,
p_cut_off_month_status,
total_dayleave_propose,
available_dayleave_left);

                IF (is_cut_year_period = 1 AND total_dayleave_propose > available_dayleave_left) THEN

CALL get_leave_cut_year(p_employee_id,
available_dayleave_left,
total_dayleave_propose,
YEAR(p_leave_start_date),
is_approved,
cut_year_message);
                    SET valid_message = cut_year_message;

                ELSE 

                    IF available_dayleave_left < 0 THEN
                        SET valid_message = '6. invalid (jatah cuti/leave untuk tgl akhir bulan ini tidak mencukupi)';
                        SET available_dayleave_left = 0;
                    ELSE
                        IF total_dayleave_propose > available_dayleave_left THEN
                            SET valid_message = '7. invalid (cuti yang diajukan lebih besar dari sisa jatah cuti yang tersedia untuk tgl akhir)';
                            SET available_dayleave_left = 0;
                        ELSE
                            SET valid_message = 'valid';
                        END IF;
                    END IF;

                END IF;

            END IF;
 

        END IF;
 

    END IF;
 





    
    
    
    IF cur_periodicity = 2 THEN

        IF YEAR(p_leave_start_date) = YEAR(p_leave_end_date) THEN

SELECT
    (
    DATEDIFF(p_leave_end_date, p_leave_start_date) + 1
    -
    IFNULL((SELECT
            COUNT(id)
        FROM work_off_days
        WHERE date >= p_leave_start_date
        AND date <= p_leave_end_date), 0)
    ) INTO total_dayleave_propose;



SELECT
    COUNT(ASU.id) INTO count_submission
FROM absence_submission AS ASU
WHERE

YEAR(ASU.start_date) = YEAR(p_leave_start_date)
AND ASU.leave_reason_id = p_leave_reason_id
AND ASU.resource_employee_id = p_employee_id;



                
                IF (count_submission = 0) THEN
                    SET available_dayleave_left = tolerance_days;
                ELSE
SELECT
    0 -
    (
    SUM(DATEDIFF(ASU.end_date, ASU.start_date) + 1)
    -
    SUM((SELECT
            COUNT(id)
        FROM work_off_days
        WHERE date >= ASU.start_date
        AND date <= ASU.end_date))
    ) INTO available_dayleave_left
FROM absence_submission AS ASU
WHERE

YEAR(ASU.start_date) = YEAR(p_leave_start_date)
AND ASU.leave_reason_id = p_leave_reason_id
AND ASU.resource_employee_id = p_employee_id;
END IF;

                

                IF available_dayleave_left < 0 THEN
                    SET valid_message = '8. invalid (jatah cuti/leave untuk tahun ini tidak mencukupi)';
                    SET available_dayleave_left = 0;
                ELSE
                    IF total_dayleave_propose > available_dayleave_left THEN
                        SET valid_message = '9. invalid (cuti yang diajukan lebih besar dari sisa jatah cuti yang tersedia)';
                        SET available_dayleave_left = 0;
                    ELSE
                        SET valid_message = 'valid';

                        
                        IF is_approved = 1 AND is_cut_year_period = 1 THEN
                            IF ( SELECT
        COUNT(id)
    FROM resource_employee_leave
    WHERE resource_employee_id = p_employee_id
    AND year = YEAR(p_leave_start_date)) = 0 THEN
INSERT INTO resource_employee_leave (resource_employee_id, year, quota_left)
    VALUES (p_employee_id, YEAR(p_leave_start_date), tolerance_days);
END IF;

UPDATE resource_employee_leave
SET quota_left = quota_left - total_dayleave_propose
WHERE resource_employee_id = p_employee_id
AND year = YEAR(p_leave_start_date);
END IF;

END IF;
END IF;

END IF; 

END IF;
 





    
    
    
    IF
        (YEAR(p_leave_end_date) > YEAR(p_leave_start_date) AND YEAR(p_leave_end_date) - YEAR(p_leave_start_date) = 1)
        AND
        (MONTH(p_leave_end_date) > MONTH(p_leave_start_date) AND MONTH(p_leave_end_date) - MONTH(p_leave_start_date) = 1)
    THEN

            
            SET p_cut_off_month_status = 1;
CALL get_leave_propose_available(p_employee_id,
p_leave_reason_id,
p_leave_start_date,
p_leave_end_date,
tolerance_days,
p_cut_off_month_status,
total_dayleave_propose,
available_dayleave_left);

            IF (is_cut_year_period = 1 AND total_dayleave_propose > available_dayleave_left) THEN

CALL get_leave_cut_year(p_employee_id,
available_dayleave_left,
total_dayleave_propose,
YEAR(p_leave_start_date),
is_approved,
cut_year_message);
                SET valid_message = cut_year_message;


            ELSE 

                IF available_dayleave_left < 0 THEN
                    SET valid_message = '10. invalid (jatah cuti/leave untuk tgl awal bulan ini tidak mencukupi)';
                    SET available_dayleave_left = 0;
                ELSE
                    IF total_dayleave_propose > available_dayleave_left THEN
                        SET valid_message = '11. invalid (cuti yang diajukan lebih besar dari sisa jatah cuti yang tersedia untuk tgl awal)';
                        SET available_dayleave_left = 0;
                    ELSE
                        SET valid_message = 'valid';
                    END IF;
                END IF;

            END IF;
 



            
            IF valid_message = 'valid' THEN
                SET p_cut_off_month_status = 2;
CALL get_leave_propose_available(p_employee_id,
p_leave_reason_id,
p_leave_start_date,
p_leave_end_date,
tolerance_days,
p_cut_off_month_status,
total_dayleave_propose,
available_dayleave_left);

                IF (is_cut_year_period = 1 AND total_dayleave_propose > available_dayleave_left) THEN

CALL get_leave_cut_year(p_employee_id,
available_dayleave_left,
total_dayleave_propose,
YEAR(p_leave_end_date), 
is_approved,
cut_year_message);
                    SET valid_message = cut_year_message;

                ELSE 

                    IF available_dayleave_left < 0 THEN
                        SET valid_message = '12. invalid (jatah cuti/leave untuk tgl akhir bulan ini tidak mencukupi)';
                        SET available_dayleave_left = 0;
                    ELSE
                        IF total_dayleave_propose > available_dayleave_left THEN
                            SET valid_message = '13. invalid (cuti yang diajukan lebih besar dari sisa jatah cuti yang tersedia untuk tgl akhir)';
                            SET available_dayleave_left = 0;
                        ELSE
                            SET valid_message = 'valid';
                        END IF;
                    END IF;

                END IF;

            END IF;
 


    END IF;




SELECT
    valid_message, total_dayleave_propose, available_dayleave_left;
END;

