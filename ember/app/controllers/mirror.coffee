mixins = Em.SimpleAuth.AuthenticationControllerMixin

MirrorController = Em.Controller.extend mixins,

  mirrorSend: (endpoint, payload)->
    token = "#{@get 'session.tokenType'} #{@get 'session.accessToken'}"
    Em.$.ajax 
      type: 'post'
      contentType: 'application/json'
      dataType: 'json'
      url: 'https://www.googleapis.com/mirror/v1/' + endpoint
      beforeSend: (xhr) ->
        authorization = token
        xhr.setRequestHeader 'Authorization', authorization
      data: JSON.stringify payload

  actions:
    timelineInsert: ->
      message = @get 'message'
      html = @get 'html'
      payload =
        text: message
        html: html
      @mirrorSend 'timeline', payload



`export default MirrorController`