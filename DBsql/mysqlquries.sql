DELIMITER $$ 
CREATE PROCEDURE GetNameOfInstructor( IN CourseID varchar(20) ) 
BEGIN 
SELECT F_Name , L_Name from Users , teaches where teaches.CourseID  = CourseID AND teaches.InstructorID = Users.loginID;
END 
$$ 