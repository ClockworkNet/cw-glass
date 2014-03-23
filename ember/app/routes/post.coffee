PostRoute = Em.Route.extend

  model: (params) ->
    @store.find('post', params.post_id)

  # renderTemplate: ->
  #   this.render
  #     into: 'application'
  #     outlet: 'main'

`export default PostRoute`