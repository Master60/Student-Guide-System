DELIMITER $$ 
CREATE PROCEDURE GetNameOfInstructor( IN CourseID varchar(20)) 
BEGIN 
SELECT F_Name , L_Name, LoginID from Users , teaches where teaches.CourseID  = CourseID AND teaches.InstructorID = Users.loginID;
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

/*Article , Article about course , ticketdone true false ;*/
/* input parameter = ARticleId , courseID , userId ,  */

DELIMITER $$ 
CREATE PROCEDURE postTicket(IN  ArtID varchar(20) , IN CID varchar(20) , IN UID varchar(20) , IN Articletxt text , IN tickettxt varchar(100) ) 
BEGIN  
INSERT into article 
values (ArtID,'RequestHelp' , CURRENT_TIMESTAMP , UID ,Articletxt); 

INSERT into ticket_closed 
values (ArtID , 0 , tickettxt); 

INSERT INTO  a_about_course 
values (CID, ArtID ) ; 
END 
$$ 
delimiter ; 


 /*Article Txt , ArticleId , userID , F_Name , L_Name , imgrefrence */
DELIMITER $$ 
CREATE PROCEDURE GetSubArticles(IN  ArtID varchar(20) )  
BEGIN  

select ArticleID , ArticleText , userID, F_Name,  L_Name , imageReference 
from ( select * 
from (Select ChildID from article_parent where ParentID =  ArtID ) as A , article 
where A.ChildID = article.ArticleID and article.A_type= 'Comment' ) AS N , users 
where users.LoginID = N.userID ; 

END 
$$ 
delimiter ; 

DELIMITER $$ 
CREATE PROCEDURE GetComments(IN  ArtID varchar(20) )  
BEGIN  

select ArticleID , ArticleText , userID, F_Name,  L_Name , imageReference 
from ( select * 
from (Select ChildID from article_parent where ParentID =  ArtID ) as A , article 
where A.ChildID = article.ArticleID and article.A_type= 'SubArticle' ) AS N , users 
where users.LoginID = N.userID ; 

END 
$$ 
delimiter ; 
/*1-	 2-		3-		 4- 	5-		 6-		*/

select * from articletype;


DELIMITER $$ 
CREATE PROCEDURE GetContactsOf(IN  InstructorID varchar(10) )  
BEGIN  
select Contact from contactingdetails where contact.LoginID= InstructorID; 
END 
$$ 
delimiter ; 


DELIMITER $$ 
CREATE PROCEDURE GetElearningMaterial(IN  CID varchar(20) )  
BEGIN  

select E_Name, E_Reference from e_learningmaterial where e_learningmaterial.CourseID = CID; 
END 
$$ 
delimiter ; 


DELIMITER $$ 
CREATE PROCEDURE GetcoursesInCollege(IN  CoID varchar(10) )  
BEGIN  
select C.CourseID, credits, Prefix ,C_Description, Course_Name, imageReference from 
(select courseID 
from (select ProgramID from program where program.CollegeID = CoID ) AS P , istakenby 
where p.ProgramID = istakenby.ProgramID ) as C , courses 
where C.CourseID = courses.CourseID;  

END 
$$ 
delimiter ; 


DELIMITER $$ 
CREATE PROCEDURE postComment(IN  ArtID varchar(20) , IN CID varchar(20) , IN UID varchar(20) , IN Articletxt text , IN commenttxt varchar(100) ) 
BEGIN  
INSERT into article 
values (ArtID,'Comment' , CURRENT_TIMESTAMP , UID ,Articletxt); 


INSERT INTO  a_about_course 
values (CID, ArtID ) ; 
END 
$$ 
delimiter ; 


DELIMITER $$ 
CREATE PROCEDURE GetcoursesInCollege(IN  CoID varchar(10) )  
BEGIN  
select C.CourseID, credits, Prefix ,C_Description, Course_Name, imageReference from 
(select courseID 
from (select ProgramID from program where program.CollegeID = CoID ) AS P , istakenby 
where p.ProgramID = istakenby.ProgramID ) as C , courses 
where C.CourseID = courses.CourseID;  

END 
$$ 
delimiter ; 

DELIMITER $$ 
CREATE PROCEDURE postComment(IN  ArtID varchar(20) , IN CID varchar(20) , IN UID varchar(20) , IN Articletxt text , IN commenttxt varchar(100) ) 
BEGIN  
INSERT into article 
values (ArtID,'Comment' , CURRENT_TIMESTAMP , UID ,Articletxt); 

INSERT INTO  a_about_course 
values (CID, ArtID ) ; 
END 
$$ 
delimiter ; 



DELIMITER $$ 
CREATE PROCEDURE GetcoursesInCollege(IN  CoID varchar(10) )  
BEGIN  
select C.CourseID, credits, Prefix ,C_Description, Course_Name, imageReference from 
(select courseID 
from (select ProgramID from program where program.CollegeID = CoID ) AS P , istakenby 
where p.ProgramID = istakenby.ProgramID ) as C , courses 
where C.CourseID = courses.CourseID;  

END 
$$ 
delimiter ; 
