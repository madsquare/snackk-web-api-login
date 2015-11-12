define [
], (
) ->
    _state = false

    login =
        server : null
        apiModule : null

        init : (server, apiModule) ->
            @server = server
            @apiModule = apiModule
            return

        setLoginState : (boolean) ->
            _state = boolean
            return


        isLoggedIn : () ->
            return _state


		# request authorize
		# login
        login: (provider, user, _callback) ->
            if @server is null 
                console.error 'not initialize server.'
                return

            if @apiModule is null 
                console.error 'not initialize apiModule.'
                return

            server.request(server.TAG.auth.authorize + '/' + provider, {
                data: _.assign(user ,server.fields.user, { sid: apiModule.getSid() })
                type: 'POST'
                success: (res) =>
                    # @set res.user, res.user.permissions
                    apiModule.setToken res.token
                    setLoginState true
                    ## set user in _callback, 앞단에서 아래 코드 추가.
                    # elem = $('<div class="img user"></div>')
                    # utils.setImage elem, user.picture_url

                    # tosqToast.show $.t('toast.login_complete', { 'display_name': user.display_name }), elem 

                    ##

                    _callback.success(res) if _callback && _callback.success
                error: (er) =>
                	## 앞단에서 아래 코드 추가.
                    # if er.type == 'user.incorrect_email'
                    #     tosqToast.showError $.t('form.warning.incorrect_email')
                    # else if er.type == 'user.incorrect_passwd'
                    #     tosqToast.showError $.t('form.warning.incorrect_passwd')
                    _callback.error(er) if _callback && _callback.error
            })

			return


   #      # set user data
   #      setUser: (user, permissions, state) ->
   #          _user = user
   #          server.setUser _user
   #          # store permission
   #          _permissions = if typeof permissions != 'undefined' then permissions else []
			# return

   #          # TODO 논의 필요.
   #          # 앞단에서 아래 코드 추가.
   #          # if !user
   #          #     _usersChannel = []
            
   #          # facebookMgr.setUser user
   #          # if !state
   #          #     mediator.trigger('user/update', user)
   #          # else 
   #          #     mediator.trigger('user/update', user, state)
   #          # if !user
   #          #     youtubeDataMgr.logout()
   #          #     facebookMgr.logout()
		

		# clear user data
		# logout
		logout: () ->
            if @server is null 
                console.error 'not initialize server.'
                return

            if @apiModule is null 
                console.error 'not initialize apiModule.'
                return
                
		    server.request(server.TAG.auth.clear, {
		        data: {}
		        'type': 'POST'
		        complete: () =>
		            apiModule.clear()
                    setLoginState false
		        })
		    return
