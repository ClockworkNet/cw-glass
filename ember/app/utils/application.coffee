ApplicationView = Em.View.extend

  didInsertElement: ->

    Em.run.scheduleOnce 'afterRender', this, ->
      Em.$('.selectpicker')
        .selectpicker()

      drawers   = $ '.drawer'
      drawers.on 'click', 'a', ->
        drawers
          .filter('.in')
          .collapse('hide')

      Em.$('.dropdown-toggle').dropdown()
    # Em.$('body')\
    #   .on('touchmove', (e) -> 
    #     console.log $('.content').scrollTop()
    #   ).on('show.bs.dropdown', (e)->
    #     console.log 'foo'
    #   )
    #

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
      from      = if target.hasClass 'left' then 'left' else 'right'

      viewport.addClass "from-#{ from }"
      target.addClass 'collapsing-in'
      statusbar.addClass 'black'

    'hide.bs.collapse': (e)->
      viewport  = $ '.viewport'
      statusbar = $ '.status-bar'
      target    = $ e.target
      from      = if target.hasClass 'left'? then 'left' else 'right'

      viewport.removeClass 'from-right from-left'
      target.addClass 'collapsing-out'
      statusbar.removeClass 'black'


`export default ApplicationView`
