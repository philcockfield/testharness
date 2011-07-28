fs      = require 'fs'
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
        paths     = harness.paths

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
            
        
        # Harness definition (JSON).
        app.get "#{baseUrl}/harness.json", (req, res) -> 
            core.util.send.jsonFile res, paths.harnessJson


