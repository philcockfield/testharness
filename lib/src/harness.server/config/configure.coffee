express = require 'express'
css     = require './css'
paths   = require './paths'
routes  = require '../routes'
core    = require 'open.server'

###
Configures the TestHarness
@param app:     The express app.
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
module.exports = (app, options = {}) ->

    # Setup initial conditions.
    harness         = require 'harness.server'
    harness.app     = app
    harness.options = options
    
    # Store the location of the Harness JSON definition.
    do -> 
        path = options.json ?= 'harness.json'
        path = "#{process.env.PWD}/#{_.ltrim(path, '/')}"
        paths.harnessJson = path

    # Format and store the base url.
    runningLocally = false
    baseUrl = null
    do -> 
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
                      sourceUrls: [
                        "#{baseUrl}/core/libs.js"
                        "#{baseUrl}/core/core.js"
                        "#{baseUrl}/javascripts/harness.js"
                      ]

    # Setup routes.
    routes()



