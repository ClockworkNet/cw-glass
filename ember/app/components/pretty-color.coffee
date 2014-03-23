PrettyColor = Ember.Component.extend
  classNames: ['pretty-color']

  attributeBindings: ['style']

  style: (->
      'color: ' + this.get('name') + ';'
    ).property('name')

`export default PrettyColor`
