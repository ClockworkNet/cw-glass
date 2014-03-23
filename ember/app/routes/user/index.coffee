`import UserRoute from 'clockwork/routes/user'`

UserIndexRoute = UserRoute.extend
  model: ->
    @modelFor 'user'

`export default UserIndexRoute`