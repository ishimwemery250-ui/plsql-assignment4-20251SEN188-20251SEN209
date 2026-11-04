CREATE OR REPLACE FUNCTION get_course_enrollment_count(p_course_id IN NUMBER) RETURN NUMBER AS
 v_exists NUMBER;
 v_count NUMBER;
BEGIN
 SELECT COUNT(*) INTO v_exists FROM courses WHERE course_id=p_course_id;
 IF v_exists=0 THEN RAISE_APPLICATION_ERROR(-20051,'Course does not exist'); END IF;
 SELECT COUNT(*) INTO v_count FROM enrollments WHERE course_id=p_course_id;
 RETURN v_count;
END get_course_enrollment_count;
/
