




############################################################################################################
# app                       = require 'app'
# BrowserWindow             = require 'browser-window'
# #...........................................................................................................
# CND                       = require 'cnd'
# rpr                       = CND.rpr
# badge                     = 'test-electron/main'
# log                       = CND.get_logger 'plain',     badge
# info                      = CND.get_logger 'info',      badge
# whisper                   = CND.get_logger 'whisper',   badge
# alert                     = CND.get_logger 'alert',     badge
# debug                     = CND.get_logger 'debug',     badge
# warn                      = CND.get_logger 'warn',      badge
# help                      = CND.get_logger 'help',      badge
# urge                      = CND.get_logger 'urge',      badge
# echo                      = CND.echo.bind CND
remote                    = require 'remote'
ipc                       = require 'ipc'
Menu                      = remote.require 'menu'

menu = Menu.buildFromTemplate [
  label: "name of app"
  submenu: [
    label:    'Super Label here!'
    click: ->
      console.log "clicked"
      ipc.send 'show', 'settings'
    ]
  ]

Menu.setApplicationMenu menu

