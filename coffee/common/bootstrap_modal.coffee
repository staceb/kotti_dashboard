Backbone = require 'backbone'
Marionette = require 'backbone.marionette'


class BootstrapModalRegion extends Backbone.Marionette.Region
  el: '#modal'

  getEl: (selector) ->
    $el = $ selector
    $el.attr 'class', 'modal'
    #$el.attr 'class', 'modal fade'
    $el

  show: (view) ->
    super view
    @$el.modal
      backdrop: false
    @$el.modal 'show'

module.exports = BootstrapModalRegion
