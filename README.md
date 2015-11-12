# snackk-web-api-login

## require
* lodash

## not amd
```
window.snackkModule.login
```

## functions
login:
* init
* setLoginState
* isLoggedIn
* login
* logout

## example
```
loginModule.init server, tokenModule
loginModule.login 'tosq', {
	'email': 'xxx@madsq.net'
	'passwd': '123123'
}, {
  'success': (res) =>
    debugger
  'error': (er) =>
    debugger
}
```


