Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

AppTemplates = require '../templates'


MainChannel = Backbone.Radio.channel 'global'

ace = require 'brace'
require 'brace/mode/html'
require 'brace/mode/markdown'
require 'brace/theme/twilight'
require 'brace/theme/cobalt'

beautify = require('js-beautify').html

{ BaseKottiResourceFormView } = require './base'

class KottiResourceFormView extends BaseKottiResourceFormView
    
class AceEditorView extends KottiResourceFormView
  template: AppTemplates.AceEditNodeForm
  editorTheme: 'ace/theme/twilight'
  editorMode: 'ace/mode/html'
  editorContainer: 'ace-editor'
  ui:
    editor: '#ace-editor'
     
  createModel: ->
    @model
    
  updateModel: ->
    data = @model.get 'data'
    atts = data.attributes
    for a in ['title', 'description']
      atts[a] = @ui[a].val()
    atts.body = @editor.getValue()
    # FIXME!!!!
    atts.tags = []
    @model.set "data", data
    
  onDomRefresh: () ->
    @editor = ace.edit @editorContainer
    @editor.setTheme @editorTheme
    session = @editor.getSession()
    session.setMode @editorMode
    data = @model.get 'data'
    content = data.attributes.body
    @editor.setValue content
    super()
    
     
       

    
module.exports = AceEditorView
