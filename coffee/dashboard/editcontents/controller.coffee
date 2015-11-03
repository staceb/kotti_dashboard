$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
marked = require 'marked'


Util = require 'common/apputil'
{ MainController } = require 'common/controllers'

MainChannel = Backbone.Radio.channel 'global'
ResourceChannel = Backbone.Radio.channel 'resources'
MessageChannel = Backbone.Radio.channel 'messages'



class Controller extends MainController
  _get_doc_and_render_view: (viewclass) ->
    response = @current_resource.fetch()
    response.done =>
      MainChannel.request 'make-editbar', @current_resource
      MainChannel.request 'make-breadcrumbs', @current_resource
      view = new viewclass
        model: @current_resource
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


  _add_document: ->
    require.ensure [], () =>
      Models = require 'common/models'
      Views = require './views'
      model = new Models.BaseKottiModel
      view = new Views.NewDocumentView
        model: model
      window.newdocview = view
      @_show_content view
    
    

  add_node: (content_type, resource) ->
    console.log "Add #{content_type} node to this resource #{resource}"
    @_set_resource resource
    if content_type == 'document'
      @_add_document()
    else
      msg = "Unable to add type #{content_type}"
      MessageChannel.request 'display-message', msg, "error"

  edit_node: (resource) ->
    require.ensure [], () =>
      Views = require './views'
      #console.log "EDIT RESOURCE", resource
      @_set_resource resource
      #console.log "EDIT RESOURCE Views", Views
      @_get_doc_and_render_view Views.EditorView

  ace_edit_node: (resource) ->
    require.ensure [], () =>
      Views = require './views'
      #console.log "ACE EDIT RESOURCE", resource
      @_set_resource resource
      @_get_doc_and_render_view Views.AceEditorView

    
module.exports = Controller

