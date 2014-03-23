ApplicationController = Em.ObjectController.extend
  
  needs: ['user','users']

  users: Ember
            .computed
            .alias('controllers.users')

  user: null
  
  dialog:
    active: false

  dialogActive: (->
    active = @get 'dialog.active'
    return active
    ).property('dialog.active').cacheable()

  hasMiOS: (->
      if @get 'user'
        @get('user.accounts').filterBy('type','mios').length
      
    ).property('user.accounts.@each')

  hasGUTS: (->
      if @get 'user'
        @get('user.accounts').filterBy('type','guts').length
      
    ).property('user.accounts.@each')

  isNative: not document.location.href.match(/^http/)

  actions:

    dialogConfirm: ->
      controller = @get 'dialog.controller'
      action     = @get 'dialog.confirm'
      controller.send action
      @send 'dialogClear'

    dialogCancel: ->
      controller = @get 'dialog.controller'
      action     = @get 'dialog.cancel'
      controller.send action
      @send 'dialogClear'

    dialogClear: ->
      controller = @
      controller.set 'dialog.active', false

      # clean up dialog object not really needed
      # Em.run.later ->
      #   controller.set 'dialog', active: false
      # , 300


    dialog: (dialog)->
      @set 'dialog',
        controller: dialog.controller
        confirm: dialog.confirm.action
        cancel: dialog.cancel.action
        title: dialog.title
        content: dialog.content
        active: true
        confirmTitle: dialog.confirm.title
        cancelTitle: dialog.cancel.title

      false



`export default ApplicationController`