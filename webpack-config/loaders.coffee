# webpack config module.loaders
module.exports =
  [
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
