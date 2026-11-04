SET SERVEROUTPUT ON;
SELECT table_name FROM user_tables WHERE table_name IN ('STUDENTS','COURSES','ENROLLMENTS') ORDER BY table_name;
SELECT object_name,object_type,status FROM user_objects WHERE object_type IN ('FUNCTION','PROCEDURE') ORDER BY object_type,object_name;
SELECT s.full_name,c.course_code,e.grade FROM enrollments e JOIN students s ON s.student_id=e.student_id JOIN courses c ON c.course_id=e.course_id ORDER BY e.enrollment_id;
