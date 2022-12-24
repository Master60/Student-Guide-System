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
    mysql = require("mysql"),
    UserRoute = require("./routes/user.js");

app.use(flash());
app.use(methodOverride("_method"));
app.use(expressSession({
    secret: "mklvjhndasha",
    resave: false,
    saveUninitialized: false
}));

var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "SQLserverBYmina_2022",
    database: "sgs"
});

app.use(function(req, res, next) { // Locals
    res.locals.messages = req.flash("success");
    res.locals.errors = req.flash("error");
    next();
});

app.use(bodyParser.urlencoded({
    extended: true
}));

app.use(UserRoute);
app.get("/courses", function (req, res, next) {
    con.connect(function (err) {
        con.query("SELECT * From courses", function (err, result) {
            res.render("Nuno Theme Starter Files/courses.ejs", {
                courses: result
            });
        });
    })
});

app.get("/courseinfo/:course", function (req, res, next) {
    con.connect(function (err) {
        con.query("SELECT * From courses, Article, Users, College WHERE CourseID='" + req.params.course +
            "' AND C_Description=ArticleID AND LoginID = userID AND Users.CollegeID = College.CollegeID", function (err, result) {
                con.query("select SemesterName from c_in_semester where c_in_semester.CourseID =" + req.params.course + ";", function (err, Semesters) {
                    con.query("select F_Name , L_Name from Users , teaches where teaches.CourseID  = '"+ req.params.course + "' AND teaches.InstructorID = Users.loginID;", function (err, Names) {
                        res.render("Nuno Theme Starter Files/course info.ejs", {
                            course: result[0],
                            Semester: Semesters,
                            InstructorName :Names
                        });
                    });
                });
            });
    });
});

app.use(express.static("assets"));

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));


http.listen(2305, function () {
    console.log("Server has started on port 2305".toUpperCase());
    io.on("connection", function(socket) {
        socket.on("searchOfcourses", function (course) {
            if (course) {
                con.query("SELECT * FROM courses WHERE Course_Name LIKE '%" + course + "%'", function (err, result) {
                    socket.emit("coursesSearched", result);
                });
            }
            else {
                con.query("SELECT * FROM courses", function (err, result) {
                    socket.emit("coursesSearched", result);
                });
            }
        });
    });
});