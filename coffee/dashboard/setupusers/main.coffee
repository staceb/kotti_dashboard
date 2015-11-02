Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Util = require '../apputil'
BootStrapAppRouter = require '../bootstrap_router'

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
  console.log "setupusers:route being handled"
  controller = new Controller MainChannel
  controller.root_doc = ResourceChannel.request 'current-document'
  router = new Router
    controller: controller
  AppChannel.reply 'search-results-returned', (data) =>
    controller.display_search_results data
    

  
