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

DELIMITER $$ 
CREATE PROCEDURE GetArticleAboutCourseAndAuther(IN SID varchar(20) ) 
BEGIN 
Select ArticleText , F_Name, L_Name , A_Timestamp from  (select distinct * from 
(select ArticleID from a_about_course, (Select CourseID from s_takes_c where StudentID = SID ) as N where a_about_course.CourseID = N.CourseID) as A natural join Article ) as T , users where users.loginID = T.userID
order by A_Timestamp desc ; 
END 
$$ 
delimiter ;
DELIMITER $$ 
CREATE PROCEDURE GetArticleAboutCompanyAndAuther(IN SID varchar(20) ) 
BEGIN 
Select ArticleText , F_Name, L_Name , A_Timestamp from  (select distinct * from 
(select ArticleID from a_about_company, (Select CompanyID from follows where StudentID = SID ) as N where a_about_company.CompanyID = N.CompanyID) as A natural join Article ) as T , users where users.loginID = T.userID
order by A_Timestamp desc ; 
END 
$$ 
delimiter ; 

DELIMITER $$ 
CREATE PROCEDURE PopulateAnnouncement(IN SID varchar(20) ) 
BEGIN 
Select ArticleText , F_Name, L_Name , A_Timestamp from  (select distinct * from 
(select ArticleID from a_about_course, (Select CourseID from s_takes_c where StudentID = SID ) as N where a_about_course.CourseID = N.CourseID) as A natural join Article ) as T , users where users.loginID = T.userID
UNION
Select ArticleText , F_Name, L_Name , A_Timestamp from  (select distinct * from 
(select ArticleID from a_about_company, (Select CompanyID from follows where StudentID = SID ) as N where a_about_company.CompanyID = N.CompanyID) as A natural join Article ) as T , users where users.loginID = T.userID
order by A_Timestamp desc ; 
END 
$$ 
delimiter ; 













 
