$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Models = require './models'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'


class BaseCollection extends Backbone.Collection
  # wrap the parsing to retrieve the
  # 'data' attribute from the json response
  parse: (response) ->
    return response.data

  
module.exports =
  BaseCollection: BaseCollection
  


