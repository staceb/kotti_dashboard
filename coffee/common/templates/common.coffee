$ = require 'jquery'
_ = require 'underscore'
tc = require 'teacup'

{ dropdown_toggle } = require 'bootstrap-teacup-templates/coffee/buttons'
  

# Main Templates must use teacup.
# The template must be a teacup.renderable, 
# and accept a layout model as an argument.

########################################
# Templates
########################################

frontdoor_url = (path) ->
  stripped_path = path.replace /\/$/, ""
  "#frontdoor/view#{stripped_path}"

editor_url = (action, path) ->
  rstripped_path = path.replace /\/$/, ""
  lstripped_path = rstripped_path.replace /^\//, ""
  "#editor/#{action}/#{lstripped_path}"


user_menu_dropdown = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  user = relmeta.current_user
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
      if relmeta.has_permission.admin
        tc.li '.divider'
        tc.li '.dropdown-header', role:'presentation', ->
          # FIXME i18n
          tc.text "Site Setup"
        tc.li ->
          tc.a href:"#setupusers", "User Administration"
        for link in relmeta.site_setup_links
          tc.li ->
            tc.a href:link.url, link.title
      tc.li ->
        # FIXME - fix logout href
        tc.a href:'/@@logout', ->
          tc.i '.fa.fa-sign-out.fa-fw'
          # FIXME i18n
          tc.span 'Logout'


########################################
module.exports =
  frontdoor_url: frontdoor_url
  editor_url: editor_url
  user_menu_dropdown: user_menu_dropdown
  
