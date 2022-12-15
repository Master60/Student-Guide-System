--DROP DATABASE Athletes; 
--DROP DATABASE SGS; 

--DROP DATABASE SGS
--CREATE DATABASE SGS; 
-- table creations ; 
/*
1 -comment all table creation and create SGS DB first ,

*/
USE [SGS]

CREATE Table college(
	CollegeID varchar(10) not null, 
	C_name varchar(50) not null, 
	C_location varchar(50) , 
	unique(CollegeID), 
	Primary Key (CollegeID)
);
CREATE TABLE USERS(
	LoginID varchar(10) not null ,
	F_Name varchar(10) not null , 
	L_Name varchar(10) not null ,
	PWD  varchar(50) not null, -- password 
	UserType varchar(10) not null, 
	CollegeID varchar(10), 
	unique(LoginID) , 
	PRIMARY KEY (LoginID),
	Foreign key (CollegeID ) REFERENCES College, -- user posed article 
	-- more 
);
CREATE Table ArticleType (
		A_Type	varchar(20) not null, -- will insert possible values of A_type
		unique(A_Type) , 
		Primary key (A_Type), 
);
CREATE TABLE Article (
	ArticleID varchar(20) not null , 
	A_Type	varchar(20) not null, -- i will create a table that refrence possible article type 
	A_Timestamp Timestamp not null, 
	userID varchar(10) , 
	ParentID  varchar(20), 
	primary Key(ArticleID), 
	Unique(ArticleID) ,
	Unique(A_Timestamp), 
	Foreign Key(A_Type) REFERENCES ArticleType , 
	Foreign key (userID) REFERENCES USERS , -- user posed article 
	Foreign Key (ParentID) REFERENCES Article 
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
	FOREIGN KEY (P_Description) REFERENCES Article,
	FOREIGN KEY (CollegeID ) REFERENCES College 
	
);
CREATE TABLE STUDENTS (
	LoginID varchar(10) not null ,
	CreditHours SMALLINT not null, 
	GPA FLOAT , 
	StartYear SMALLINT not null , 
	lvl  SMALLINT not null, -- lvl   
	programID varchar(20) , 
	unique(LoginID) , 
	Primary KEY(LoginID),
	foreign Key(LoginID) References USERS ,
	foreign Key(programID) References PROGRAM
);
CREATE TABLE COMPANIES (
	CompanyID varchar(20) not null, 
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
	Foreign Key(LoginID) REFERENCES USERS
) ;

CREATE TABLE INSTRUCTOR(
	LoginID varchar(10) not null ,
	OfficeLocation VARCHAR(50), 
	StartYear  SMALLINT, 
	OfficeHours Time ,
	OfficeDay varchar(10) ,
	unique(LoginID), 
	Primary KEY(LoginID) ,
	Foreign Key(LoginID) REFERENCES USERS
);
CREATE TABLE ResearchesAndProjects(
	ResearchID varchar(20) not null,
	Title varchar(50) not null, 
	ReleaseDate  Date not null, 
	R_Description varchar(20) not null ,
	unique(ResearchID ) , 
	unique(Title) , 
	Unique(R_Description), 
	primary Key(ResearchID) ,
	FOREIGN KEY (R_Description) REFERENCES Article
);
CREATE TABLE Gradutes(
	LoginID varchar(10) not null ,
	GraduationYear SMALLINT not null, 
	companyID varchar(20), 
	ProjectID varchar(20), 
 	unique(LoginID) , 
	Primary KEY(LoginID), 
	Foreign Key (LoginID) REFERENCES STUDENTS, 
	Foreign Key (companyID) REFERENCES COMPANIES , -- Works_in; 
	Foreign Key (ProjectID) REFERENCES ResearchesAndProjects  
);



CREATE TABLE Courses (
	CourseID varchar(20) not null, 
	credits SMALLINT not null , 
	C_Description varchar(20),
	Course_Name varchar(50) not null , 
	primary key(CourseID), 
	Foreign Key (C_Description ) REFERENCES Article  -- course has article 
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
	Foreign Key (E_Classification) references E_classification, 
	Foreign key (InstructorID) references INSTRUCTOR ,-- instructor uploads elearning material 
	Foreign Key (courseID) REFERENCES Courses 
);

CREATE TABLE ContactingDetails (
	UserID varchar(10) not null ,
	ContactId varchar(50) not null, 
	Contact nvarchar(20) not null,
	ContactType varchar(20) not null, -- relation could be added 
	Foreign Key (UserID) References Users,
	primary key ( ContactID, UserID) ,
	unique(contact) ,
);

CREATE TABLE FOLLOWS ( -- students follows Company
	StudentID varchar(10) not null,
	CompanyID varchar(20) not null , 
	primary Key (StudentID , companyID), 
	Foreign  Key (StudentID) REFERENCES STUDENTS , 
	FOREIGN KEY (CompanyID) REFERENCES COMPANIES , 
);

CREATE TABLE G_MADE_RESEARCH ( -- GRADUATE MADE REASEARCH 
	StudentID varchar(10) not null , 
	ResearchID varchar(20) not null , 
	purpose varchar(100) , 
	Primary Key (StudentID , ResearchID) , 
	Foreign Key (StudentID) REFERENCES STUDENTS , 
	Foreign Key (ResearchID) REFERENCES ResearchesAndProjects, 
);

CREATE TABLE MANAGES ( -- INSTRUCTOR MANGES PROGRAM 
	InstructorId varchar(10) not null , 
	ProgramID varchar(20) not null, 
	Primary Key (InstructorId) , 
	Foreign Key (InstructorId) REFERENCES Instructor , 
	Foreign Key (ProgramID) REFERENCES PROGRAM
);

CREATE TABLE TEACHES (
	InstructorId varchar(10) not null, 
	CourseID varchar (20) not null , 
	Primary Key (InstructorId , CourseID) ,
	Foreign Key (InstructorId) REFERENCES Instructor , 
	Foreign Key (CourseID ) REFERENCES Courses

);
CREATE TABLE REQUIRES (
	Courseid varchar(20) not null, 
	courseid2 varchar(20) not null , 
	primary key(Courseid , Courseid2),
	Foreign Key (Courseid) REFERENCES Courses ,
	Foreign Key (Courseid2) REFERENCES Courses ,

);
CREATE TABLE IsTakenBy(  -- course is taken by program 
	CourseID varchar (20) not null , 
	ProgramID varchar(20) not null, 
	primary KEy(CourseID, ProgramID), 
	Foreign Key (ProgramID) REFERENCES PROGRAM , 
	Foreign Key (CourseID ) REFERENCES Courses
);
CREATE TABLE S_TAKES_C ( -- student takes course 
	CourseID varchar (20) not null , 
	StudentID varchar(10) not null , 
	primary Key (CourseID , StudentID) , 
	Foreign Key (CourseID ) REFERENCES Courses,
	Foreign Key (StudentID) REFERENCES STUDENTS , 
);
CREATE TABLE A_About_Company(
	CompanyID varchar(20) not null, 
	ArticleID varchar(20) not null , 
	Primary key (CompanyID, ArticleID) , 
	Foreign Key(CompanyID) REFERENCES COMPANIES , 
	Foreign Key (ArticleID) REFERENCES Article , 
);
CREATE TABLE A_About_course(
	CourseID varchar (20) not null , 
	ArticleID varchar(20) not null , 
	Primary key (CourseID , ArticleID) , 
	Foreign Key (CourseID ) REFERENCES Courses,
	Foreign Key (ArticleID) REFERENCES Article , 
);
CREATE TABLE A_About_program(
	ArticleID varchar(20) not null , 
	ProgramID varchar(20) not null, 
	primary KEy(ArticleID , ProgramID), 
	Foreign Key (ProgramID) REFERENCES PROGRAM , 
	Foreign Key (ArticleID) REFERENCES Article , 
);