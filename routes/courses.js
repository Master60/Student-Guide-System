const { isLoggedIn, isAuthorized } = require("../middleware/index");
const connection = require("../DBsql/DB");
var express = require("express"),
    router = express.Router({ mergeParams: true });

router.get("/", function (req, res, next) {
    req.session.refe = "/courses";
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
        connection.connect(function (err) {
            connection.query("CALL RetrieveCourseArticleAndUser(" + req.params.course + ");", function (err, result) {
                connection.query("Call GetSemesterName(?)", [req.params.course], function (err, Semesters) {
                    connection.query("call GetNameOfInstructor(?)", req.params.course, function (err, Names) {
                        connection.query("CALL GetContactsOf(?)", [Names[0].LoginID], function (err, contact) {
                            let contacttemp = undefined;
                            for (let i = 0; i < contact[0].length; i++ ) {
                                if(contact[0][i].ContactType == "email") {
                                    contacttemp = contact[0][i].Contact;
                                    break;
                                }
                            }

                            if (!contacttemp) {
                                contacttemp = contact[0][0].Contact;
                            }
                            
                            res.render("Nuno Theme Starter Files/course info.ejs", {
                                course: result[0][0],
                                Semester: Semesters[0],
                                InstructorName: Names[0],
                                contactObj: contacttemp
                            });
                        })
                    });
                });
            });
        });
    });
});

module.exports = router;