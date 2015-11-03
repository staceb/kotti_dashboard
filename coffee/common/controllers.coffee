$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
marked = require 'marked'

Util = require 'common/apputil'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'

class BaseController extends Backbone.Marionette.Object
  init_page: () ->
    # do nothing
  scroll_top: Util.scroll_top_fast
  navigate_to_url: Util.navigate_to_url
  navbar_set_active: Util.navbar_set_active

class MainController extends BaseController
  _get_region: (region) ->
    MainChannel.request 'main:app:get-region', region

  _show_content: (view) ->
    content = @_get_region 'content'
    content.show view

  _set_resource: (resource) ->
    if resource == null
      id = ""
    else
      if resource[0] == '/'
        id = resource
      else
        id = "/#{resource}"
    @resource_id = id
    if DEBUG 
      console.log "Resource_Id is ", @resource_id
    @root_doc = ResourceChannel.request 'get-document', @resource_id

module.exports =
  BaseController: BaseController
  MainController: MainController

