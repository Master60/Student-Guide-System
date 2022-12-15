var express = require("express"),
    app = express(),
    bodyParser = require("body-parser"),
    http = require("http").createServer(app),
    io = require("socket.io")(http),
    //localStrategy = require("passport-local"),
    expressSession = require("express-session"),
    methodOverride = require("method-override"),
    path = require("path"),
    //route = "",
    //refe = "",
    //rout = "",
    flash = require("connect-flash"),
    UserRoute = require("./routes/user.js");

app.use(flash());
app.use(methodOverride("_method"));
app.use(expressSession({
    secret: "mklvjhndasha",
    resave: false,
    saveUninitialized: false
}));

app.use(function(req, res, next) { // Locals
    res.locals.messages = req.flash("success");
    res.locals.errors = req.flash("error");
    next();
});

app.use(UserRoute);

app.use(express.static("assets"));

app.use(bodyParser.urlencoded({
    extended: true
}));

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));


http.listen(2305, function () {
    console.log("Server has started on port 2305".toUpperCase());
});