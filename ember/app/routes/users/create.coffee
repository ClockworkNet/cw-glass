`import UserEditRoute from 'clockwork/routes/user/edit'`

UsersCreateRoute = UserEditRoute.extend
  model: ->
    @store.createRecord 'user'

  renderTemplate: ->
    @render 'user.edit',
      controller: 'users.create'

`export default UsersCreateRoute`