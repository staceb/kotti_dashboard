Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Util = require './apputil'

class BootStrapAppRouter extends Backbone.Marionette.AppRouter
  onRoute: (name, path, args) ->
    Util.navbar_set_active path

module.exports = BootStrapAppRouter
