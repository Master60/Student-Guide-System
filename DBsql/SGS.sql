CREATE DATABASE SGS; 
-- table creations ; 

CREATE TABLE USERS(
	LoginID varchar(50) not null ,
	F_Name varchar(10) not null , 
	L_Name varchar(10) not null ,
	PWD  varchar(50) not null, -- password 
	UserType varchar(10) not null, 
	unique(LoginID) , 
	unique(PWD),
	PRIMARY KEY (LoginID)
	-- more 
);

CREATE TABLE STUDENTS (
	LoginID varchar(50) not null ,
	F_Name varchar(10) not null , 
	L_Name varchar(10) not null ,
	PWD  varchar(50) not null, -- password 
	UserType varchar(10) not null, 
	CreditHours SMALLINT not null, 
	GPA FLOAT , 
	StartYear SMALLINT not null , 
	lvl  SMALLINT not null, -- lvl   
	unique(LoginID) , 
	unique(PWD),
	Primary KEY(LoginID)
);

CREATE TABLE Gradutes(
	LoginID varchar(50) not null ,
	F_Name varchar(10) not null , 
	L_Name varchar(10) not null ,
	PWD  varchar(50) not null, -- password 
	UserType varchar(10) not null, 
	CreditHours SMALLINT not null, 
	GPA FLOAT , 
	StartYear SMALLINT not null , 
	GraduationYear SMALLINT not null, 
	lvl  SMALLINT not null, -- lvl   
	unique(LoginID) , 
	unique(PWD),
	Primary KEY(LoginID)
);

CREATE TABLE ADMINSTRATOR (
	LoginID varchar(50) not null ,
	F_Name varchar(10) not null , 
	L_Name varchar(10) not null ,
	PWD  varchar(50) not null, -- password 
	UserType varchar(10) not null, 
	OfficeLocation VARCHAR(50) , 
	StartYear  SMALLINT , 
	unique(LoginID) , 
	unique(PWD),
	Primary KEY(LoginID)	
) ;

CREATE TABLE INSTRUCTOR(
	LoginID varchar(50) not null ,
	F_Name varchar(10) not null , 
	L_Name varchar(10) not null ,
	PWD  varchar(50) not null, -- password 
	UserType varchar(10) not null, 
	OfficeLocation VARCHAR(50), 
	StartYear  SMALLINT, 
	OfficeHours Time ,
	OfficeDay varchar(10) ,
	unique(LoginID), 
	unique(PWD),
	Primary KEY(LoginID)
);

CREATE Table college(
	CollegeID varchar(10) not null, 
	C_name varchar(50) not null, 
	C_location varchar(50) , 
	unique(CollegeID), 
	Primary Key (CollegeID)
);
CREATE TABLE PROGRAM(
	ProgramID varchar(20) not null , 
	P_Name varchar(50) not null, 
	P_Code  varchar(10) not null, 
	P_Description varchar(7999) not null ,
	unique(P_Name), 
	unique(ProgramID), 
	unique(P_Name), 
	unique(P_Description),
	Primary key (ProgramID), 
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
	primary Key(ArticleID), 
	Unique(ArticleID) ,
	Unique(A_Timestamp), 
	Foreign Key(A_Type) REFERENCES ArticleType , 
	
);
CREATE TABLE ResearchesAndProjects(
	ResearchID varchar(20) not null,
	Title varchar(50) not null, 
	ReleaseDate  Date not null, 
	R_Description varchar(7999) not null ,
	unique(ResearchID ) , 
	unique(Title) , 
	Unique(R_Description), 
	primary Key(ResearchID) 
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
	FileFormate varchar(20) ,
	Primary Key (E_ID) ,
	Foreign Key (E_Classification) references E_classification, 
	unique(E_ID), 

) ;
CREATE TABLE COMPANIES (
	CompanyID varchar(20) not null, 
	C_NAME varchar(50) not null, 
	C_Location varchar(50) , 
	unique(C_NAME),
	unique(C_Location),
	unique(CompanyID ), 
	Primary Key (CompanyID)
);
CREATE TABLE ContactingDetails (
	UserID varchar(50) not null ,
	ContactId varchar(50) not null, 
	Email varchar(20) ,
	phoneNumber1 varchar(11) not null , 
	phoneNumber2 varchar(11) ,
	C_Address varchar(50) , 
	Foreign Key (UserID) References Users,
	primary key ( ContactID, UserID) ,
	unique(Email) ,
	unique(PhoneNumber1) ,
	unique(PhoneNumber2) ,
);
CREATE TABLE Courses (
	CourseID varchar(20) not null, 
	credits SMALLINT not null , 
	Course_Name varchar(50) not null , 
	primary key(CourseID), 
	unique(Course_Name) 
);

INSERT INTO Courses 
values ('111' , 123, 'CMPN202')