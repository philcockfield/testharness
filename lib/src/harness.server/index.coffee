express   = require 'express'
paths     = require './config/paths'
configure = require './config/configure'
core      = require 'open.core'

module.exports =
  title:  'TestHarness (Server)'
  paths:  paths
  core:   core
  util:   require './util'
  client: require(paths.client)

  ###
  Starts the server (only use when not running your own server).
  @param options:
          - baseUrl:  The base URL path to put the TestHarness within (default: /testharness).
          - json:     The file location where the 'harness.json' is located
                      relative to the root of the application.
                      Default: /harness.json
          - port:     The port to listen on (default: 8000).
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
              console.log "[#{@title}] server listening on port #{app.address().port} in #{app.settings.env} mode"
              console.log '---'

          # Finish up.
          app

  ###
  Configures the TestHarness
  @param options:
            - baseUrl:    The base URL path to put the TestHarness within 
                          (Default: /testharness)
            - specsDir:   The directory where the test/specs are located.
                          This path is relative to the root of the app.  The fully qualified path is
                          inserted by the TestHarness.
                          (Default: /test/harness)
            - specsUrl:   The base URL from which spec files can be loaded from the client.
                          (Default: /specs)
  ###
  configure: (app, options = {}) -> configure(app, options)


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

