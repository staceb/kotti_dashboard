path = require 'path'
webpack = require 'webpack'

ManifestPlugin = require 'webpack-manifest-plugin'

ChunkManifestPlugin = require 'chunk-manifest-webpack-plugin'
StatsPlugin = require 'stats-webpack-plugin'

vendor = require './webpack-config/vendor'
loaders = require './webpack-config/loaders'
aliases = require './webpack-config/resolve-aliases'

module.exports =
  devtool: 'source-map'
  entry:
    vendor: vendor
    app: './coffee/dashboard/application.coffee'
    eidolon: './coffee/eidolon/application.coffee'
  output:
    path: path.join __dirname, "kotti_dashboard/static"
    publicPath: '/static-kotti_dashboard/'
    filename: 'dashboard-dev.js'
    
  plugins: [
    new webpack.DefinePlugin
      __DEV__: 'true'
      DEBUG: JSON.stringify(JSON.parse(process.env.DEBUG || 'false'))
    new webpack.optimize.DedupePlugin()
    new webpack.optimize.CommonsChunkPlugin
      name: 'vendor'
      filename: 'vendor-dev.js'
    new StatsPlugin 'stats.json', chunkModules: true
    new ManifestPlugin()
    ]
  module:
    loaders: loaders
  resolve:
    alias: aliases
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

