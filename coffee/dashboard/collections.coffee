$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Models = require 'common/models'
{ BaseCollection } = require 'common/collections'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'


class KottiClipboard extends Backbone.Collection
  # initialize copy_status with "copy"
  copy_status: 'copy'

  _add_models: (models, command) ->
    @reset()
    @add models
    @copy_status = command
    
  copy: (models) ->
    @_add_models models, 'copy'

  cut: (models) ->
    @_add_models models, 'cut'

  paste: () ->
    # copy models
    models = @.models.slice()
    # empty collection
    @reset()
    # return models
    models

kotti_clipboard = new KottiClipboard
MainChannel.reply 'main:app:kotti-clipboard', ->
  kotti_clipboard
  
class ContentsModel extends Models.BaseKottiResource
  idAttribute: 'oid'
  
class KottiContents extends BaseCollection
  model: ContentsModel
  url: ->
    "#{@resource_id}/@@contents-json"


ResourceChannel.reply 'get-document-contents', (resource_id) ->
  # if resource_id is null, set to root resource
  resource_id ?= ''
  collection = new KottiContents
  collection.resource_id = resource_id
  collection
  

  
module.exports = KottiClipboard


