express = require 'express'

module.exports =
    ###
    Initializes the routes.
    @param server: the root QUI server module.
    ###
    init: (harness) ->
        # Setup initial conditions.
        @harness  = harness
        @app      = harness.app
        @paths    = harness.paths
        @baseUrl  = harness.baseUrl

        # Prepare the base-url for passing to templates.
        @baseUrl  = '' if @baseUrl is '/'

        # Home
        @app.get harness.baseUrl, (req, res) =>
            @render res, 'index',
                          title: harness.title

    ###
    Renders the specified template from the 'views' path.
    NB: This is not all setup as the default view-engine because
        QUI may be used as a library, and therefore we cannot overwrite
        these settings.
    @param response object to write to.
    @param template: path to the template within the 'views' folder.
    @param options: variables to pass to the template.
    ###
    render: (response, template, options) ->
            extension = options.extension ?= 'jade'
            options.baseUrl ?= @baseUrl
            response.render "#{@paths.views}/#{template}.#{extension}", options
