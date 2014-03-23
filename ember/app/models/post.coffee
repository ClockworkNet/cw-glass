Post = DS.Model.extend
  content: DS.attr 'string'
  title: DS.attr 'string'
  excerpt: DS.attr 'string'
  thumbnail: DS.attr 'string'

`export default Post`