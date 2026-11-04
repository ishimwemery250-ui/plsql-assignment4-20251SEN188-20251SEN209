CREATE OR REPLACE PROCEDURE bulk_grade_bonus (
 p_course_id IN NUMBER, p_bonus IN NUMBER, p_rows_updated OUT NUMBER
) AS
 TYPE t_enrollment_ids IS TABLE OF enrollments.enrollment_id%TYPE;
 TYPE t_grades IS TABLE OF enrollments.grade%TYPE;
 v_ids t_enrollment_ids;
 v_grades t_grades;
 v_course_id courses.course_id%TYPE;
 v_error_count NUMBER;
 e_bulk_errors EXCEPTION;
 PRAGMA EXCEPTION_INIT(e_bulk_errors,-24381);
BEGIN
 IF p_bonus IS NULL OR p_bonus < 0 OR p_bonus > 20 THEN
  RAISE_APPLICATION_ERROR(-20030,'Bonus must be between 0 and 20');
 END IF;
 SELECT course_id INTO v_course_id FROM courses WHERE course_id=p_course_id FOR UPDATE;
 SELECT enrollment_id,grade BULK COLLECT INTO v_ids,v_grades
 FROM enrollments WHERE course_id=p_course_id AND grade IS NOT NULL;
 p_rows_updated:=0;
 IF v_ids.COUNT=0 THEN
  DBMS_OUTPUT.PUT_LINE('No graded enrollments to update');
  RETURN;
 END IF;
 BEGIN
  FORALL i IN 1..v_ids.COUNT SAVE EXCEPTIONS
   UPDATE enrollments SET grade=LEAST(100,v_grades(i)+p_bonus)
   WHERE enrollment_id=v_ids(i);
  p_rows_updated:=SQL%ROWCOUNT;
 EXCEPTION
  WHEN e_bulk_errors THEN
   v_error_count:=SQL%BULK_EXCEPTIONS.COUNT;
   FOR j IN 1..v_error_count LOOP
    DBMS_OUTPUT.PUT_LINE('Bulk error at index '||SQL%BULK_EXCEPTIONS(j).ERROR_INDEX||
      ': ORA-'||SQL%BULK_EXCEPTIONS(j).ERROR_CODE);
   END LOOP;
   RAISE_APPLICATION_ERROR(-20031,'Bulk grade update failed for '||v_error_count||' row(s)');
 END;
 DBMS_OUTPUT.PUT_LINE('Bulk grades updated: '||p_rows_updated);
EXCEPTION
 WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20032,'Course does not exist');
END bulk_grade_bonus;
/
