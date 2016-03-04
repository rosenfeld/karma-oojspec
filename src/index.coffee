initOOJSpec = (config) ->
  config.customContextFile = __dirname + '/static/context.html'
  config.customDebugFile = __dirname + '/static/debug.html'
  config.files.push
    pattern: __dirname + '/oojspec-initializer.js'
    included: true, served: true, watched: false

initOOJSpec.$inject = ['config']

module.exports = 'framework:oojspec': ['factory', initOOJSpec ]
