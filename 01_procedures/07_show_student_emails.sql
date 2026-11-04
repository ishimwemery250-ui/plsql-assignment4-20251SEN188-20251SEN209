CREATE OR REPLACE PROCEDURE show_student_emails AS
 TYPE t_emails IS TABLE OF students.email%TYPE INDEX BY PLS_INTEGER;
 v_emails t_emails;
BEGIN
 SELECT email BULK COLLECT INTO v_emails FROM students ORDER BY student_id;
 FOR i IN 1..v_emails.COUNT LOOP
  DBMS_OUTPUT.PUT_LINE('Email '||i||': '||v_emails(i));
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('Total emails: '||v_emails.COUNT);
END show_student_emails;
/
