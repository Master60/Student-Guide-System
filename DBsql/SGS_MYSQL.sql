/*DROP DATABASE Athletes; 
--DROP DATABASE SGS; 

--DROP DATABASE SGS
--CREATE DATABASE SGS; 
-- table creations ; 
/*
1 -comment all table creation and create SGS DB first ,

*/
USE sgs;

CREATE Table college(
	CollegeID varchar(10) not null, 
	C_name varchar(50) not null, 
	C_location varchar(50) , 
	unique(CollegeID), 
	Primary Key (CollegeID)
);
CREATE TABLE USERS(
	LoginID varchar(10) not null default 0,
	F_Name varchar(10) not null , 
	L_Name varchar(10) not null ,
	PWD  varchar(100) not null, -- password 
	UserType varchar(10) not null, 
	CollegeID varchar(10) not null, 
	unique(LoginID) , 
	PRIMARY KEY (LoginID),
	Foreign key (CollegeID) REFERENCES College(CollegeID)
	ON UPDATE cascade
	ON DELETE cascade
	-- user posed article 
	-- more 
);

CREATE Table ArticleType (
		A_Type	varchar(20) not null, -- will insert possible values of A_type
		unique(A_Type) , 
		Primary key (A_Type)
);

CREATE TABLE Article (
	ArticleID varchar(20) not null , 
	A_Type	varchar(20) not null, -- i will create a table that refrence possible article type 
	A_Timestamp Timestamp not null, 
	userID varchar(10) , 
	ParentID  varchar(20), 
	ArticleText	Text not null,
	primary Key(ArticleID), 
	Unique(ArticleID) ,
	Unique(A_Timestamp), 
	Foreign Key(A_Type) REFERENCES ArticleType(A_Type), 
	Foreign key (userID) REFERENCES USERS(LoginID) 
	ON DELETE SET null
	ON UPDATE cascade, -- user posed article 
	Foreign Key (ParentID) REFERENCES Article(ArticleID)
	ON DELETE cascade
	ON UPDATE cascade
);

CREATE TABLE `sgs`.`article_parent` (
  `ParentID` VARCHAR(20) NOT NULL,
  `ChildID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ParentID`, `ChildID`),
    FOREIGN KEY (`ParentID`)
    REFERENCES `sgs`.`article` (`ArticleID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`ChildID`)
    REFERENCES `sgs`.`article` (`ArticleID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE PROGRAM(
	ProgramID varchar(20) not null , 
	P_Name varchar(50) not null, 
	P_Code  varchar(10) not null, 
	P_Description varchar(20),
	CollegeID varchar(10), 
	unique(ProgramID), 
	unique(P_Description), 
	Primary key (ProgramID), 
	FOREIGN KEY (P_Description) REFERENCES Article(ArticleID)
	ON UPDATE cascade
	ON DELETE set null,
	FOREIGN KEY (CollegeID ) REFERENCES College(CollegeID)
	ON DELETE cascade
	ON UPDATE cascade
	
);
CREATE TABLE STUDENTS (
	LoginID varchar(10) not null default 0,
	CreditHours SMALLINT not null, 
	GPA FLOAT , 
	StartYear SMALLINT not null , 
	lvl  SMALLINT not null, -- lvl   
	programID varchar(20) , 
	unique(LoginID) , 
	Primary KEY(LoginID),
	foreign Key(LoginID) References USERS(LoginID)
	ON DELETE cascade
	ON UPDATE cascade,
	foreign Key(programID) References PROGRAM(ProgramID)
	ON DELETE cascade
	ON UPDATE cascade
);
CREATE TABLE COMPANIES (
	CompanyID varchar(20) not null default 0, 
	C_NAME varchar(50) not null, 
	C_Location varchar(50) , 
	unique(C_NAME),
	unique(CompanyID ), 
	Primary Key (CompanyID)
);

CREATE TABLE ADMINSTRATOR (
	LoginID varchar(10) not null ,
	OfficeLocation VARCHAR(50) , 
	StartYear  SMALLINT , 
	unique(LoginID) , 
	Primary KEY(LoginID), 
	Foreign Key(LoginID) REFERENCES USERS(LoginID)
	ON UPDATE cascade
	ON DELETE cascade
) ;

CREATE TABLE INSTRUCTOR(
	LoginID varchar(10) not null default 0,
	OfficeLocation VARCHAR(50), 
	StartYear  SMALLINT, 
	OfficeHours Time ,
	OfficeDay varchar(10) ,
	unique(LoginID), 
	Primary KEY(LoginID) ,
	Foreign Key(LoginID) REFERENCES USERS(LoginID)
	ON UPDATE cascade
	ON DELETE cascade
);
CREATE TABLE ResearchesAndProjects(
	ResearchID varchar(20) not null,
	Title varchar(50) not null,
    link varchar(200),
	ReleaseDate  Date not null, 
    ProjectIntro varchar(20),
	/*R_Description varchar(20) not null ,*/
	unique(ResearchID ) , 
	unique(Title) , 
	/*--Unique(R_Description), */
	primary Key(ResearchID),
    foreign key(ProjectIntro) references Article(ArticleID)
    ON delete set null
    on update cascade
	/*--FOREIGN KEY (R_Description) REFERENCES Article*/
);
CREATE TABLE Graduates(
	LoginID varchar(10) not null default 0,
	GraduationYear SMALLINT not null, 
	companyID varchar(20), 
	ProjectID varchar(20), 
 	unique(LoginID) , 
	Primary KEY(LoginID), 
	Foreign Key (LoginID) REFERENCES STUDENTS(LoginID)
	ON DELETE cascade
	ON UPDATE cascade, 
	Foreign Key (companyID) REFERENCES COMPANIES(CompanyID)
	ON DELETE set null
	ON UPDATE cascade, -- Works_in; 
	Foreign Key (ProjectID) REFERENCES ResearchesAndProjects(ResearchID)
	ON DELETE set null -- meaningless
	ON UPDATE cascade
);



CREATE TABLE Courses (
	CourseID varchar(20) not null, 
	credits SMALLINT not null , 
	Prefix varchar(10) not null,
	C_Description varchar(20),
	Course_Name varchar(50) not null , 
	imageReference	varchar(20),
	primary key(CourseID), 
	Foreign Key (C_Description ) REFERENCES Article(ArticleID)  -- course has article 
	ON UPDATE cascade
	ON DELETE set null -- meaningless as well
);

CREATE TABLE Semester (
	SemesterName varchar(10),
    Primary key (SemesterName)
);

CREATE TABLE C_IN_SEMESTER (
	CourseID varchar(20) not null,
    SemesterName varchar(10) not null,
    Primary Key (CourseID, SemesterName),
    Foreign Key (CourseID) REFERENCES Courses(CourseID),
    Foreign Key (SemesterName) REFERENCES Semester(SemesterName)
);

CREATE TABLE E_Classification(
	E_Class varchar(20) not null , 
	Primary key (E_Class) -- will put all primary possible values of classifications in it 
) ;
CREATE TABLE E_LearningMaterial(
	E_ID varchar(20) not null , 
	E_Name varchar(20) not null, 
	E_Classification varchar(20) not null ,  -- refrences E_classification 
	E_Reference varchar(7999) , 
	InstructorID varchar(10), 
	FileFormate varchar(20) ,
	courseID varchar(20) ,
	Primary Key (E_ID) ,
	Foreign Key (E_Classification) references E_classification(E_Class), 
	Foreign key (InstructorID) references INSTRUCTOR(LoginID) 
	ON UPDATE cascade
	ON DELETE set null,-- instructor uploads elearning material 
	Foreign Key (courseID) REFERENCES Courses(courseID) 
	ON DELETE cascade
	ON UPDATE cascade
);

CREATE TABLE ContactingDetails (
	UserID varchar(10) not null ,
	ContactId varchar(50) not null, 
	Contact nvarchar(20) not null,
	ContactType varchar(20) not null, -- relation could be added 
	Foreign Key (UserID) References Users(LoginID)
	ON DELETE cascade
	ON UPDATE cascade,
	primary key ( ContactID, UserID) ,
	unique(contact)
);

CREATE TABLE FOLLOWS ( -- students follows Company
	StudentID varchar(10) not null,
	CompanyID varchar(20) not null , 
	primary Key (StudentID , companyID), 
	Foreign  Key (StudentID) REFERENCES STUDENTS(LoginID)
	ON DELETE cascade
	ON UPDATE cascade, 
	FOREIGN KEY (CompanyID) REFERENCES COMPANIES(CompanyID)
	ON DELETE cascade
	ON UPDATE cascade
);

CREATE TABLE G_MADE_RESEARCH ( -- GRADUATE MADE REASEARCH 
	StudentID varchar(10) not null DEFAULT 0 , 
	ResearchID varchar(20) not null , 
	purpose varchar(100) , 
	Primary Key (StudentID , ResearchID) , 
	Foreign Key (StudentID) REFERENCES Graduates(LoginID)
	ON UPDATE cascade
	ON DELETE NO ACTION, 
	Foreign Key (ResearchID) REFERENCES ResearchesAndProjects(ResearchID)
	ON UPDATE cascade
	ON DELETE cascade
);

delimiter |
CREATE TRIGGER SetDefaultGraduate
BEFORE DELETE ON Graduates
FOR EACH ROW
BEGIN
UPDATE G_MADE_RESEARCH SET StudentID = 0 WHERE StudentID = OLD.LoginID;
END;

|

delimiter ;

CREATE TABLE MANAGES ( -- INSTRUCTOR MANGES PROGRAM 
	InstructorId varchar(10) not null default 0, 
	ProgramID varchar(20) not null, 
	Primary Key (InstructorId) , 
	Foreign Key (InstructorId) REFERENCES Instructor(LoginID)
	ON UPDATE cascade, 
	Foreign Key (ProgramID) REFERENCES PROGRAM(ProgramID)
	ON UPDATE cascade
	ON DELETE cascade
);

CREATE TABLE TEACHES (
	InstructorId varchar(10) not null, 
	CourseID varchar (20) not null , 
	Primary Key (InstructorId , CourseID) ,
	Foreign Key (InstructorId) REFERENCES Instructor(LoginID)
	ON DELETE cascade
	ON UPDATE cascade, 
	Foreign Key (CourseID ) REFERENCES Courses(courseID)
	ON DELETE cascade
	ON UPDATE cascade

);
CREATE TABLE REQUIRES (
	Courseid varchar(20) not null, 
	courseid2 varchar(20) not null , 
	primary key(Courseid , Courseid2),
	Foreign Key (Courseid) REFERENCES Courses(courseID)
	ON UPDATE cascade
	ON DELETE cascade, -- Trigger for deleting course
	Foreign Key (Courseid2) REFERENCES Courses(CourseID)
	ON DELETE cascade
	ON UPDATE cascade

);

CREATE TABLE IsTakenBy(  -- course is taken by program 
	CourseID varchar (20) not null , 
	ProgramID varchar(20) not null, 
	Primary Key(CourseID, ProgramID), 
	Foreign Key (ProgramID) REFERENCES PROGRAM(ProgramID) 
	ON UPDATE cascade
	ON DELETE cascade,
	Foreign Key (CourseID ) REFERENCES Courses(courseID)
	ON UPDATE cascade
	ON DELETE cascade
);

delimiter |
CREATE TRIGGER DELETECourses
	AFTER DELETE ON Program 
    FOR EACH ROW
    BEGIN
	-- Need to be tested
	DELETE from Courses WHERE CourseID in (SELECT CourseID FROM 
	(SELECT CourseID, COUNT(*) FROM IsTakenBy GROUP BY CourseID HAVING COUNT(*) < 2) 
	AS TEMPO, IsTakenBy WHERE TEMPO.CourseID = IsTakenBy.CourseID AND ProgramID = OLD.ProgramID);
    END;
|
delimiter ;

	/*--DELETE From PROGRAM WHERE ProgramID in (SELECT ProgramID from deleted);*/

CREATE TABLE S_TAKES_C ( -- student takes course 
	CourseID varchar (20) not null , 
	StudentID varchar(10) not null , 
	primary Key (CourseID , StudentID) , 
	Foreign Key (CourseID ) REFERENCES Courses(courseID)
	ON DELETE cascade
	ON UPDATE cascade,
	Foreign Key (StudentID) REFERENCES STUDENTS(LoginID)
	ON DELETE cascade
	ON UPDATE cascade
);
CREATE TABLE A_About_Company(
	CompanyID varchar(20) not null default 0, 
	ArticleID varchar(20) not null , 
	Primary key (CompanyID, ArticleID) , 
	Foreign Key(CompanyID) REFERENCES COMPANIES(CompanyID)
	ON UPDATE cascade
	ON DELETE NO ACTION, 
	Foreign Key (ArticleID) REFERENCES Article(ArticleID)
	ON UPDATE cascade
	ON DELETE cascade
);

delimiter |
CREATE TRIGGER setDefaultArticle
BEFORE DELETE ON Companies
FOR EACH ROW
BEGIN
UPDATE A_About_Company SET CompanyID = 0 WHERE CompanyID = OLD.CompanyID;

END;

|

delimiter ;

CREATE TABLE A_About_course(
	CourseID varchar (20) not null , 
	ArticleID varchar(20) not null , 
	Primary key (CourseID , ArticleID) , 
	Foreign Key (CourseID ) REFERENCES Courses(courseID)
	ON UPDATE cascade
	ON DELETE cascade,
	Foreign Key (ArticleID) REFERENCES Article(ArticleID)
	ON UPDATE cascade
	ON DELETE cascade
);

/*CREATE TRIGGER DeleteArticles
	AFTER DELETE ON Courses
	FOR EACH ROW
	DELETE FROM Article WHERE ArticleID in 
	(SELECT ArticleID FROM A_About_course WHERE CourseID in (SELECT CourseID from deleted));*/


CREATE TABLE A_About_program(
	ArticleID varchar(20) not null , 
	ProgramID varchar(20) not null, 
	primary KEy(ArticleID , ProgramID), 
	Foreign Key (ProgramID) REFERENCES PROGRAM(ProgramID)
	ON UPDATE cascade
	ON DELETE cascade, 
	Foreign Key (ArticleID) REFERENCES Article(ArticleID)
	ON UPDATE cascade
	ON DELETE cascade
);

CREATE TRIGGER DeleteArticles
	AFTER DELETE ON Program
	FOR EACH ROW
	DELETE FROM Article WHERE ArticleID in 
	(SELECT ArticleID FROM A_About_program WHERE ProgramID = OLD.ProgramID);


