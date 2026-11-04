SET SERVEROUTPUT ON SIZE UNLIMITED;
PROMPT SUCCESS TESTS
DECLARE
 v_student_id NUMBER; v_enrollment_id NUMBER; v_updated NUMBER;
BEGIN
 DBMS_OUTPUT.PUT_LINE('Initial course 10 count: '||get_course_enrollment_count(10));
 DBMS_OUTPUT.PUT_LINE('Aline average: '||get_student_average(1));
 DBMS_OUTPUT.PUT_LINE('Aline email: '||get_student_email('Aline Uwase'));
 register_student('Test Student','test.student@example.org',v_student_id);
 enroll_student(v_student_id,20,v_enrollment_id);
 update_grade(v_student_id,20,81);
 show_course_roster(20);
 show_student_emails;
 bulk_grade_bonus(20,5,v_updated);
 DBMS_OUTPUT.PUT_LINE('Bonus rows updated: '||v_updated);
 remove_enrollment(v_student_id,20);
 DBMS_OUTPUT.PUT_LINE('After deletion course 20 count: '||get_course_enrollment_count(20));
 ROLLBACK;
END;
/
PROMPT SELECT-BASED FUNCTION TEST
SELECT get_course_enrollment_count(10) AS course_10_enrollments FROM dual;
