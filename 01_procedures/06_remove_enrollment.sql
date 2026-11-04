CREATE OR REPLACE PROCEDURE remove_enrollment(p_student_id IN NUMBER,p_course_id IN NUMBER) AS
BEGIN
 DELETE FROM enrollments WHERE student_id=p_student_id AND course_id=p_course_id;
 IF SQL%ROWCOUNT=0 THEN
  RAISE_APPLICATION_ERROR(-20040,'No enrollment to delete');
 END IF;
 DBMS_OUTPUT.PUT_LINE('Deleted enrollments: '||SQL%ROWCOUNT);
END remove_enrollment;
/
