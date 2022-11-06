const bcrypt = require("bcrypt"),
encryptObject = {};

encryptObject.encrypt = function(pw, insert) {
    bcrypt.genSalt(14, function (err, salt) {
        if (err) {
            console.log(err);
        }
        else {
            bcrypt.hash(pw, salt, function(err, encrypt) {
                if (err) {
                    console.log(err);
                }
                else {
                    insert(encrypt);
                    //return encrypt;
                }
            });
        }
    })
}

encryptObject.compare = function(PW, hash, search) {
    bcrypt.compare(PW, hash, function(err, same) {
        if (err) {
            console.log(err);
        }
        else {
            search(same);
        }
    });
}

module.exports = encryptObject;