express   = require 'express'
paths     = require './lib/src/server/config/paths'
config    = require "#{paths.server}/config"

module.exports =
  title: 'TestHarness'

  ###
  Starts the server (only use when not running your own server).
  @param options:
          - baseUrl: The base URL path to put the TestHarness within (default: /testharness).
          - port: The port to listen on (default: 8000).
  @returns the Express app.
  ###
  start: (options = {}) ->
      app = module.exports = express.createServer()
      config app, options

      # TEMP
      app.get '/', (req, res)->
          path = "#{paths.views}/index.jade"
          res.render path,
                  title: 'TestHarness'
                  baseUrl: options.baseUrl

      app.listen options.port ?= 8000
      console.log ''
      console.log "#{@title} server listening on port #{app.address().port} in #{app.settings.env} mode"
      app

  ###
  Configures the TestHarness
  @param options:
          - baseUrl: The base URL path to put the TestHarness within (default: /testharness).
  ###
  configure: config
