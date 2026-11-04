CREATE OR REPLACE PROCEDURE update_grade (
 p_student_id IN NUMBER,p_course_id IN NUMBER,p_grade IN NUMBER
) AS
BEGIN
 IF p_grade IS NULL OR p_grade < 0 OR p_grade > 100 THEN
  RAISE_APPLICATION_ERROR(-20020,'Grade must be between 0 and 100');
 END IF;
 UPDATE enrollments SET grade=p_grade WHERE student_id=p_student_id AND course_id=p_course_id;
 IF SQL%NOTFOUND THEN RAISE_APPLICATION_ERROR(-20021,'Enrollment not found'); END IF;
 IF SQL%FOUND THEN DBMS_OUTPUT.PUT_LINE('Updated rows: '||SQL%ROWCOUNT); END IF;
END update_grade;
/
