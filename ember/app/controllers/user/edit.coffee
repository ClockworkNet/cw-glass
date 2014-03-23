`import UserController from 'clockwork/controllers/user'`

UserEditController = UserController.extend
  needs: 'account/types'

  saveRelationships: (parent)->

    relationshipPromises = []
    relationships = false
    controller = @

    parent
      .eachRelationship (name, relationship)->
        console.log name, relationship
        return unless relationship.kind is 'hasMany'
        relationships = true
        children = parent.get(name)

        relationshipPromises.push(
            children
              .then (results)->
                results.forEach (result)->
                  controller.saveRelationships(result)
                  console.log 'persisting changes to', result, result.id
                  result.save()

        )

    relationshipPromises.push(parent) unless relationships

    relationshipPromises #returns the promises

  actions:
    
    save: ->
      user                 = @get 'model'
      controller           = @
      relationships        = @saveRelationships(user)

      user.save()

      Em.RSVP.all(relationships, user)
        .then ->
          controller.transitionToRoute 'user', user

    update: ->

      user = @get 'model'
      user.save()

    addAccount: ->

      user = @get 'model'
      self = @
      actType = @get('selectedType')
      fieldTypes = actType.get 'credentialTypes'
      fields = []

      fieldTypes
        .then ->
          fieldTypes.forEach (obj)->
            field = self
              .store
              .createRecord 'credential',
                type  : obj.get 'type'
                title : obj.get 'title'
                protected: obj.get 'protected'

            fields.push(field.save())

      Em.RSVP
        .all(fields)
        .then (records) ->
          account = self.store
              .createRecord 'account',
                title       : actType.get 'title'
                type        : actType.get 'type'

          account
            .save()
            .then (record)->
              record
                .get('credentials')
                .then (credentials)->
                  credentials
                    .pushObjects fields.getEach 'content'
                  record
                    .save()

                .then ()->
                  user
                    .get('accounts')
                    .then (accounts)->
                      accounts
                        .pushObject(record)

                  # user.save() #no saving until we save the user

  types: Ember
            .computed
            .alias('controllers.account/types')

  filteredTypes: (->

      types = @get 'types'
      user = @get 'content'

      types
        .filter (item)->
          return true

    )
    .property('types.content', 'content')
    .cacheable()

  creds: null

  inputType: (->
    console.log this
  )

  selectedType: null

  accountFields: (->
    if @get('selectedType') \
      then @get('selectedType').get('credentialTypes')

  ).property('selectedType').cacheable()

`export default UserEditController`