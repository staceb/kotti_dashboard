Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Util = require 'common/apputil'
BootStrapAppRouter = require 'common/bootstrap_router'

Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'
AppChannel = Backbone.Radio.channel 'editcontents'



class Router extends BootStrapAppRouter
  appRoutes:
    'editor/contents': 'manage_contents'
    'editor/contents/*resource': 'manage_contents'
    
    'editor/edit': 'ace_edit_node'
    'editor/edit/*resource': 'ace_edit_node'
    
    'editor/ace-edit': 'ace_edit_node'
    'editor/ace-edit/*resource': 'ace_edit_node'
    
    'editor/hallo-edit': 'hallo_edit_node'
    'editor/hallo-edit/*resource': 'hallo_edit_node'

    'editor/addnode': 'add_node'
    'editor/addnode/*resource': 'add_node'

    'editor/add_:content_type': 'add_node'
    'editor/add_:content_type/*resource': 'add_node'

    
    
MainChannel.reply 'applet:editcontents:route', () ->
  if __DEV__ then console.log "editcontents:route being handled"
  controller = new Controller MainChannel
  controller.current_resource = ResourceChannel.request 'current-document'
  router = new Router
    controller: controller
  AppChannel.reply 'contents-changed', =>
    controller.manage_contents controller.resource_id
    

  
