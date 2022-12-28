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
    con = require("./DBsql/DB"),
    UserRoute = require("./routes/user.js"),
    StudentRoute = require("./routes/student"),
    CoursesRoute = require("./routes/courses");

app.use(flash());
app.use(methodOverride("_method"));
app.use(expressSession({
    secret: "mklvjhndasha",
    resave: false,
    saveUninitialized: false
}));

app.use(function (req, res, next) { // Locals
    //  req.headers.referrer || req.headers.referer
    //  req.get('Referrer') // They both work
    res.locals.messages = req.flash("success");
    res.locals.errors = req.flash("error");
    next();
});

app.use(bodyParser.urlencoded({
    extended: true
}));

app.use(UserRoute);
app.use(StudentRoute);
app.use("/courses/", CoursesRoute);

app.use(express.static("assets"));

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));


http.listen(2305, function () {
    console.log("Server has started on port 2305".toUpperCase());
    io.on("connection", function (socket) {
        socket.on("searchOfcourses", function (course) {
            if (course) {
                con.query("CALL SearchAllCourses(?)", [course], function (err, result) {
                    socket.emit("coursesSearched", result[0]);
                });
            }
            else {
                con.query("SELECT * FROM courses", function (err, result) {
                    socket.emit("coursesSearched", result);
                });
            }
        });
        /*socket.on("Refer", function(ref) {
            refe = ref;
        });*/
    });
});