use sgs ;
select F_Name , L_Name from Users , teaches where teaches.CourseID  = 1 AND teaches.InstructorID = Users.loginID;