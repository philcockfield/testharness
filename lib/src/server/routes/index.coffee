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
        @baseUrl  = '' unless @baseUrl?
        @baseUrl  = '' if @baseUrl is '/'

        # Home.
        app.get harness.baseUrl, (req, res) =>
            @render res, 'shell/index',
                          title: harness.title
                          layout: false

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
