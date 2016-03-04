new class OojspecInitializer
  constructor: (@karma = window.__karma__) ->
    if file = location.search.split('file=')[1]
      @_loadIframeSpecs file
    else
      @_loadMainRunner()

  _loadIframeSpecs: (specFile) ->
    require 'oojspec/dist/oojspec/iframe-runner.js'
    oojspec.exposeAll()
    @_loadScript specFile

  _loadScript: (source, onLoad) ->
    script = document.createElement 'script'
    script.onload = onLoad if onLoad
    script.src = source
    document.getElementsByTagName('head')[0].appendChild script

  _loadMainRunner: ->
    require 'oojspec'
    require 'oojspec/dist/oojspec.css'
    oojspec.exposeAll()
    @_setupOojspec()

    iframes = []
    for file, hash of @karma.files when /_spec\./.test file
      iframes.push '<iframe src="debug.html?file=' + "#{file}?#{hash}" +
        '" width="100%" heigth="500px" onload="oojspec.onIFrameLoaded(this)" ' +
        'style="display: none"></iframe>'
    div = document.createElement 'div'
    div.innerHTML = iframes.join("\n")
    document.body.appendChild div

    @karma.start = ->
    @karma.loaded()

  _setupOojspec: ->
    @eh = oojspec.events
    @total = @count = 0
    @_currentStack = []
    @eh.on 'context:start', (ev) => @_currentStack.push ev.name
    @eh.on 'context:end', (ev) => @_currentStack.pop()
    @eh.on 'oojspec:examples:add', (count) => @total += count
    @eh.on 'suite:start',   => @karma.info total: @total
    @eh.on 'suite:end',     @karma.complete
    @eh.on 'test:success',  @_karmaSuccess
    @eh.on 'test:deferred', @_karmaPending
    @eh.on 'test:failure',  @_karmaFail
    @eh.on 'test:error',    @_karmaError
    @eh.on 'test:timeout',  @_karmaTimeout

  _karmaSuccess: (test) =>
    @_success test

  _success: (test, options) ->
    @karma.result @_options options,
      success: true
      description: test.name

  _options: (moreOptions, options) ->
    return options unless moreOptions
    opts = {}
    opts[k] = v for k, v of o for o in [options, moreOptions]
    opts

  _karmaPending: (test) => @_success test, skipped: true

  _karmaFail: (err) => @_error err, '[failure]'

  _karmaError: (err) => @_error err, '[error]'

  _karmaTimeout: (err) => @_error err, '[timed out]'

  _error: (err, reason) ->
    log = [reason, err.error.message]
    if err.error.stack
      log.push err.error.stack
    @karma.result
      success: false
      description: err.name
      suite: @_currentStack
      log: log
