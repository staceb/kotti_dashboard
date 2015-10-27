Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

AppTemplates = require '../templates'


MainChannel = Backbone.Radio.channel 'global'

ace = require 'brace'
html_mode = require 'brace/mode/html'
twilight_theme = require 'brace/theme/twilight'

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
    #console.log "Model url", @model.url()
    @model
    
  updateModel: ->
    #console.log "Model", @model
    data = @model.get 'data'
    atts = data.attributes
    for a in ['title', 'description']
      atts[a] = @ui[a].val()
    atts.body = @editor.getValue()
    # FIXME!!!!
    atts.tags = []
    @model.set "data", data
    #console.log "model updated", @model, @model.url()
    
  onDomRefresh: () ->
    @editor = ace.edit @editorContainer
    @editor.setTheme @editorTheme
    session = @editor.getSession()
    session.setMode @editorMode
    data = @model.get 'data'
    content = data.attributes.body
    content = beautify content
    @editor.setValue content
    super()
    
     
       

    
module.exports = AceEditorView
