var middlewareObj = {};

middlewareObj.isAuthorized = function(req, res, next) {
    if (!req.session.identity) {
        req.flash("error", "You need to log in to access this page");
        return res.redirect("/login"); // See word file.
    }
    next();
}

middlewareObj.isLoggedIn = function(req, res, next) {
    if (req.session.identity) {
        return res.redirect("/announcements"); // somewhere. See.
    }
    next();
}

middlewareObj.checkUserCourses = function(req, res, next) {
    if (this.isAuthorized(req, res, function(){})) {
        console.log("HEY")
    }
}

module.exports = middlewareObj;