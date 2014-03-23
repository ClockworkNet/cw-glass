PostsRoute = Em.Route.extend

  model: ->
    @store.find 'post'

`export default PostsRoute`