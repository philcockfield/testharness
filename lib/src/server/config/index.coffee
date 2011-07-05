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

    use = (middleware) -> app.use baseUrl, middleware


    # Configuration
    app.configure ->
        use express.bodyParser()
        use express.methodOverride()
        use express.cookieParser()
        use express.session( secret: 'your secret here' )
        use express.compiler( src: paths.public, enable: ['sass'] )
        use app.router
        use express.static(paths.public)

    app.configure 'development', ->
        use express.errorHandler( dumpExceptions: true, showStack: true )

    app.configure 'production', ->
        use express.errorHandler()

