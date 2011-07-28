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
        baseUrl   = harness.baseUrl

        # Home.
        homeUrl = baseUrl
        homeUrl = '/' if homeUrl is ''
        app.get homeUrl, (req, res) =>
            render res, 'shell/index',
                          title: 'TestHarness'
                          layout: false

        # Dev.
        app.get "#{baseUrl}/dev", (req, res) -> 
            render res, 'dev/index',
                          title: 'TestHarness (Dev)'
                          layout: false
            