CredentialTypesRoute = Em.Route.extend

  beforeModel: (model)->
    adapter = @get('container').lookup 'adapter:credential/type'

  model: (params) ->
    @store.find 'credential/type'

  renderTemplate: (controller, model)->
    controller = @controllerFor 'credential/types'
    @render 
      controller: controller
      template: 'credential/types'

`export default CredentialTypesRoute`