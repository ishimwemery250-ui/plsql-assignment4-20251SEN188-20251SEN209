CREATE OR REPLACE FUNCTION get_student_email(p_full_name IN VARCHAR2) RETURN VARCHAR2 AS
 v_email students.email%TYPE;
BEGIN
 SELECT email INTO v_email FROM students WHERE UPPER(full_name)=UPPER(p_full_name);
 RETURN v_email;
EXCEPTION
 WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20052,'No student with that name');
 WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20053,'More than one student has that name');
END get_student_email;
/
