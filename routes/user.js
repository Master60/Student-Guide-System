const { isLoggedIn, isAuthorized } = require("../middleware/index");

var express = require("express"),
    router = express.Router({ mergeParams: true });

router.get("/", function(req, res) {

});

router.get("/home", function(req, res) {
    res.redirect("/");
});

router.post("/login", isLoggedIn, function(req, res) {

});

router.post("/register", isLoggedIn, function(req, res) {

});

router.post("/logout", isAuthorized, function(req, res) {

});