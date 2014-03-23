`import UserRoute from 'clockwork/routes/user'`

UserEditRoute = UserRoute.extend
  model: ->
    @modelFor 'user'

  setupController: (controller, model) ->
    route = @
    @store
      .find('account/type')
      .then (data) ->
        route.controllerFor('account/types').set 'content', data

    @store
      .find('credential/type')
      .then (data) ->
        route.controllerFor('credential/types').set 'content', data


    @_super.apply this, arguments

`export default UserEditRoute`