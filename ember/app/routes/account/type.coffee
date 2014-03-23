AccountTypesRoute = Em.Route.extend

  beforeModel: (model)->
    adapter = @get('container').lookup 'adapter:account/type'

`export default AccountTypesRoute`