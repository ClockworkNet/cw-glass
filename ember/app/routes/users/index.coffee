`import User from 'clockwork/models/user'`

UsersIndexRoute = Em.Route.extend
  model: (params) ->
    @modelFor 'users'

`export default UsersIndexRoute`