ApplicationRoute = Em.Route.extend Em.SimpleAuth.ApplicationRouteMixin,
  
  actions:
    authenticateSession: ->
      @get('session').authenticate \
      'authenticators:google'

`export default ApplicationRoute`