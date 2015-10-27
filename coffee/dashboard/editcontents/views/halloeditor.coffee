Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

AppTemplates = require '../templates'

require 'jquery-ui'
#require 'jquery-ui/widget'
#require 'jquery-ui/position'

require "hallo/src/hallo"
require "hallo/src/widgets/dropdownbutton"
require "hallo/src/widgets/button"
require "hallo/src/toolbar/contextual"

require "hallo/src/plugins/halloformat"
require "hallo/src/plugins/headings"
require "hallo/src/plugins/justify"
require "hallo/src/plugins/link"
require "hallo/src/plugins/lists"
require "hallo/src/plugins/reundo"
require "hallo/src/plugins/image_insert_edit"
require "hallo/src/plugins/image"
require "hallo/src/plugins/image/current"
#require "hallo/src/plugins/block"
require "hallo/src/plugins/blocktc"
require "hallo/src/plugins/blacklist"



rangy = require 'rangy'

{ BaseKottiResourceFormView } = require './base'


{ remove_trailing_slashes
  make_json_post } = require 'apputil'

MainChannel = Backbone.Radio.channel 'global'

class KottiResourceFormView extends BaseKottiResourceFormView

class EditorView extends KottiResourceFormView
  template: AppTemplates.EditNodeForm
  ui:
    body: '#document-body'
  
  createModel: ->
    #console.log "Model url", @model.url()
    @model

  onDomRefresh: ->
    @ui.body.hallo
      enable: true
      plugins:
        halloformat: {}
        hallojustify: {}
        hallolists: {}
        halloreundo: {}
        halloimage: {}
        hallolink: {}
        halloblacklist: {}
        halloheadings: {}
        halloblock: {}
    super()
    
        
        

  updateModel: ->
    #console.log "Model", @model
    data = @model.get 'data'
    atts = data.attributes
    for a in ['title', 'description']
      atts[a] = @ui[a].val()
    atts.body = @ui.body.hallo('getContents')
    # FIXME!!!!
    atts.tags = []
    @model.set "data", data
    #console.log "model updated", @model, @model.url()
    
    
    
module.exports = EditorView