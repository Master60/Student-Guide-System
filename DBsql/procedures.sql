DELIMITER $$ 
CREATE PROCEDURE GetNameOfInstructor( IN CourseID varchar(20)) 
BEGIN 
SELECT F_Name , L_Name from Users , teaches where teaches.CourseID  = CourseID AND teaches.InstructorID = Users.loginID;
END 
$$
delimiter ;
DELIMITER $$ 
CREATE PROCEDURE GetSemesterName(IN CourseID varchar(20) )
BEGIN 
select SemesterName from c_in_semester where c_in_semester.CourseID = CourseID;
END 
$$
delimiter ;
DELIMITER $$ 
CREATE PROCEDURE RetrieveCourseArticleAndUser(IN CID varchar(20) )
BEGIN
SELECT * From courses, Article, Users, College WHERE CourseID= CID AND C_Description= ArticleID AND LoginID = userID AND Users.CollegeID = College.CollegeID;
END
$$
delimiter ;
DELIMITER $$ 
CREATE PROCEDURE SearchAllCourses(IN CourseID varchar(20) ) 
BEGIN 
SELECT * FROM courses WHERE Course_Name LIKE concat('%' , CourseID , '%'); 
END 
$$ 
delimiter ;




 
