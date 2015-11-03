Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Util = require 'common/apputil'
BootStrapAppRouter = require 'common/bootstrap_router'

Controller = require './controller'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'


class Router extends BootStrapAppRouter
  appRoutes:
    '': 'view_resource'
    'frontdoor': 'view_resource'
    'frontdoor/view': 'view_resource'
    'frontdoor/view/*resource': 'view_resource'

MainChannel.reply 'applet:frontdoor:route', () ->
  if __DEV__ then console.log "frontdoor:route being handled"
  controller = new Controller MainChannel
  controller.current_resource = ResourceChannel.request 'current-document'
  router = new Router
    controller: controller

