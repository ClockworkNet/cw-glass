ApplicationView = Em.View.extend

  didInsertElement: ->

    Em.run.scheduleOnce 'afterRender', this, ->
      drawers   = $ '.drawer'
      drawers.on 'click', 'a', ->
        drawers
          .filter('.in')
          .collapse('hide')

  eventManager:

    'shown.bs.collapse': (e)->
      target    = $ e.target
      target.removeClass 'collapsing-in'

    'hidden.bs.collapse': (e)->
      target    = $ e.target
      target.removeClass 'collapsing-out'
    
    'show.bs.collapse': (e)->
      viewport  = $ '.viewport'
      statusbar = $ '.status-bar'
      target    = $ e.target
      from      = if target.hasClass 'left'? then 'left' else 'right'

      viewport.addClass "from-#{ from }"
      target.addClass 'collapsing-in'
      statusbar.addClass 'black'

    'loaded.gapi.auth': ->
      console.log 'gapi loaded.'

    'hide.bs.collapse': (e)->
      viewport  = $ '.viewport'
      statusbar = $ '.status-bar'
      target    = $ e.target
      from      = if target.hasClass 'left'? then 'left' else 'right'

      viewport.removeClass 'from-right from-left'
      target.addClass 'collapsing-out'
      statusbar.removeClass 'black'


`export default ApplicationView`