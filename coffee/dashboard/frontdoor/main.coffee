Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Util = require 'apputil'
BootStrapAppRouter = require 'bootstrap_router'

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
  #console.log "frontdoor:route being handled"
  controller = new Controller MainChannel
  controller.root_doc = ResourceChannel.request 'current-document'
  router = new Router
    controller: controller

