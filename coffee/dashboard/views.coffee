Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

EditorBarTemplates = require './templates/editorbar'

NavTemplates = require 'common/templates/navbar'
LayoutTemplates = require 'common/templates/layout'
MiscTemplates = require 'common/templates/misc'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

class EditBarView extends Backbone.Marionette.LayoutView
  template: EditorBarTemplates.editor_bar_pt
  
module.exports =
  EditBarView: EditBarView
