`import Resolver from 'ember/resolver'`

App = Em.Application.extend
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  customEvents: 
    'show.bs.collapse'    : 'show.bs.collapse'
    'hide.bs.collapse'    : 'hide.bs.collapse'
    'hidden.bs.collapse'  : 'hidden.bs.collapse'
    'shown.bs.collapse'   : 'shown.bs.collapse'

  modulePrefix: 'clockwork' # TODO: loaded via config
  Resolver: Resolver['default']

App.GoogleAuthenticator = Em.SimpleAuth.Authenticators.Base.extend
    restore: (properties) ->
      console.log 'restoring'
      new Ember.RSVP.Promise (resolve, reject) ->
        if !Ember.isEmpty(properties.accessToken)
          resolve(properties)
        else
          reject()

    authenticate: () ->
      return new Ember.RSVP.Promise (resolve, reject) ->
        config =
          client_id: '409640544123-1jqf25pdmlh4cnrci9p5aaaar5td96e4.apps.googleusercontent.com'
          scope: 'email profile'
        console.log gapiPromise
        gapiPromise
          .then ->
            console.log 'gapi loaded!'
            gapi.auth.authorize config, ->
                authData = gapi.auth.getToken()
                console.log authData
                resolve
                  accessToken: authData.access_token
                  tokenType: authData.token_type

App.initializer
    name: 'authentication'
    initialize: (container, application) ->
      container.register 'authenticators:google', App.GoogleAuthenticator
      Em.SimpleAuth.setup container, application

Ember.RSVP.configure 'onerror', (error) ->
  ### ensure unhandled promises raise awareness.
  may result in false negatives, but visibility is more important
  ###
  if error instanceof Error
    Ember.Logger.assert(false, error)
    Ember.Logger.error(error.stack)


# Em.SimpleAuth.Authenticators.OAuth2.reopen

#   serverTokenEndpoint: 'https://accounts.google.com/o/oauth2/auth'

DS.DebugAdapter.reopen
  getModelTypes: ->
    self = this
    Em.keys(requirejs._eak_seen).filter (key)->
      match = key.match /models\//
      requireModule = self.detect require(key).default
      !! match and requireModule
    .map (key)->
      type = require(key).default
      typeKey = key.match(/models\/(.*)/)[1]
      type.toString = (-> typeKey)
      type

# DS.LSAdapter = DS.LSAdapter.extend

DS.Model.reopenClass
  toString: ->
    @typeKey

DS.IndexedDBAdapter = DS.IndexedDBAdapter.extend

  deleteRecord: (store, type, record) ->
    _this = this;

    new Ember.RSVP.Promise (resolve, reject) ->
      modelName = type.toString()
      serializedRecord = record.serialize({includeId: true})
      id = serializedRecord.id

      _this
        .openDatabase()
        .then (db) ->
          transaction = db.transaction modelName, "readwrite"

          transaction.onerror = (event) ->
            Em.run ()->
              console.error('transaction error: ' + event) if Ember.testing

          transaction.onabort = (event) ->
            Em.run () ->
              console.error('transaction aborted: ' + event) if Ember.testing

          objectStore = transaction.objectStore(modelName)

          transaction.oncomplete = (t) ->
              resolve()
              db.close()

          id = parseInt(id) if objectStore.autoIncrement

          operation = objectStore.delete(id)
          operation.onsuccess = (event) ->
            db.close()
            resolve()

          operation.onerror = (event) ->
            Em.run ()->
              db.close()
              reject(event.target.result)

window.addEventListener 'load', ->
  FastClick.attach document.body

injectScript = (url, onload, onerror) ->
  script = document.createElement 'script'
  script.onload = onload;
  script.onerror = onerror || onload;
  script.src = url;
  document.head.appendChild script

if not document.location.href.match(/^http/)
  html = $ 'html'
  window.deviceready = Em.$.Deferred()

  injectScript 'cordova.js'
  html.addClass 'native'

  document.addEventListener 'deviceready', ->
    # status = StatusBar
    window.deviceready.resolve()

`export default App`