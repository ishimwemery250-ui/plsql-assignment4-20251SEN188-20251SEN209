CREATE OR REPLACE FUNCTION get_student_average(p_student_id IN NUMBER) RETURN NUMBER AS
 v_exists NUMBER;
 v_average NUMBER;
BEGIN
 SELECT COUNT(*) INTO v_exists FROM students WHERE student_id=p_student_id;
 IF v_exists=0 THEN RAISE_APPLICATION_ERROR(-20050,'Student does not exist'); END IF;
 SELECT ROUND(AVG(grade),2) INTO v_average FROM enrollments WHERE student_id=p_student_id;
 RETURN v_average;
END get_student_average;
/
