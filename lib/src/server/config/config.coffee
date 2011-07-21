express = require 'express'
nib     = require 'nib'
paths   = require './paths'
routes  = require '../routes'
core    = require 'core.server'

###
Configures the TestHarness
@param harness: The root TestHarness module.
###
module.exports = (harness) ->

    # Setup initial conditions.
    app     = harness.app
    baseUrl = harness.baseUrl

    # Put middleware within the given URL namespace.
    use = (middleware) ->
        if baseUrl is '/'
            # Running from the local project (dev/debug).  Don't namespace the url.
            app.use middleware
        else
            app.use baseUrl, middleware

    # Configuration.
    app.configure ->
        use express.bodyParser()
        use express.methodOverride()
        use express.cookieParser()
        use express.favicon("#{paths.public}/images/favicon.ico", maxAge: 2592000000)
        use app.router
        use express.static(paths.public)

        # Setup CSS (with references to Open.Core)
        stylus = require 'stylus'
        compile = (str, path) ->
            stylus(str)
                .include("#{core.paths.public}/stylesheets")
                .include(paths.public)
                .use nib()
        use stylus.middleware
                        src: paths.public
                        compile: compile


    app.configure 'development', ->
        use express.errorHandler( dumpExceptions: true, showStack: true )

    app.configure 'production', ->
        use express.errorHandler()

    # Initialize the [open.core] library
    core.configure app
    core.configure.specs app,
                      title:      'TestHarness Specs'
                      url:        '/specs'
                      specsDir:   "#{paths.specs}/client/"
                      sourceUrls: '/javascripts/harness.js'


    # Setup routes.
    routes.init harness



