UserRoute = Em.Route.extend

  model: (params) ->
    @store.find('user', params.user_id)

`export default UserRoute`