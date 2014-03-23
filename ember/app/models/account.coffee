Account = DS.Model.extend
  type          : DS.attr 'string'
  title         : DS.attr 'string'
  user          : DS.belongsTo 'user'
  credentials   : DS.hasMany 'credential',
                    async: true

Account.typeKey = 'account'

`export default Account`