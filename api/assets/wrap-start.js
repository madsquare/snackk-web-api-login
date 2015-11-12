/**
 * snackk-web-api-api module.
 * v1.0.0
 * https://github.com/madsquare/snackk-web-api-login.git
**/
(function (root, factory) {
	if (typeof define === 'function') {
			define(['jquery', 'jquery-cookie', 'lodash'], factory);
	} else if (typeof exports === 'object') {
		module.exports = factory();
	} else {
		if (typeof root.snackkModule === 'undefined') {
			root.snackkModule = {}
		}
		root.snackkModule.login = factory();
	}
}(this, function () {