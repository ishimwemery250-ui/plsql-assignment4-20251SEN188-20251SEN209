CREATE OR REPLACE PROCEDURE register_student (
 p_full_name IN VARCHAR2, p_email IN VARCHAR2, p_student_id OUT NUMBER
) AS
 v_student students%ROWTYPE;
BEGIN
 IF TRIM(p_full_name) IS NULL OR TRIM(p_email) IS NULL THEN
  RAISE_APPLICATION_ERROR(-20001,'Name and email are required');
 END IF;
 INSERT INTO students(full_name,email) VALUES (TRIM(p_full_name),LOWER(TRIM(p_email)))
 RETURNING student_id INTO p_student_id;
 IF SQL%ROWCOUNT <> 1 THEN RAISE_APPLICATION_ERROR(-20002,'Student insert failed'); END IF;
 SELECT * INTO v_student FROM students WHERE student_id=p_student_id;
 DBMS_OUTPUT.PUT_LINE('Registered: '||v_student.full_name||' (ID '||v_student.student_id||')');
EXCEPTION
 WHEN DUP_VAL_ON_INDEX THEN RAISE_APPLICATION_ERROR(-20003,'Email already registered');
END register_student;
/
