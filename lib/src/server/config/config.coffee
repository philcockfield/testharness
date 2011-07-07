express = require 'express'
paths   = require './paths'
routes  = require '../routes'

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
        use express.session( secret: 'your secret here' )
        use require('stylus').middleware( src: paths.public )
        use express.favicon("#{paths.public}/images", maxAge: 2592000000)


        use app.router
        use express.static(paths.public)

    app.configure 'development', ->
        use express.errorHandler( dumpExceptions: true, showStack: true )

    app.configure 'production', ->
        use express.errorHandler()

    # Setup routes.
    routes.init harness



