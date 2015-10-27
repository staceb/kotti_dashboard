# inspired by https://github.com/KyleAMathews/coffee-react-quickstart
# 
gulp = require 'gulp'
gutil = require 'gulp-util'

webpack = require 'webpack'

DevServer = require 'webpack-dev-server'
DevConfig = require './webpack.config.coffee'


size = require 'gulp-size'


# Create a single instance of the compiler to allow caching.
devCompiler = webpack DevConfig
gulp.task 'webpack:coffee', (callback) ->
  # run webpack
  devCompiler.run (err, stats) ->
    throw new gutil.PluginError('webpack:coffee', err) if err
    gutil.log "[webpack:coffee]", stats.toString(colors: true)
    callback()
    return
  return
  
gulp.task 'default', ->
  gulp.start 'webpack:coffee'
  
gulp.task 'watch', ['webpack:coffee'], ->
  gulp.watch ['./coffee/**/*.coffee'], ['webpack:coffee']
  
