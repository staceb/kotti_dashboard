Backbone = require 'backbone'
Marionette = require 'backbone.marionette'


NavTemplates = require './templates/navbar'
LayoutTemplates = require './templates/layout'
MiscTemplates = require './templates/misc'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

class BootstrapNavBarView extends Backbone.Marionette.LayoutView
  template: NavTemplates.nav_pt
  regions:
    usermenu: '#user-menu'
    mainmenu: '#main-menu'

class MainPageLayout extends Backbone.Marionette.LayoutView
  template: LayoutTemplates.MainLayoutTemplate

class MainSearchFormView extends Backbone.Marionette.ItemView
  template: NavTemplates.nav_pt_search

class BreadCrumbView extends Backbone.Marionette.ItemView
  template: MiscTemplates.breadcrumbs

class UserMenuView extends Backbone.Marionette.ItemView
  template: MiscTemplates.user_menu

class MessageView extends Backbone.Marionette.ItemView
  template:MiscTemplates.message_box
  ui:
    close_button: 'button.close'

  events:
    'click @ui.close_button': 'destroy_message'

  destroy_message: ->
    MessageChannel.request 'delete-message', @model
    
class MessagesView extends Backbone.Marionette.CollectionView
  childView: MessageView
  
  
module.exports =
  MainPageLayout: MainPageLayout
  MainSearchFormView: MainSearchFormView
  BootstrapNavBarView: BootstrapNavBarView
  BreadCrumbView: BreadCrumbView
  UserMenuView: UserMenuView
  MessagesView: MessagesView
  

