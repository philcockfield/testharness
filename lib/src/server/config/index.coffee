express = require 'express'
paths = require './paths'


###
Configures the TestHarness
@param options:
        - baseUrl: The base URL path to put the TestHarness within (default: /testharness).
###
module.exports = (app, options = {}) ->

    # Setup initial conditions.
    baseUrl = options.baseUrl ?= '/testharness'

    # Configuration
    app.configure ->
        app.use express.bodyParser()
        app.use express.methodOverride()
        app.use express.cookieParser()
        app.use express.session( secret: 'your secret here' )
        app.use express.compiler( src: paths.public, enable: ['sass'] )

        app.use app.router
        app.use baseUrl, express.static(paths.public)

    app.configure 'development', ->
        app.use express.errorHandler( dumpExceptions: true, showStack: true )

    app.configure 'production', ->
        app.use express.errorHandler()

