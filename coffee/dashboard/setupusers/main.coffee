Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Util = require 'common/apputil'
BootStrapAppRouter = require 'common/bootstrap_router'

Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'
AppChannel = Backbone.Radio.channel 'setupusers'



class Router extends BootStrapAppRouter
  appRoutes:
    'setupusers': 'setup_users'
    'setupusers/': 'setup_users'
    
    
MainChannel.reply 'applet:setupusers:route', () ->
  if __DEV__ then console.log "setupusers:route being handled"
  controller = new Controller MainChannel
  controller.current_resource = ResourceChannel.request 'current-document'
  router = new Router
    controller: controller
  AppChannel.reply 'search-results-returned', (data) =>
    controller.display_search_results data
    

  
