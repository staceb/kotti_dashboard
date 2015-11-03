tc = require 'teacup'
marked = require 'marked'


{ navbar_collapse_button
  dropdown_toggle } = require 'bootstrap-teacup-templates/coffee/buttons'
  

{ frontdoor_url
  editor_url } = require 'common/templates/common'

{ workflow_dropdown } = require '../templates/editorbar'

{ form_group_input_div } = require 'bootstrap-teacup-templates/coffee/forms'
{ ace_editor_div } = require 'bootstrap-teacup-templates/coffee/misc'

{ capitalize
  str_startswith } = require 'common/apputil'

MainChannel = Backbone.Radio.channel 'global'

########################################
# Templates
########################################
#

user_admin_dashboard = tc.renderable () ->
  tc.div ".row", ->
    tc.div "#useradmin-sidebar.col-md-3.left-column.panel.panel-default", ->
      tc.span ".label.label-primary", "Search Users/Groups"
      tc.div "#useradmin-search-form"
      tc.div ".form-group", ->
        tc.div '.label.label-primary', "Add Users/Groups"
        tc.div "#adduser-btn.form-control.btn.btn-default", ->
          tc.text "Add User"
        tc.div "#addgroup-btn..form-control.btn.btn-default", ->
          tc.text "Add Group"
    tc.div "#useradmin-content.col-md-9.right-column"
    

setup_user_tabs = tc.renderable (options) ->
  tc.ul '.nav.nav-tabs', ->
    tc.li '.active', ->
      tc.a href:"#search-tab", 'data-toggle':'tab', ->
        "Search users(s) / group(s)"
    tc.li ->
      tc.a href:"#add-user-tab", 'data-toggle':'tab', ->
        "Add user"
    tc.li ->
      tc.a href:"#add-group-tab", 'data-toggle':'tab', ->
        "Add group"

search_pane = tc.renderable (options) ->
  tc.div "#search-tab.tab-pane", ->
    tc.div ".panel.panel-default", style:"margin-top:2em;", ->
      tc.div '.panel-heading', ->
        tc.h3 '.panel-title', 'Find users or groups'
      tc.div '.panel-body', ->
        tc.form ".form", ->
          tc.div '.control-group', ->
            tc.label for:'search-query', "User- / groupname"
            tc.input '#search-query.form-control', type:'search',
            name: 'query', placeholder:'Search users and groups'
            tc.span '.help-block', "blank search text finds all."
          tc.button '.btn.btn-primary', type:'submit', name:'search', ->
            tc.i '.glyphicon.glyphicon-search'
            tc.span 'Search'


search_users_form = tc.renderable (options) ->
  form_group_input_div
    input_id: "input_query"
    label: "Name"
    input_attributes:
      name: 'query'
  tc.input '.btn.btn-primary', type:'submit', value:'search'


principal_role_row = tc.renderable (entry, available_roles) ->
  principal = entry.principal
  is_group = not principal.name.indexOf 'group:'
  ## NeedES6 str.startsWith
  is_group = str_startswith principal.name, 'group:'
  is_user = not is_group
  tc.tr ->
    tc.td ->
      tc.span ->
        if is_group then "Group" else "User"
    tc.td ->
      tc.img src:principal.avatar_url, alt:'Gravatar'
      tc.a href:"#setupusers/user/#{principal.name}", principal.title
      if principal?.email
        tc.div "<#{principal.email}>"
    for role in available_roles
      console.log "ROLE", role
      tc.td ->
        attributes =
          type: 'checkbox'
          title: "Assign role #{role.name}"
        if role.name in entry.enabled
          attributes.checked = 'checked'
        if role.name in entry.disabled
          attributes.disabled = 'disabled'
        tc.input attributes
        attributes =
          type: 'hidden'
          name:"orig-role::#{principal.name}::#{role.name}"
          value: if role.name in entry.enabled then '1' else ''
        tc.input attributes
    
search_results_form = tc.renderable (model) ->
  tc.h2 "Assign global roles"
  tc.table '.table.table-bordered.table-hover', ->
    tc.thead ->
      tc.tr ->
        tc.th "Type"
        tc.th "Name"
        for role in model.available_roles
          tc.th role.title
    tc.tbody ->
      for entry in model.entries
        principal_role_row entry, model.available_roles
  tc.div '.btn.btn-primary', type:'submit', value:'apply', ->
    tc.i '.glyphicon.glyphicon-save'
    tc.span 'Apply changes'
    

          
  

module.exports =
  user_admin_dashboard: user_admin_dashboard
  search_users_form: search_users_form
  search_results_form: search_results_form
    
