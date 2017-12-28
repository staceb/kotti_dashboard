# webpack config resolve.alias
path = require 'path'
module.exports =
  jquery: 'jquery/src/jquery'
  'bootstrap-fileinput-css': 'bootstrap-fileinput/css/fileinput.min.css'
  'bootstrap-fileinput-js': 'bootstrap-fileinput/js/fileinput.min.js'
  tablednd: 'TableDnD/js/jquery.tablednd.js'
  request: 'browser-request'
  'tag-it': 'tag-it/js/tag-it.js'
  'radio-shim': path.join __dirname, 'radio-shim.coffee'
  common: path.join __dirname, '../coffee/common'
  #fb: 'fb/index.js'
  #fb: path.join __dirname, '../node_modules/fb/fb.js'
  fb: 'facebook-node-sdk/fb.js'
