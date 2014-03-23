###
Please note that Handlebars helpers will only be found automatically by the
resolver if their name contains a dash (reverse-word, translate-text, etc.)
For more details: http://stefanpenner.github.io/ember-app-kit/guides/using-modules.html
###

BoundHelper = Em.Handlebars.makeBoundHelper (word) ->
  word
    .split('')
    .reverse()
    .join('')

`export default BoundHelper`