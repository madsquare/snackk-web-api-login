define [
	'lodash'
], (
	_
) ->
	_state = false

	login =
		server : null
		tokenModule : null


		###
		 * login module init
		 * @param  {object} server      
		 * @param  {object} tokenModule 
		###
		init : (server, tokenModule) ->
			@server = server
			@tokenModule = tokenModule
			return


		###
		 * 로그인 상태 저장.
		 * @param {Boolean} boolean 
		###
		setLoginState : (boolean) ->
			_state = boolean
			return


		###
		 * 로그인 상태 반환.
		 * @return {Boolean} return loginState
		###
		isLoggedIn : () ->
			return _state


		###
		 * 로그인.
		 * @param  {string} provider  	tosq, facebook, googleplus, etc...
		 * @param  {object} user      	id, passwd, token
		 * @param  {object} callback	return res, error
		 * @param  {object} options   	fileds
		 * @return {object}           	ajax 
		###
		login: (provider, user, callback, options) ->
			if @server is null 
					console.error 'not initialize server.'
					return

			if @tokenModule is null 
					console.error 'not initialize tokenModule.'
					return

			options = {} if not options
			@server.request(@server.TAG.auth.authorize + '/' + provider, {
				data: _.assign(user, options, { sid: @tokenModule.getSid() })
				type: 'POST'
				success: (res) =>
					@tokenModule.setToken res.token
					@setLoginState true
					callback.success(res) if callback && callback.success
				error: (er) =>
					callback.error(er) if callback && callback.error
			})


		###
		 * 로그아웃.
		 * @param  {object} callback 	return res, error
		 * @return {object}           	ajax
		###
		logout: (callback) ->
			if @server is null 
				console.error 'not initialize server.'
				return

			if @tokenModule is null 
				console.error 'not initialize tokenModule.'
				return

			@server.request(@server.TAG.auth.clear, {
				data: {}
				'type': 'POST'
				success: (res) =>
					callback.success(res) if callback && callback.success
				error: (er) =>
					callback.error(er) if callback && callback.error
				complete: () =>
					@tokenModule.clear()
					@setLoginState false
					callback.complete() if callback && callback.complete
			})

	return login
