const { isLoggedIn, isAuthorized } = require("../middleware/index");
const { encrypt, compare } = require("../middleware/encrypt");
const connection = require("../DBsql/DB");
var express = require("express"),
    router = express.Router({ mergeParams: true });

router.get("/", function (req, res) {
    res.render("Nuno Theme Starter Files/index2.ejs")
});

router.get("/home", function (req, res) {
    res.redirect("/");
});

router.get("/login", isLoggedIn, function (req, res) {
    res.render("Nuno Theme Starter Files/Login-Register.ejs");
});

router.post("/login", isLoggedIn, function (req, res, next) {
    connection.query("SELECT LoginID, UserType, PWD FROM Users WHERE F_Name='"
        + req.body.username + "'", function (err, rows) {
            if (err || !rows[0]) {
                console.log("Hey");
                req.flash("error", "Username or password is wrong");
                res.redirect("/login");
            }
            else {
                compare(req.body.password, rows[0].PWD, function (same) {
                    if (same) {
                        req.flash("success", "Welcome");
                        req.session.identity = rows[0].LoginID;
                        req.session.userType = rows[0].UserType;
                        res.redirect(req.session.refe || "/announcements")
                    }
                    else {
                        req.flash("error", "Username or password is wrong");
                        res.redirect("/login");
                    }
                });
            }
        });

});

router.get("/announcements", function (req, res, next) {
    req.session.refe = req.route.path;
    isAuthorized(req, res, function () {
        connection.query("CALL PopulateAnnouncement(?)", [req.session.identity], function (err, result) {
            if (err) {
                console.log(err);
            }
            else {
                res.render("Nuno Theme Starter Files/announcements.ejs", {
                    articles: result[0]
                });
            }
        });
    });
});


router.get("/announcements/:article", function (req, res, next) {
    req.session.refe = "/announcements/" + req.params.article;
    isAuthorized(req, res, function () {
        connection.query("CALL GetComments(?)", [req.params.article], function (err, comments) {
            connection.query("SELECT * FROM Article, Users WHERE UserID = LoginID AND ArticleID = '" + req.params.article + "'", function (err, text) {
                connection.query("SELECT * FROM Users WHERE LoginID='" + req.session.identity + "'", function (err, cuserData) {
                    console.log(comments)
                    res.render("Nuno Theme Starter Files/Student_AnnouncementInfo.ejs", {
                        Article: text[0],
                        commentArray: comments[0],
                        currentUser: cuserData[0]
                    })
                })
            })
        })
    })
});


router.post("/announcements/articles", function (req, res, next) {
    isAuthorized(req, res, function () {
        connection.query("SELECT CourseID FROM a_about_course WHERE ArticleID='" + req.session.refe.substring(15,
            req.session.refe.length) + "'", function (err, result) {
                connection.query("SELECT COUNT(ArticleID) FROM Article", function (err, newArticleID) {
                    if (err) {
                        console.log(err);
                    }
                    else {
                        var newCount = newArticleID[0]["COUNT(ArticleID)"] + 202;
                        connection.query("CALL postComment(?, ?, ?, ?, ?)", ["Artn0" + newCount, result[0].CourseID,
                        req.session.identity, req.body.Text, req.session.refe.substring(15,
                            req.session.refe.length)], function (err, result) {
                                if (err) {
                                    console.log(err)
                                }
                                res.redirect(req.session.refe)
                            })
                    }
                });
            });
    });
})

router.post("/register", isLoggedIn, function (req, res) {

});

router.post("/logout", isAuthorized, function (req, res) {

});

module.exports = router;