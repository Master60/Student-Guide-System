var middlewareObj = {};

middlewareObj.isAuthorized = function(req, res, next) {
    if (!req.session.identity) {
        req.flash("error", "You need to log in to first to do that");
        res.redirect("back"); // See word file.
        //req.redirect("")
        return;
    }
    next();
}

middlewareObj.isLoggedIn = function(req, res, next) {
    if (req.session.identity) {
        return res.redirect(""); // somewhere. See.
    }
    next();
}

module.exports = middlewareObj;