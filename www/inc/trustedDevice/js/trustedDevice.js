var exec = require('cordova/exec');

exports.isTrusted = function(success, fail) {
    exec(success, fail, "trustedDevice", "isTrusted", []);
};
