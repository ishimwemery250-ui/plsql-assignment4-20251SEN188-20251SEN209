CREATE OR REPLACE PROCEDURE show_course_roster (p_course_id IN NUMBER) AS
 CURSOR c_roster IS
  SELECT s.full_name,e.grade FROM enrollments e JOIN students s ON s.student_id=e.student_id
  WHERE e.course_id=p_course_id ORDER BY s.full_name;
 v_name students.full_name%TYPE;
 v_grade enrollments.grade%TYPE;
 v_count NUMBER:=0;
BEGIN
 OPEN c_roster;
 LOOP
  FETCH c_roster INTO v_name,v_grade;
  EXIT WHEN c_roster%NOTFOUND;
  v_count:=v_count+1;
  DBMS_OUTPUT.PUT_LINE(v_name||' | Grade: '||NVL(TO_CHAR(v_grade),'Not graded'));
 END LOOP;
 CLOSE c_roster;
 DBMS_OUTPUT.PUT_LINE('Roster count: '||v_count);
EXCEPTION
 WHEN OTHERS THEN
  IF c_roster%ISOPEN THEN CLOSE c_roster; END IF;
  RAISE;
END show_course_roster;
/
