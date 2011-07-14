express   = require 'express'
paths     = require './config/paths'
config    = require "#{paths.server}/config/config"
core      = require 'open.core'


module.exports =
  title: 'TestHarness'
  paths: paths
  core:  core
  util:  require './util'

  ###
  Starts the server (only use when not running your own server).
  @param options:
          - baseUrl: The base URL path to put the TestHarness within (default: /testharness).
          - port: The port to listen on (default: 8000).
  @returns the Express app.
  ###
  start: (options = {}) ->
      # Create and configure the server.
      app = express.createServer()
      @configure app, options

      # Build client-side JavaScript.
      @util.build.client =>

          # Start listening on requested port.
          app.listen options.port ?= 8000, =>
              console.log ''
              console.log "#{@title} server listening on port #{app.address().port} in #{app.settings.env} mode"
              console.log '---'

          # Finish up.
          app

  ###
  Configures the TestHarness
  @param options:
          - baseUrl: The base URL path to put the TestHarness within (default: /testharness).
  ###
  configure: (app, options = {}) ->
        @baseUrl = options.baseUrl ?= '/testharness'
        @app = app
        config @, options



  ###
  Generates the standard copyright notice (MIT).
  @param options (optional)
          - asComment: Flag indicating if the copyright notice should be within an HTML comment.
  ###
  copyright: (options = {}) ->
      notice = "Copyright #{new Date().getFullYear()} Phil Cockfield. All rights reserved."
      if options.asComment
                notice = """
                /*
                  #{notice}
                  The MIT License (MIT)
                  https://github.com/philcockfield/testharness
                */
                """
      notice

