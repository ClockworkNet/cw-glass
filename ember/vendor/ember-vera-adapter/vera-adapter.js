DS.VeraAdapter = DS.RESTAdapter.extend({

  login: null,
  
  password: null,

  typeKey: null,
  
  findAll: function(store, type, sinceToken) {
    var query;
    return this.ajax(
      this.buildURL(type.typeKey),
      'POST',
      sinceToken,
      type.typeKey);
  },
  findMany: function(store, type, ids) {
    return this.ajax(
      this.buildURL(type.typeKey),
      'POST',
      null,
      type.typeKey,
      ids
    );
  },
  find: function(store, type, id) {
    return this.ajax(
        this.buildURL(type.typeKey),
        'POST',
        null,
        type.typeKey,
        id
      );
  },
  ajax: function(url, type, since, typeKey, ids){

    var adapter = this,
        url     = 'https://home.drewcovi.com:3000/mios';

    if(! typeKey ){
      return false;
    }

    return new Ember.RSVP.Promise( function(resolve, reject){

      var hash = adapter.ajaxOptions(url, type, hash);

      hash.success = function(json){
        var json    = {
                devices: json.devices,
                rooms: json.rooms,
                scenes: json.scenes,
                sections: json.sections,
                categories: json.categories
              },
            plural   = Em.String.pluralize(typeKey),
            response = {},
            i, l, key, record, prop, models, ii;

        for(key in json){
          var dataset = json[key];
          for(i = 0; i < dataset.length; i++){
            record = dataset[i];
            for(prop in record){
              for(models in json){
                if(prop === Em.String.singularize(models)){
                  for(ii=0; ii < json[models].length; ii++){
                    if(json[models][ii]['id'] === record[prop]){
                      json[models][ii][key] = json[models][ii][key] || [];
                      if(json[models][ii][key].indexOf(record['id']) < 0)
                        json[models][ii][key].push(record['id']);
                    }
                  }
                }
              }
            }
          }
        }
        // for individual lookups
        // values = json[plural];
        // if(!ids){
        //   // no ids return all
        //   response[plural] = values;
        // }else{
        //   // ids provided, find all records in set
        //   response[plural] = [];
        //   for(i=0; i<ids.length; i++){
        //     for(ii=0; ii<values.length; ii++){
        //       if(values[ii]['id'] == ids[i])
        //         response[plural].push(values[ii]);
        //     }
        //   }
        // }
        // sideload it all
        Em.run(null, resolve, json);
      };

      hash.error = function(jqXHR, textStatus, errorThrown){
        Em.run(null, reject, adapter.ajaxError('The server is busy or the url is unset'));
      };

      hash.data = {
        "login": adapter.get('login'),
        "password": adapter.get('password')
      };
      
      Ember.$.ajax(hash);

    }, "DS: RestAdapter#ajax " + type + " to " + url);
  }

});