ModalDialog = Ember.Component.extend

  active: false

  visible: (->
    # console.log 'active changed on component'
    dialog = @.$().children()
    if @get 'active'
      dialog.modal 'show'
    else
      dialog.modal 'hide'
  ).observes('active')

  actions:

    confirm: ->
      @send 'dismiss'
      @sendAction 'confirm'

    cancel: ->
      @send 'dismiss'
      @sendAction 'cancel'

`export default ModalDialog`
