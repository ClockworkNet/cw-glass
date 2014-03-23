BoundHelper = Em.Handlebars.makeBoundHelper (date) ->
  moment(date).fromNow();

`export default BoundHelper`