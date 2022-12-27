var mysql = require("mysql")
var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "SQLserverBYmina_2022",
    database: "sgs"
});

con.connect(function(err) {
    if (err) {
        console.log(err);
    }
    else {
        console.log("successful connection");
    }
});

module.exports = con;