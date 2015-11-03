$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
marked = require 'marked'

MainViews = require './views'
Util = require 'common/apputil'

{ MainController } = require 'common/controllers'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'

class DashboardController extends MainController
  _make_editbar: ->
    data = @root_doc.get 'data'
    user = data.relationships.meta.current_user
    #console.log "_make_editbar", data
    editbar = @_get_region 'editbar'
    # should have better way to check user?
    if user and 'title' of user
      #window.editbar = editbar
      view = new MainViews.EditBarView
        model: @root_doc
      editbar.show view
    else
      editbar.empty()

  _make_breadcrumbs: ->
    data = @root_doc.get 'data'
    breadcrumbs = data.relationships.meta.breadcrumbs
    bc = @_get_region 'breadcrumbs'
    if breadcrumbs.length > 1
      view = new MainViews.BreadCrumbView
        model: @root_doc
      bc.show view
    else
      bc.empty()

module.exports =
  DashboardController: DashboardController

