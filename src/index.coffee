initOOJSpec = (config) ->
  unless config.oojspecKeepCustomFiles
    config.customContextFile = 'node_modules/karma-oojspec/static/context.html'
    config.customDebugFile = 'node_modules/karma-oojspec/static/debug.html'
  config.files.push
    pattern: __dirname + '/oojspec-initializer.js'
    included: true, served: true, watched: false

initOOJSpec.$inject = ['config']

module.exports = 'framework:oojspec': ['factory', initOOJSpec ]
