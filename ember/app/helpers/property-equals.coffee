Equals = Em.Handlebars.makeBoundHelper (left, right, options) ->
  if arguments.length < 3
    throw new Error "Handlebars Helper equal needs 2 parameters"
  else if left!=right
      options.inverse(this)
  else
      options.fn(this)

`export default Equals`