Credential = DS.Model.extend
  type         : DS.attr 'string'
  value        : DS.attr 'string'
  protected    : DS.attr 'boolean'
  title        : DS.attr 'string'
  account      : DS.belongsTo 'account',
                    async: true

Credential.typeKey = 'credential'

`export default Credential`
