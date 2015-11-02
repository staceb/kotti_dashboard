$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'


Util = require '../apputil'

{ MainController } = require '../controllers'

Views = require './views'

Models = require '../models'

MainChannel = Backbone.Radio.channel 'global'
ResourceChannel = Backbone.Radio.channel 'resources'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'setupusers'



class Controller extends MainController
  _update_views_common: ->
    @_make_editbar()
    @_make_breadcrumbs()
    @_setup_dashboard()
    
    
  _setup_dashboard: ->
    content = @_get_region 'content'
    console.log "content.currentView", content.currentView
    if content.currentView instanceof Views.DashboardView
      return
    console.log "Create dashboard layout"
    view = new Views.DashboardView
    @_show_content view
    @layout = view
    #window.udashboard = view
      
    
    
  setup_users: ->
    console.log "Setup users"
    @_update_views_common()
    #view = new Views.SetupUsersMainView
    #  model: new Backbone.Model
    view = new Views.SearchUsersView
    searchform = @layout.regionManager.get 'searchform'
    searchform.show view
    
  display_search_results: (data) ->
    @_update_views_common()
    #console.log "display_search_results", data
    model = new Backbone.Model data
    view = new Views.SearchResultsView
      model: model
    usercontent = @layout.regionManager.get 'usercontent'
    usercontent.show view
     
    
module.exports = Controller

