AccountRoute = Em.Route.extend

  model: (params) ->
    @store.find('account', params.user_id)

`export default AccountRoute`