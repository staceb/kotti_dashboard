$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
marked = require 'marked'


Util = require 'common/apputil'
{ MainController } = require 'common/controllers'

MainChannel = Backbone.Radio.channel 'global'
ResourceChannel = Backbone.Radio.channel 'resources'
MessageChannel = Backbone.Radio.channel 'messages'

CONTENT_TYPES =
  html: 'Document'
  markdown: 'MarkDownDocument'

CONTENT_LOOKUP =
  Document: 'html'
  MarkDownDocument: 'markdown'
  

class Controller extends MainController
  _get_doc_and_render_view: (viewclass) ->
    response = @current_resource.fetch()
    response.done =>
      MainChannel.request 'make-editbar', @current_resource
      MainChannel.request 'make-breadcrumbs', @current_resource
      view = new viewclass
        model: @current_resource
      if viewclass.name == "AceEditorView"
        data = @current_resource.get 'data'
        doctype = data.type
        if doctype in ['Document', 'MarkDownDocument']
          view.editorMode = "ace/mode/#{CONTENT_LOOKUP[doctype]}"
      @_show_content view

  _get_contents_and_render_view: (resource) ->
    require.ensure [], () =>
      Views = require './views'
      @_set_resource resource
      res_response = @current_resource.fetch()
      ## FIXME wrap this in scoping functions
      res_response.done =>
        collection = ResourceChannel.request 'get-document-contents', resource
        cresponse = collection.fetch()
        cresponse.done =>
          MainChannel.request 'make-editbar', @current_resource
          MainChannel.request 'make-breadcrumbs', @current_resource
          view = new Views.ContentsView
            model: @current_resource
            collection: collection
          @_show_content view
          #window.ccview = view
        
  manage_contents: (resource) ->
    @_get_contents_and_render_view resource


  _add_document: (doctype, resource) ->
    if doctype not in ['html', 'markdown']
      console.error "I don't understand #{doctype}"
    require.ensure [], () =>
      Models = require 'common/models'
      Views = require './views'
      #model = new Models.BaseKottiModel
      if resource is null
        resource = ''
      model = new Models.BaseKottiResource
      model.url = "#{resource}/@@json"
      model.content_type = CONTENT_TYPES[doctype]
      view = new Views.NewDocumentView
        model: model
      view.editorMode = "ace/mode/#{doctype}"
      window.newdocview = view
      @_show_content view
      $('title').text "Add new #{doctype} document to #{resource}"
    
    

  add_node: (content_type, resource) ->
    if __DEV__ and DEBUG
      console.debug "Add #{content_type} node to this resource #{resource}"
    @_set_resource resource
    response = @current_resource.fetch()
    response.done =>
      MainChannel.request 'make-editbar', @current_resource
      MainChannel.request 'make-breadcrumbs', @current_resource
      if content_type == 'document'
        @_add_document 'html', resource
      else if content_type == 'markdown'
        @_add_document 'markdown', resource
      else
        msg = "Unable to add type #{content_type}"
        MessageChannel.request 'display-message', msg, "error"

  edit_node: (resource) ->
    require.ensure [], () =>
      Views = require './views'
      @_set_resource resource
      @_get_doc_and_render_view Views.EditorView

  ace_edit_node: (resource) ->
    require.ensure [], () =>
      Views = require './views'
      @_set_resource resource
      @_get_doc_and_render_view Views.AceEditorView

    
module.exports = Controller

