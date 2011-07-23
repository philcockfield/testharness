express = require 'express'
css     = require './css'
paths   = require './paths'
routes  = require '../routes'
core    = require 'core.server'


###
Configures the TestHarness
@param harness: The root TestHarness module.
@param app:     The express app.
@param options:
        - baseUrl: The base URL path to put the TestHarness within (default: /testharness).
###
module.exports = (harness, app, options = {}) ->

    # Setup initial conditions.
    harness.app = app

    # Format and store the base url.
    baseUrl = options.baseUrl ?= '/testharness'
    baseUrl = _.trim(baseUrl)
    runningLocally = baseUrl is '/'
    baseUrl = '' if runningLocally
    harness.baseUrl = baseUrl

    # Put middleware within the given URL namespace.
    use = (middleware) ->
        if runningLocally
            # Running from the local project (dev/debug mode).  Don't namespace the url.
            app.use middleware
        else
            app.use baseUrl, middleware

    # Configuration.
    app.configure ->
        use express.bodyParser()
        use express.methodOverride()
        use express.cookieParser()
        use express.favicon("#{paths.public}/images/favicon.ico", maxAge: 2592000000)
        css.configure use # CSS pre-processor (Stylus)
        use express.static(paths.public)
        use app.router

    app.configure 'development', ->
        use express.errorHandler( dumpExceptions: true, showStack: true )

    app.configure 'production', ->
        use express.errorHandler()

    # Initialize the [open.core] library
    core.configure app, express: express
    core.configure.specs app,
                      title:      'TestHarness Specs'
                      url:        '/specs'
                      specsDir:   "#{paths.specs}/harness.client/"
                      sourceUrls: '/javascripts/harness.js'

    # Setup routes.
    routes.init harness



