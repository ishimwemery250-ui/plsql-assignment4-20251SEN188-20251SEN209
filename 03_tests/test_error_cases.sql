SET SERVEROUTPUT ON SIZE UNLIMITED;
PROMPT EXPECTED ERRORS: each test catches and prints its own error
DECLARE
 v_id NUMBER; v_count NUMBER;
BEGIN
 BEGIN
  register_student('Duplicate','aline@example.org',v_id);
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected duplicate email: '||SQLERRM); END;
 BEGIN
  enroll_student(99999,10,v_id);
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected missing student: '||SQLERRM); END;
 BEGIN
  enroll_student(3,10,v_id);
  enroll_student(4,10,v_id);
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected full course: '||SQLERRM); END;
 BEGIN
  update_grade(3,20,105);
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected invalid grade: '||SQLERRM); END;
 BEGIN
  update_grade(99999,20,50);
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected absent enrollment: '||SQLERRM); END;
 BEGIN
  remove_enrollment(99999,20);
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected absent deletion: '||SQLERRM); END;
 BEGIN
  v_count:=get_course_enrollment_count(99999);
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected unknown course: '||SQLERRM); END;
 BEGIN
  DBMS_OUTPUT.PUT_LINE(get_student_email('Missing Name'));
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected NO_DATA_FOUND: '||SQLERRM); END;
 BEGIN
  bulk_grade_bonus(10,-2,v_count);
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected invalid bonus: '||SQLERRM); END;
 ROLLBACK;
END;
/
DECLARE
 v_new_id NUMBER; v_result VARCHAR2(150);
BEGIN
 register_student('Aline Uwase','duplicate.name@example.org',v_new_id);
 BEGIN
  v_result:=get_student_email('Aline Uwase');
 EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected TOO_MANY_ROWS: '||SQLERRM); END;
 ROLLBACK;
END;
/
