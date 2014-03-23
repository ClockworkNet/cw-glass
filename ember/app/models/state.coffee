State = DS.Model.extend
  serviceId    : DS.attr 'number'
  device       : DS.belongsTo 'device'
  service      : DS.attr 'string'
  variable     : DS.attr 'string'
  value        : DS.attr 'string'

`export default State`
