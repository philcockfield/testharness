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
        render    = harness.util.render

        # Home.
        homeUrl = harness.baseUrl
        homeUrl = '/' if homeUrl is ''
        app.get homeUrl, (req, res) =>
            render res, 'shell/index',
                          title: harness.title
                          layout: false
