var express = require("express"),
    router = express.Router()
app = express(),
    bodyParser = require("body-parser"),
    http = require("http").createServer(app),
    io = require("socket.io")(http),
    //localStrategy = require("passport-local"),
    expressSession = require("express-session"),
    methodOverride = require("method-override"),
    sql = require("msnodesqlv8"),
    //route = "",
    //refe = "",
    //rout = "",
    flash = require("connect-flash");

app.use(flash());
app.use(methodOverride("_method"));
app.use(expressSession({
    secret: "mklvjhndasha",
    resave: false,
    saveUninitialized: false
}));

app.use(express.static("assets"));

app.use(bodyParser.urlencoded({
    extended: true
}));

app.set("view engine", "ejs");



const connectioString = "server=192.168.56.1;Database=Hospital;Trusted_Connection=Yes;Driver={SQL Server Native Client 11.0}";
const query = "SELECT * from dbo.Doctor";


app.get("/", function (req, res) {
    sql.query(connectioString, query, (err, rows) => {
        res.render("dehk", {
            row: rows
        });
    });
});

http.listen(2305, function () {
    console.log("Server has started on port 2305".toUpperCase());
});