express = require 'express'
core    = require 'open.core'

module.exports =
    ###
    Initializes the routes.
    @param server: the root TestHarness server module.
    ###
    init: (harness) ->
        # Setup initial conditions.
        app       = harness.app
        send      = core.util.send
        @app      = app
        @harness  = harness
        @paths    = harness.paths
        @baseUrl  = harness.baseUrl

        # Prepare the base-url for passing to templates.
        @baseUrl  = '' if @baseUrl is '/'

        # Home.
        app.get harness.baseUrl, (req, res) =>
            @render res, 'shell/index',
                          title: harness.title
                          layout: false

        app.get '/build/:package?.js', (req, res) =>
            package   = req.params.package
            minified  = _(package).endsWith '-min'

            switch req.params.package
              when 'client', 'client-min'
                  # Server fresh versions of the files (but don't save).
                  compiler = new core.util.javascript.Compiler(@paths.client)
                  compiler.build minified, (code) -> send.script res, code
              else
                res.send 404


    ###
    Renders the specified template from the 'views' path.
    @param response object to write to.
    @param template: path to the template within the 'views' folder.
    @param options: variables to pass to the template.
    ###
    render: (response, template, options) ->
            extension = options.extension ?= 'jade'
            options.baseUrl ?= @baseUrl
            response.render "#{@paths.views}/#{template}.#{extension}", options
