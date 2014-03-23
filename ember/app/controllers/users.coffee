UsersController = Em.ArrayController.extend
  needs: ['application', 'user']
  user: Ember
          .computed
          .alias('controllers.user')

  app: Ember
          .computed
          .alias('controllers.application')

  sortProperties: ['name']

  sortAscending: true
  
  usersCount: (->
    @get('model.length')
  ).property('@each')

  actions:
    loginAs: (user)->
      # console.log user
      @get('app')
        .set('user', user)

    deleteUser: (user)->
      @get('user').set 'content', user
      @get('user').send 'delete'

`export default UsersController`