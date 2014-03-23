IndexRoute = Em.Route.extend
  
  setupController: (controller, model)->
    @_super.apply this, arguments
    if not document.location.href.match(/^http/)
      window.deviceready
        .done ->
          com.rossgerbasi.cordova.glass.core.getLaunchParams \
            (results) ->
              controller.set 'status', 'got launch params'
              controller.set 'command', results[0]
            , ->
              console.log("Error getting launch Params")

  model: ->
    ['red', 'yellow', 'blue']


`export default IndexRoute`