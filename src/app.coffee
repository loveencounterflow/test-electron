

############################################################################################################
### https://github.com/ddopson/node-segfault-handler ###
SegfaultHandler = require 'segfault-handler'
SegfaultHandler.registerHandler()
# SegfaultHandler.causeSegfault()



############################################################################################################
njs_fs                    = require 'fs'
#...........................................................................................................
CND                       = require 'cnd'
rpr                       = CND.rpr
badge                     = 'test-electron/main'
log                       = CND.get_logger 'plain',     badge
info                      = CND.get_logger 'info',      badge
whisper                   = CND.get_logger 'whisper',   badge
alert                     = CND.get_logger 'alert',     badge
debug                     = CND.get_logger 'debug',     badge
warn                      = CND.get_logger 'warn',      badge
help                      = CND.get_logger 'help',      badge
urge                      = CND.get_logger 'urge',      badge
echo                      = CND.echo.bind CND
#...........................................................................................................
app                       = require 'app'
BrowserWindow             = require 'browser-window'
ipc                       = require 'ipc'


# // CND.dir( app )
# // _emit = app.emit
# // app.emit = function(){
# //   log( arguments )
# //   _emit.apply( app, arguments )
# //   }

# // log( app )
# // log( process[ 'versions' ] )

options =
  windows:
    main:
      width:      1200
      height:     800
      dev:        yes
    settings:
      width:      400
      height:     400
      show:       no

windows = {}

app.on 'ready', ->
  log "app ready"
  do ->
    for window_name, window_settings of options[ 'windows' ]
      w                       = new BrowserWindow window_settings
      template_name           = window_settings[ 'template' ] ? window_name
      file_route              = __dirname + '/' + template_name + '.html'
      unless njs_fs.existsSync file_route
        ### makeshift measure until https://github.com/atom/electron/issues/2213 gets resolved ###
        alert '©2213',  "missing file #{rpr file_route}"
        throw new Error "missing file #{rpr file_route}"
      url                     = 'file://' + file_route
      show_devtools           = window_settings[ 'dev' ] ? no
      windows[ window_name ]  = w
      w.loadUrl url
      w.openDevTools() if show_devtools
      log url


app.on 'gpu-process-crashed',             -> whisper 'gpu-process-crashed'
app.on 'select-certificate',              -> whisper 'select-certificate'
app.on 'activate-with-no-open-windows',   -> whisper 'activate-with-no-open-windows'
app.on 'before-quit',                     -> whisper 'before-quit'
app.on 'browser-window-blur',             -> whisper 'browser-window-blur'
app.on 'browser-window-focus',            -> whisper 'browser-window-focus'
app.on 'open-file',                       -> whisper 'open-file'
app.on 'open-url',                        -> whisper 'open-url'
app.on 'quit',                            -> whisper 'quit'
app.on 'ready',                           -> whisper 'ready'
app.on 'will-finish-launching',           -> whisper 'will-finish-launching'
app.on 'will-quit',                       -> whisper 'will-quit'
app.on 'window-all-closed',               -> whisper 'window-all-closed'


ipc.on 'show', ( event, window_name ) ->
  help "show: #{rpr window_name}"
  unless ( w = windows[ window_name ] )?
    ### makeshift measure until https://github.com/atom/electron/issues/2213 gets resolved ###
    alert '©2213',  "unknwon window #{rpr window_name}"
    throw new Error "unknwon window #{rpr window_name}"
  w.show()

ipc.on 'hide', ( event, window_name ) ->
  help "hide: #{rpr window_name}"
  unless ( w = windows[ window_name ] )?
    ### makeshift measure until https://github.com/atom/electron/issues/2213 gets resolved ###
    alert '©2213',  "unknwon window #{rpr window_name}"
    throw new Error "unknwon window #{rpr window_name}"
  w.hide()
