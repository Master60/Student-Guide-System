const { isAuthorized } = require("../middleware/index");
const connection = require("../DBsql/DB");
var express = require("express"),
    router = express.Router({ mergeParams: true });

router.get("/profile", function (req, res, next) {
    req.session.refe = req.route.path;
    isAuthorized(req, res, function () {
        if (req.session.userType == "Student") {
            connection.query(`SELECT * FROM Users, Students, Program WHERE Program.ProgramID = Students.ProgramID
            AND Students.LoginID = Users.LoginID AND Users.LoginID='` + req.session.identity + "'", function (err, user) {
                if (err) {
                    console.log(err)
                }

                res.render("Nuno Theme Starter Files/Student_Profile.ejs", {
                    userObj: user[0]
                });
            });
        }
    })
});

router.get("/postTicket", function (req, res, next) {
    req.session.refe = req.route.path;
    isAuthorized(req, res, function () {
        connection.query(`SELECT * FROM Courses, s_takes_C WHERE s_takes_c.CourseID =
        Courses.CourseID AND StudentID='` + req.session.identity + "'", function (err, studentCourses) {
            if (err) {
                console.log(err)
            }
            else {
                res.render("Nuno Theme Starter Files/Student_AddTicket.ejs", {
                    courses: studentCourses,
                    previous: {
                        Title: req.session.PreviousRequest.Title,
                        Course: req.session.PreviousRequest.Course,
                        RequestText: req.session.PreviousRequest.complaint
                    }
                })
            }
        });
    });
});

router.post("/postTicket", function (req, res, next) {
    req.session.refe = "/postTicket";  // Modify it to hold the actual request if he was authorized
    isAuthorized(req, res, function () {
        connection.query("SELECT COUNT(ArticleID) FROM Article", function (err, newArticleID) {
            if (err) {
                console.log(err);
            }
            else {
                if (req.body.Title.length <= 100) {
                    var newCount = newArticleID[0]["COUNT(ArticleID)"] + 101;
                        connection.query("CALL postTicket(?, ?, ?, ?, ?)", ["Artn0" + newCount,
                    req.body.Course, req.session.identity, req.body.complaint, req.body.Title], function(err) {
                        if (err) {
                            console.log(err);
                            req.session.PreviousRequest = req.body;
                            res.redirect("/postTicket");
                        }
                        else {
                            res.redirect("/courses"); /// To Be Changed
                        }
                    })
                }
            }
        });
    });
});

module.exports = router;