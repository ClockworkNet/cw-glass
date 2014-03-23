UsersRoute = Em.Route.extend
  model: ->
    @store.find('user')
    
  activate: ->
    document.title = 'Users'

`export default UsersRoute`