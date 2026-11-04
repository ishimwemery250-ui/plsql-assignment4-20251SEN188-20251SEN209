CREATE OR REPLACE PROCEDURE enroll_student (
 p_student_id IN NUMBER, p_course_id IN NUMBER, p_enrollment_id OUT NUMBER
) AS
 TYPE t_enrollment_info IS RECORD (student_name students.full_name%TYPE, course_title courses.title%TYPE);
 v_info t_enrollment_info;
 v_capacity courses.capacity%TYPE;
 v_taken NUMBER;
 v_status students.status%TYPE;
 e_course_full EXCEPTION;
BEGIN
 SELECT full_name,status INTO v_info.student_name,v_status FROM students WHERE student_id=p_student_id;
 IF v_status <> 'ACTIVE' THEN RAISE_APPLICATION_ERROR(-20010,'Inactive student cannot enroll'); END IF;
 SELECT title,capacity INTO v_info.course_title,v_capacity FROM courses WHERE course_id=p_course_id FOR UPDATE;
 SELECT COUNT(*) INTO v_taken FROM enrollments WHERE course_id=p_course_id;
 IF v_taken >= v_capacity THEN RAISE e_course_full; END IF;
 INSERT INTO enrollments(student_id,course_id) VALUES(p_student_id,p_course_id)
 RETURNING enrollment_id INTO p_enrollment_id;
 DBMS_OUTPUT.PUT_LINE(v_info.student_name||' enrolled in '||v_info.course_title);
EXCEPTION
 WHEN e_course_full THEN RAISE_APPLICATION_ERROR(-20011,'Course is full');
 WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20012,'Student or course does not exist');
 WHEN DUP_VAL_ON_INDEX THEN RAISE_APPLICATION_ERROR(-20013,'Student already enrolled in this course');
END enroll_student;
/
