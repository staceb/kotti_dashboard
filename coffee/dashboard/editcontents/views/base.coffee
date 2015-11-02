Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
require 'jquery-ui'
require 'tag-it'

AppTemplates = require '../templates'


MainChannel = Backbone.Radio.channel 'global'

BootstrapFormView = require '../../bootstrap_formview'

class BaseKottiResourceFormView extends BootstrapFormView
  saveModel: ->
    callbacks =
      success: => @trigger 'save:form:success', @model
      error: => @trigger 'save:form:failure', @model
      patch: true
    @model.save @model.attributes, callbacks
    
  _baseUI: ->
    submit: 'input[type="submit"]'
    activityIndicator: '.spinner'
    title: 'input[name="title"]'
    description: 'input[name="description"]'
    tags: 'input[name="tags"]'

    
  onDomRefresh: ->
  #  FIXME implement tags
  #  console.log "onDomRefresh, BaseKottiResourceFormView", @ui
  #  @ui.tags.tagit
  #    availableTags: []
  #    allowSpaces: true
    
module.exports = 
  BaseKottiResourceFormView: BaseKottiResourceFormView
