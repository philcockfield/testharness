express = require 'express'
paths   = require './paths'
routes  = require '../routes'

###
Configures the TestHarness
@param options:
        - baseUrl: The base URL path to put the TestHarness within (default: /testharness).
###
module.exports = (harness, options = {}) ->

    # Setup initial conditions.
    options.baseUrl ?= '/testharness'
    app = harness.app

    # Put middleware within the given URL namespace.
    use = (middleware) ->
        if options.baseUrl is '/'
          # Running from the local project (dev/debug).  Don't url namespace.
          app.use middleware
        else
          app.use options.baseUrl, middleware

    # Configuration.
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


    # Setup routes.
    routes harness, options
