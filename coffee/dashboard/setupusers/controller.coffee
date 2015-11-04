$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'


Util = require 'common/apputil'

{ MainController } = require 'common/controllers'

Views = require './views'

Models = require 'common/models'

MainChannel = Backbone.Radio.channel 'global'
ResourceChannel = Backbone.Radio.channel 'resources'
MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'setupusers'



class Controller extends MainController
  _update_views_common: ->
    MainChannel.request 'make-editbar', @current_resource
    MainChannel.request 'make-breadcrumbs', @current_resource
    @_setup_dashboard()
    
    
  _setup_dashboard: ->
    content = @_get_region 'content'
    if content.currentView instanceof Views.DashboardView
      return
    view = new Views.DashboardView
    @_show_content view
    @layout = view
      
    
    
  setup_users: ->
    @_update_views_common()
    view = new Views.SearchUsersView
    searchform = @layout.regionManager.get 'searchform'
    searchform.show view
    
  display_search_results: (data) ->
    @_update_views_common()
    model = new Backbone.Model data
    view = new Views.SearchResultsView
      model: model
    usercontent = @layout.regionManager.get 'usercontent'
    usercontent.show view
     
    
module.exports = Controller

