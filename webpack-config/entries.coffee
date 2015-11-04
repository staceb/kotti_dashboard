# webpack config module.entry
vendor = require './vendor'

module.exports =
  vendor: vendor
  dashboard: './coffee/dashboard/application.coffee'
  eidolon: './coffee/eidolon/application.coffee'
  
