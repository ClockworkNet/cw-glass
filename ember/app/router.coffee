# ensure we don't share routes between all Router instances
Router = Em.Router.extend()

# Router.reopen
#   location: 'history'

Router.map ->
  @route 'component-test'
  @route 'helper-test'
  @route 'portfolio'
  @resource 'posts', ->
    @resource 'post',
      path: '/:post_id'
  @resource 'credential', ->
    @route 'types'
  @resource 'users', ->
    @resource 'user',
      path: '/:user_id', ->
        @route 'edit'
    @route 'create'
  @route 'test'
  @route 'login'
  @route 'mirror'

`export default Router`