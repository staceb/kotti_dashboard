$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
marked = require 'marked'

{ MainController } = require 'common/controllers'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'

Views = require './views'

# FIXME add make breadcrumbs behavior to views
class Controller extends MainController
  make_main_content: ->
    view = new Views.FrontDoorMainView
      model: @current_resource
    @_show_content view

  _view_resource: ->
    response = @current_resource.fetch()
    response.done =>
      view = new Views.FrontDoorMainView
        model: @current_resource
      @_show_content view
      data = @current_resource.get('data')
      $('title').text data.attributes.title
      
  view_resource: (resource) ->
    @_set_resource resource
    @_view_resource()

  frontdoor: ->
    @_view_resource()

  start: ->
    @make_main_content()

module.exports = Controller

