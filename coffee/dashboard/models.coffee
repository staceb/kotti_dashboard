#require 'backbone-jsonapi'
$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'


########################################
# Models
########################################

# This model should be used for all interactions
# with the server, so that messages can be relayed
class BaseKottiModel extends Backbone.Model
  parse: (response, options) ->
    messages = response.meta.messages
    for label of messages
      for msg in messages[label]
        MessageChannel.request 'display-message', msg, label
    #window.kotti_response = response
    #window.kotti_options = options
    super response, options

MainChannel.reply 'base-kotti-model', ->
  BaseKottiModel
  
  
class KottiMessage extends Backbone.Model
  defaults:
    level: 'info'


class KottiMessages extends Backbone.Collection
  model: KottiMessage

class BaseKottiResource extends BaseKottiModel
  url: ->
    "#{@id}/@@json"

  parse: (response, options) ->
    response.oid = response.data.attributes.oid
    super response, options

class AppSettings extends Backbone.Model
  id: 'ittok'

class KottiRootDocument extends BaseKottiModel
  url: "@@json"

class KottiDefaultViewSelector extends Backbone.Model


app_settings = new AppSettings
MainChannel.reply 'main:app:settings', ->
  app_settings


#root_document = new KottiRootDocument
#MainChannel.reply 'main:app:root-document', ->
#  root_document

ResourceChannel.reply 'get-document', (path) ->
  new BaseKottiResource
    id: path

main_message_collection = new KottiMessages
MessageChannel.reply 'messages', ->
  main_message_collection

MessageChannel.reply 'display-message', (msg, lvl) =>
  Message = new Backbone.Model
    content: msg
    level: lvl
  main_message_collection.add Message


MessageChannel.reply 'delete-message', (model) =>
  messages = MessageChannel.request 'messages'
  messages.remove model




module.exports =
  BaseKottiModel: BaseKottiModel
  BaseKottiResource: BaseKottiResource
  KottiMessage: KottiMessage
  AppSettings: AppSettings
  KottiRootDocument: KottiRootDocument

