$ = require 'jquery'
_ = require 'underscore'
tc = require 'teacup'


{ navbar_collapse_button
  dropdown_toggle } = require 'bootstrap-teacup-templates/coffee/buttons'
  
  
{ frontdoor_url
  user_menu_dropdown } = require 'common/templates/common'


# Main Templates must use teacup.
# The template must be a teacup.renderable, 
# and accept a layout model as an argument.

########################################
# Templates
########################################

user_menu_dropdown = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  user = relmeta.current_user
  if user is null
    return tc.li '.pull-right', ->
      tc.a href:'/login', 'Login'
  # FIXME make better menu
  tc.li '.dropdown.pull-right', ->
    dropdown_toggle ->
      tc.text user.title
      tc.b '.caret'
    tc.ul '#user-dropdown.dropdown-menu', ->
      tc.li ->
        tc.a href:user.prefs_url, ->
          tc.i '.fa.fa-gears.fa-fw'
          # FIXME i18n
          tc.span "Preferences"
      tc.li ->
        tc.a href:'/@@dashboard', ->
          tc.i '.fa.fa-dashboard.fa-fw'
          # FIXME i18n
          tc.span "Dashboard"
      if relmeta.has_permission.admin
        tc.li '.divider'
        tc.li '.dropdown-header', role:'presentation', ->
          # FIXME i18n
          tc.text "Site Setup"
        tc.li ->
          tc.a href:"/@@dashboard#setupusers", "User Administration"
      tc.li ->
        # FIXME - fix logout href
        tc.a href:'/@@logout', ->
          tc.i '.fa.fa-sign-out.fa-fw'
          # FIXME i18n
          tc.span 'Logout'



# FIXME -- no search form with action 
nav_pt_search = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  tc.form '#form-search.navbar-form.navbar-right', role:'search',
  method:'post', action:"#{relmeta.root_url}@@search-results", ->
    tc.div '.form-group', ->
      # FIXME search input placeholder needs to come from server
      tc.input '.form-control', name:'search-term', type:'search',
      placeholder:'Search...'
    tc.button '.btn.btn-default', type:'submit', name:'search-submit',
    value:'search', style:'display: none;', ->
      tc.raw '&#8594'

nav_pt_content = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  tc.div '.container-fluid', ->
    tc.div '.navbar-header', ->
      navbar_collapse_button 'navbar-view-collapse'
      tc.a '.navbar-brand', href:'#frontdoor', relmeta.site_title
    tc.div '#navbar-view-collapse.collapse.navbar-collapse', ->
      tc.ul '.nav.navbar-nav', ->
        for item in relmeta.navitems
          isactive = ""
          if item.inside
            isactive = ".active"
          tc.li isactive, ->
            tc.a href:frontdoor_url(item.path),
            title:item.description, item.title
      tc.ul '#user-menu.nav.navbar-nav.navbar-right', ->
        user_menu_dropdown doc
      tc.div '#form-search-container'

nav_pt = tc.renderable (doc) ->
  tc.nav '#navbar-view.navbar.navbar-static-top.navbar-default',
  xmlns:'http://www.w3.org/1999/xhtml', 'xml:lang':'en',
  role:'navigation', ->
    nav_pt_content doc

########################################
module.exports =
  nav_pt_search: nav_pt_search
  nav_pt: nav_pt
