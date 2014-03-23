`import UserEditController from 'clockwork/controllers/user/edit'`

UsersCreateController = UserEditController.extend

  actions:
    
    save: ->
      controller           = @
      user                 = @get 'model'
      # user                 = @store.createRecord 'user'
      relationships        = @saveRelationships(user)

      user.set 'creationDate', new Date()

      user.save()

      Em.RSVP.all(relationships, user)
        .then ->
          controller.transitionToRoute 'user', user
      # user
      #   .save()
      #   .then (model)->
      #     console.log 'done'
      #     self.transitionToRoute 'user', user

`export default UsersCreateController`