AccountsRoute = Em.Route.extend
  model: ->
    @store.find('account')

`export default AccountsRoute`