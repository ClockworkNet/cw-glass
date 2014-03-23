PostsAdapter = DS.RESTAdapter.extend

  host: 'http://drewcovi.local/api'

  buildURL: (type, id) ->
    url = []
    host = Em.get this, 'host'
    prefix = this.urlPrefix()

    if id
      url.push 'get_post'
    else
      url.push 'get_posts'

    url.push id if id
    url.unshift prefix if prefix
    url = url.join '/'
    url = '/' + url if !host && url

    return url

  ajax: (url, type, hash) ->
    adapter = this;

    new Ember.RSVP.Promise ((resolve, reject) ->
      hash = adapter.ajaxOptions(url, type, hash)

      hash.success = (json) ->
        delete json.count
        delete json.count_total
        delete json.pages
        delete json.status
        delete json.query
        console.log json
        Ember.run(null, resolve, json)

      hash.error = (jqXHR, textStatus, errorThrown) ->
        Ember.run(null, reject, adapter.ajaxError(jqXHR))

      Ember.$.ajax(hash);
    ), "DS: RestAdapter#ajax " + type + " to " + url

`export default PostsAdapter`