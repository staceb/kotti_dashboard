path = require 'path'
webpack = require 'webpack'

ChunkManifestPlugin = require 'chunk-manifest-webpack-plugin'
module.exports =
  entry:
    app: './coffee/dashboard/application.coffee'
  output:
    path: path.join __dirname, "kotti_dashboard/static"
    publicPath: '/static-kotti_dashboard/'
    filename: 'dashboard.js'
    
  plugins: [
    new webpack.optimize.DedupePlugin()
    ]
  module:
    loaders: [
      {
        test: /\.coffee$/
        loader: 'coffee'
      }
      {
        test: /\.css$/
        loader: 'style!css'
      }
      {
        test: /\.(gif|png|eot|ttf)?$/
        loader: 'url-loader'
      }
      {
        test: /\.(woff|woff2|eot|ttf)(\?[\&0-9]+)?$/
        loader: 'url-loader'
      }
      {
        test: /\.(woff|woff2|eot|ttf)(\?v=[0-9]\.[0-9]\.[0-9])?$/
        loader: 'url-loader'
      }
      # This is for using packaged jquery
      #{
      #  test: require.resolve 'jquery'
      #  loader: "expose?$!expose?jQuery"
      #}
      {
        test: require.resolve 'rangy'
        loader: "expose?rangy"
      }
      {
        test: /jquery\/src\/selector\.js$/
        loader: 'amd-define-factory-patcher-loader'
      }
      ]
  resolve:
    fallback: [
      path.join __dirname, 'coffee/dashboard'
      ]
    alias:
      jquery: 'jquery/src/jquery'
      'bootstrap-fileinput-css': 'bootstrap-fileinput/css/fileinput.min.css'
      'bootstrap-fileinput-js': 'bootstrap-fileinput/js/fileinput.min.js'
      tablednd: 'TableDnD/js/jquery.tablednd.js'
      request: 'browser-request'
      'tag-it': 'tag-it/js/tag-it.js'
    modulesDirectories: [
      'node_modules'
      'bower_components'
      ]
    extensions: [
      # MUST include empty string
      # https://webpack.github.io/docs/configuration.html#resolve-extensions
      ''
      '.webpack.js'
      '.web.js'
      '.js'
      # add coffescript files to the list
      '.coffee'
    ]
    plugins: [
      new webpack.ResolverPlugin
        new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin
          "bower.json", ["main"]
        ['normal', 'loader']
      #new webpack.optimize.OccurenceOrderPlugin true
    ]

