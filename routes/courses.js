const { isLoggedIn, isAuthorized } = require("../middleware/index");
const connection = require("../DBsql/DB");
var express = require("express"),
    router = express.Router({ mergeParams: true });

router.get("/", function (req, res, next) {
    req.session.refe = "/courses/";
    isAuthorized(req, res, function () {
        connection.query("SELECT * From courses", function (err, result) {
            res.render("Nuno Theme Starter Files/courses.ejs", {
                courses: result
            });
        });
    });
});

router.get("/:course", function (req, res, next) {
    req.session.refe = "/courses/" + req.params.course;
    isAuthorized(req, res, function () {
        connection.query("SELECT * From courses, Article, Users, College WHERE CourseID='" + req.params.course +
            "' AND C_Description=ArticleID AND LoginID = userID AND Users.CollegeID = College.CollegeID", function (err, result) {
                connection.query("select SemesterName from c_in_semester where c_in_semester.CourseID =" + req.params.course + ";", function (err, Semesters) {
                    connection.query("select F_Name , L_Name from Users , teaches where teaches.CourseID  = '" + req.params.course + "' AND teaches.InstructorID = Users.loginID;", function (err, Names) {
                        res.render("Nuno Theme Starter Files/course info.ejs", {
                            course: result[0],
                            Semester: Semesters,
                            InstructorName: Names
                        });
                    });
                });
            });
    });
});

module.exports = router;