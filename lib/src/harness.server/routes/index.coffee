fs      = require 'fs'
express = require 'express'
core    = require 'open.core'

module.exports = -> 
  # Setup initial conditions.
  harness   = require 'harness.server'
  require('./harness')()
  
  # Store references.
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

  # Temp host (until the harness is built!)
  app.get "/temp/:control", (req, res) -> 
      control = req.params.control
      render res, "temp/#{control}",
                          title: control
                          layout: false
      
      


