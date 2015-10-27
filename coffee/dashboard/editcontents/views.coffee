
{ NewDocumentView } = require './views/newcontent'

module.exports =
  ContentsView: require './views/contents'
  EditorView: require './views/halloeditor'
  AceEditorView: require './views/ace-editor'
  NewDocumentView: NewDocumentView
