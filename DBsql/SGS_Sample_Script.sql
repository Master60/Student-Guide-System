

insert into college
values
('1' ,'Faculty of engineering','Giza'),
('2','Faculty  of medicine','Giza');

insert into PROGRAM
values
('HEM22','Biomedical Engineering' ,'HEM', nulL, '2'),
('CCE11','Computer And Communication Engineering' ,'CCE', NULL, '1' ),
('MEE33','Mechatronics Engineering' ,'MEE', NULL, '1');

insert into USERS
values
('1200100','Malek','Essam','MalekEls@ka','Student','1'),
('1200200','Mina','Ashraf','MinaAshr@f','Student','1'),
('1200300','Bassel','Mohamed','BasselMoh@mmd','Student','1'),
('1200400','Mohamed','Heggi', 'Moh@medHeggi','Student','2');

insert into STUDENTS
values
('1200100',75 ,3.6 ,2020 ,3 ,'HEM22'),
('1200200',78 ,3.8 ,2022 ,2 ,'CCE11'),
('1200300',72 ,3.6 ,2018 ,5 ,'MEE33'),
('1200400',80 ,3.7 ,2021 ,1 ,'CCE11');

insert into ArticleType
values
('ArticleType1'),
('ArticleType2');

insert into Article
values
('Art007', 'ArticleType1', '2022-10-22 22:12:11','1200100', null, "This is not to say you should never attend another meeting, but the truth is that we say yes to many things we don't actually want to do. There are many meetings held that don't need to be held. There is a lot of code written that could be deleted."),
('Art092', 'ArticleType1', '2021-01-12 21:02:21', '1200200', null, "How often do people ask you to do something and you just reply, “Sure thing.” Three days later, you're overwhelmed by how much is on your to-do list. We become frustrated by our obligations even though we were the ones who said yes to them in the first place"),
('Art023', 'ArticleType2', '2018-07-01 22:22:11', '1200400', null, "We agree to many requests not because we want to do them, but because we don't want to be seen as rude, arrogant, or unhelpful. Often, you have to consider saying no to someone you will interact with again in the future—your co-worker, your spouse, your family and friends."),
('Art002', 'ArticleType1', '2019-9-22 11:03:11', '1200300', null, "Saying no to these people can be particularly difficult because we like them and want to support them. (Not to mention, we often need their help too.) Collaborating with others is an important element of life. The thought of straining the relationship outweighs the commitment of our time and energy"),
('Art072', 'ArticleType1', '2021-01-12 08:02:01', '1200200', 'Art007', "But even after we have accounted for these social considerations, many of us still seem to do a poor job of managing the tradeoff between yes and no. We find ourselves over-committed to things that don't meaningfully improve or support those around us, and certainly don't improve our own lives."),
('Art063', 'ArticleType2', '2020-04-21 22:12:32', '1200300', 'Art023', 'The words “yes” and “no” get used in comparison to each other so often that it feels like they carry equal weight in conversation. In reality, they are not just opposite in meaning, but of entirely different magnitudes in commitment.'),
('Art054', 'ArticleType1', '2017-03-11 03:19:10', '1200200', 'Art002', 'I like how the economist Tim Harford put it, “Every time we say yes to a request, we are also saying no to anything else we might accomplish with the time.” Once you have committed to something, you have already decided how that future block of time will be spent.'),
('Art039', 'ArticleType2', '2020-12-01 20:18:19', '1200200', 'Art092', 'Saying no is sometimes seen as a luxury that only those in power can afford. And it is true: turning down opportunities is easier when you can fall back on the safety net provided by power, money, and authority. But it is also true that saying no is not merely a privilege reserved for the successful among us. It is also a strategy that can help you become successful.');

INSERT INTO `sgs`.`semester` (`SemesterName`) VALUES ('Fall');
INSERT INTO `sgs`.`semester` (`SemesterName`) VALUES ('Spring');
INSERT INTO `sgs`.`semester` (`SemesterName`) VALUES ('Summer');

INSERT INTO `sgs`.`courses` (`CourseID`, `credits`, `Prefix`, `Course_Name`) VALUES ('1', '3', 'ELCN112', 'Circuits-2');
INSERT INTO `sgs`.`courses` (`CourseID`, `credits`, `Prefix`, `Course_Name`) VALUES ('2', '3', 'ELCN101', 'Electronics');
INSERT INTO `sgs`.`courses` (`CourseID`, `credits`, `Prefix`, `Course_Name`) VALUES ('3', '2', 'GENN201', 'Risk Managment and Environment');
INSERT INTO `sgs`.`courses` (`CourseID`, `credits`, `Prefix`, `Course_Name`) VALUES ('4', '3', 'CMPN201', 'Microprocessor Systems - 1');
INSERT INTO `sgs`.`courses` (`CourseID`, `credits`, `Prefix`, `Course_Name`) VALUES ('5', '3', 'CMPN202', 'Introduction to Database Systems');

INSERT INTO `sgs`.`c_in_semester` (`CourseID`, `SemesterName`) VALUES ('1', 'Fall');
INSERT INTO `sgs`.`c_in_semester` (`CourseID`, `SemesterName`) VALUES ('1', 'Spring');
INSERT INTO `sgs`.`c_in_semester` (`CourseID`, `SemesterName`) VALUES ('2', 'Fall');
INSERT INTO `sgs`.`c_in_semester` (`CourseID`, `SemesterName`) VALUES ('2', 'Spring');
INSERT INTO `sgs`.`c_in_semester` (`CourseID`, `SemesterName`) VALUES ('3', 'Fall');
INSERT INTO `sgs`.`c_in_semester` (`CourseID`, `SemesterName`) VALUES ('3', 'Spring');
INSERT INTO `sgs`.`c_in_semester` (`CourseID`, `SemesterName`) VALUES ('3', 'Summer');

UPDATE `sgs`.`courses` SET `C_Description` = 'Art002' WHERE (`CourseID` = '1');
UPDATE `sgs`.`courses` SET `C_Description` = 'Art007' WHERE (`CourseID` = '2');
UPDATE `sgs`.`courses` SET `C_Description` = 'Art023' WHERE (`CourseID` = '3');
UPDATE `sgs`.`courses` SET `C_Description` = 'Art039' WHERE (`CourseID` = '4');

INSERT INTO `sgs`.`users` (`LoginID`, `F_Name`, `L_Name`, `PWD`, `UserType`, `CollegeID`) VALUES ('1300100', 'Mohamed', 'Refqy', 'refqy@gmail', 'Instructor', '1');
INSERT INTO `sgs`.`users` (`LoginID`, `F_Name`, `L_Name`, `PWD`, `UserType`, `CollegeID`) VALUES ('1300200', 'lydia', 'waheed', 'lydia@waheed', 'Instructor', '1');
INSERT INTO `sgs`.`users` (`LoginID`, `F_Name`, `L_Name`, `PWD`, `UserType`, `CollegeID`) VALUES ('1300300', 'Osama', 'Nasser', 'Osama@Nasser', 'Instructor', '1');
INSERT INTO `sgs`.`users` (`LoginID`, `F_Name`, `L_Name`, `PWD`, `UserType`, `CollegeID`) VALUES ('1300400', 'Khalid', 'elsoradi', 'khalid@elsoradi', 'Instructor', '1');

INSERT INTO `sgs`.`instructor` (`LoginID`, `OfficeLocation`, `StartYear`, `OfficeHours`, `OfficeDay`) VALUES ('1300100', '20520', '2001', '2', 'thurs');
INSERT INTO `sgs`.`instructor` (`LoginID`, `OfficeLocation`, `StartYear`, `OfficeHours`, `OfficeDay`) VALUES ('1300200', '20521', '2002', '3', 'wed');
INSERT INTO `sgs`.`instructor` (`LoginID`, `OfficeLocation`, `StartYear`, `OfficeHours`, `OfficeDay`) VALUES ('1300300', '20523', '2003', '2', 'wed');
INSERT INTO `sgs`.`instructor` (`LoginID`, `OfficeLocation`, `StartYear`, `OfficeHours`, `OfficeDay`) VALUES ('1300400', '20524', '2004', '2', 'wed');

INSERT INTO `sgs`.`teaches` (`InstructorId`, `CourseID`) VALUES ('1300100', '1');
INSERT INTO `sgs`.`teaches` (`InstructorId`, `CourseID`) VALUES ('1300200', '2');
INSERT INTO `sgs`.`teaches` (`InstructorId`, `CourseID`) VALUES ('1300400', '3');
INSERT INTO `sgs`.`teaches` (`InstructorId`, `CourseID`) VALUES ('1300300', '4');

UPDATE `sgs`.`courses` SET `C_Description` = 'Art039' WHERE (`CourseID` = '5');
