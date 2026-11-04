How we made the student system

We started with three tables because we need to know who the students are, what courses exist and which student takes a course. The enrollments table joins students and courses. We used primary keys to give each record an ID and foreign keys to connect the tables. We also added rules like unique emails and marks between 0 and 100.

Records

A record helps us keep information together. In register_student we used %ROWTYPE to hold one student's details. In enroll_student we made our own record for the student's name and the course name. This way we do not need a separate variable for every detail.

Collections

A collection is like a list of values. In show_student_emails we put emails into an associative array, then show each one. In bulk_grade_bonus we also use collections to keep enrollment IDs and grades.

Implicit cursors

Oracle handles an implicit cursor automatically when we insert, update or delete something. We used SQL%ROWCOUNT to see how many records changed. We used SQL%FOUND and SQL%NOTFOUND in update_grade to check if a student had an enrollment to update.

Explicit cursor

In show_course_roster, we made a cursor to find students in one course. We OPEN it, FETCH each student's name and grade, and CLOSE it at the end. This is useful when there are several students to show.

Bulk processing

In bulk_grade_bonus, BULK COLLECT gets all the grades for one course into collections. FORALL updates these grades. Instead of sending one update for each student from PL/SQL, Oracle can do the updates as a group. It can save time if there are many records. We use SAVE EXCEPTIONS so we can see which bulk updates failed.

For this small project the speed difference may not be noticeable. A single UPDATE statement could also do the bonus task, but we used FORALL because it is part of what we learned. For a very large table we would get records in smaller groups, since BULK COLLECT uses memory.

Procedures

register_student adds a new student and gives back their ID.
enroll_student puts a student in a course if there is space.
update_grade changes a mark.
show_course_roster lists students in a course.
bulk_grade_bonus adds extra marks to a course, but no mark can go above 100.
remove_enrollment removes a student from a course.
show_student_emails displays the student emails.

Functions

get_student_average calculates a student's average mark. If the student has no marks yet, it returns NULL.
get_course_enrollment_count counts the students in a course.
get_student_email finds the email for a given student name.

Errors

We checked for problems like duplicate emails, a student who does not exist, a full course and a mark above 100. Oracle has errors such as NO_DATA_FOUND and TOO_MANY_ROWS. We also used our own exception for a full course and RAISE_APPLICATION_ERROR to display messages people can understand.

Testing

The success test registers a student, enrolls the student, gives a mark, shows the course list, gives bonus marks and deletes the enrollment. The error test tries incorrect information and prints the expected errors. The tests use ROLLBACK so the original sample records stay the same.



