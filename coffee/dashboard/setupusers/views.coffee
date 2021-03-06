Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
require 'jquery-ui'
tableDnD = require 'tablednd'

AppTemplates = require './templates'

{ remove_trailing_slashes
  make_json_post } = require 'common/apputil'

Models = require 'common/models'

MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'setupusers'

BootstrapFormView = require 'common/bootstrap_formview'

class DashboardView extends Backbone.Marionette.LayoutView
  template: AppTemplates.user_admin_dashboard
  regions:
    searchform: '#useradmin-search-form'
    userbar: '#useradmin-sidebar'
    usercontent: '#useradmin-content'
    

class SearchUsersView extends BootstrapFormView
  template: AppTemplates.search_users_form
  ui:
    query: 'input[name="query"]'
    
  createModel: ->
    # we can't do "return"
    # new MainChannel.request 'base-kotti-model'
    mclass = MainChannel.request 'base-kotti-model'
    new mclass
    
  updateModel: ->
    @model.url = '/@@setup-users-json'
    @model.set 'query', @ui.query.val()
    @model.set 'search', ""
    
  saveModel: ->
    callbacks =
      success: (model, response) =>
        @onSuccess @model, response
      error: => @trigger 'save:form:failure', @model

    @model.save {}, callbacks

  onSuccess: (model, response) ->
    @render()
    AppChannel.request 'search-results-returned', response.data
    
    

#class SearchResultsView extends Backbone.Marionette.CompositeView
class SearchResultsView extends BootstrapFormView
  template: AppTemplates.search_results_form

  _baseUI: ->
    submit: 'div[type="submit"]'
    activityIndicator: '.spinner'

  createModel: ->
    @model

  updateModel: ->
    window.fview = @
    
    
  
  
module.exports =
  DashboardView: DashboardView
  SearchUsersView: SearchUsersView
  SearchResultsView: SearchResultsView
  
