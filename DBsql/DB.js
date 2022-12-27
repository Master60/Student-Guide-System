var mysql = require("mysql")
var fs = require('fs');
const env = require("dotenv").config();


var con = mysql.createConnection({ host: process.env.HOST, 
user: process.env.USER, password: process.env.PASSWORD,
 database: process.env.DATABASE, 
 port: process.env.PORT,
 ssl:{ca:fs.readFileSync(process.env.SSL_CERT)}
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