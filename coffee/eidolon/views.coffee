Backbone = require 'backbone'
Marionette = require 'backbone.marionette'


NavTemplates = require './templates'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

class BootstrapNavBarView extends Backbone.Marionette.LayoutView
  template: NavTemplates.nav_pt
  regions:
    usermenu: '#user-menu'
    mainmenu: '#main-menu'

class MainSearchFormView extends Backbone.Marionette.ItemView
  template: NavTemplates.nav_pt_search

  
module.exports =
  MainSearchFormView: MainSearchFormView
  BootstrapNavBarView: BootstrapNavBarView
