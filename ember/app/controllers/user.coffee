UserController = Em.ObjectController.extend
  needs: 'application'

  app: Ember
          .computed
          .alias('controllers.application')

  trash: []



  deleteAccounts: ->
    controller = @

    @get('accounts')
      .then (accounts) ->
        queue = []
        accounts
          .forEach (account)->
            relationships = controller.deleteAccount(account)
            queue.pushObject(relationships)

        queue

  deleteAccount : (account)->
      credentials = account.get('credentials')
      controller = @
      model = @get 'model'

      credentials
        .then (credentials)->
          credentials.forEach (cred) ->
            cred.deleteRecord()
            controller.get('trash').pushObject(cred)

          account.deleteRecord()
          controller.get('trash').pushObject(account)

          model
            .get('accounts')
            .then (accounts)->
              console.log accounts
              accounts.removeObject(account)

  persist: ->
    next = @get('trash').pop()
    controller = @
    return unless next
    next.save().then ->
      controller.persist()

  deleteUser: ->
    app = @get 'app'
    name = @get('model').get('name')
    dialog = 
      controller : @
      confirm    :
                  title: 'Heck yes!'
                  action: 'confirmDelete'
      cancel     : 
                  title: 'No thanks'
                  action: 'cancelDelete'
      title      : 'Delete User'
      content    : "Are you sure you want to delete #{name}"

    app
      .send 'dialog', dialog

  actions:
    edit: ->
      @transitionToRoute 'user.edit'

    delete: ->
      @deleteUser()

    cancelDelete: ->
      # nothing happens when we cancel delete

    confirmDelete: ->
      model = @get('model')
      controller = @

      model.deleteRecord()
      @get('trash').pushObject(model)

      relationships = [@deleteAccounts()]

      Em.RSVP.all(relationships)
        .then ->
          queue = []
          queue.push(controller.persist())
          Em.RSVP.all(queue)
            .then ->
              controller.transitionToRoute 'users'

    loginAs: ->
      @get('app')
        .set('user', @get('model'))    



`export default UserController`