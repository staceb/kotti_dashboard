Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

FDTemplates = require './templates'

tableDnD = require 'tablednd'

{ remove_trailing_slashes
  make_json_post } = require 'common/apputil'

require 'jquery-ui'

MainChannel = Backbone.Radio.channel 'global'

class FrontDoorMainView extends Backbone.Marionette.ItemView
  template: FDTemplates.DefaultViewTemplate

  updateStatusCallback: (args) ->
    console.log "updateStatusCallback", args
    
  FAKEonDomRefresh: ->
    $('.ui-draggable').draggable()
    $.ajaxSetup
      cache: true
    $.getScript "//connect.facebook.net/en_US/sdk.js", ->
      console.log "perform fb.init"
      FB.init
        appId: '1508237436143014'
        cookie: true
        xbfml: true
        version: 'v2.5'
      $('#loginbutton,#feedbutton').removeAttr 'disabled'
      FB.getLoginStatus @updateStatusCallback
    

class FolderView extends Backbone.Marionette.ItemView
  template: FDTemplates.FolderViewTemplate

module.exports =
  FrontDoorMainView: FrontDoorMainView
  FolderView: FolderView

