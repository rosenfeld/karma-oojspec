module.exports = {
  context: __dirname + '/src'
  ,entry: './oojspec-initializer.coffee'
  ,output: {
    path: __dirname + '/dist',
    filename: 'oojspec-initializer.js'
  }
  ,module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee' }
      // We must use css-loader 0.14.5 until this issue is fixed:
      // https://github.com/webpack/css-loader/issues/133
      // Otherwise the buster CSS will be compiled with wrong content for the ✓ symbol
      // (\002713)
      , { test: /\.css$/, loader: 'style!css' }
    ]
  }
}
