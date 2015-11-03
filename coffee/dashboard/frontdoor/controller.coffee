$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
marked = require 'marked'

{ DashboardController } = require '../controllers'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'

Views = require './views'

class Controller extends DashboardController
  make_main_content: ->
    @_make_editbar()
    @_make_breadcrumbs()
    #console.log "Make_Main_Content"
    view = new Views.FrontDoorMainView
      model: @root_doc
    @_show_content view

  _view_resource: ->
    #console.log "Fetch from", @root_doc.url()
    response = @root_doc.fetch()
    response.done =>
      @_make_editbar()
      @_make_breadcrumbs()
      view = new Views.FrontDoorMainView
        model: @root_doc
      @_show_content view
      data = @root_doc.get('data')
      $('title').text data.attributes.title
  view_resource: (resource) ->
    #console.log "RESOURCE", resource
    @_set_resource resource
    @_view_resource()

  frontdoor: ->
    @_view_resource()

  start: ->
    #console.log 'controller.start called'
    @make_main_content()
    #console.log 'frontdoor started'

module.exports = Controller

