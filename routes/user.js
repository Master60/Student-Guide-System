const { isLoggedIn, isAuthorized } = require("../middleware/index");
const { encrypt, compare } = require("../middleware/encrypt");
const env = require("dotenv").config();
const mssql = require("msnodesqlv8");

var express = require("express"),
    router = express.Router({ mergeParams: true });

router.get("/", function (req, res) {

});

router.get("/home", function (req, res) {
    res.redirect("/");
});

router.get("/login", isLoggedIn, function (req, res) {
    console.log(res.locals.messages);
    res.render("Nuno Theme Starter Files/Login-Register.ejs");
});

router.post("/login", isLoggedIn, function (req, res) {
    console.log(req.body);
    let hashed = mssql.query(process.env.CONNECTION_STRING, "SELECT password FROM Users WHERE username='"
        + req.body.username + "'", function (err, rows) {
            if (err) {
                console.log("err");
                req.flash("error", "Username or password is wrong");
                res.redirect("/login");
            }
            else {
                compare(req.body.password, rows[0].password, function(next) {
                    if (next) {
                        req.flash("success", "Welcome");
                    }
                    else {
                        console.log("err1");
                        req.flash("error", "Username or password is wrong");
                    }
                });
            }
        });


});

router.post("/register", isLoggedIn, function (req, res) {

});

router.post("/logout", isAuthorized, function (req, res) {

});

module.exports = router;