harness    = require 'harness.server'
definition = require 'harness.server/util/harness_definition'
core       = harness.core

module.exports = -> 
  app     = harness.app
  baseUrl = harness.baseUrl
  options = harness.options
  
  # Route: Harness definition (JSON).
  app.get "#{baseUrl}/harness.json", (req, res) -> 
      definition.load (data) -> res.json data
        
  # Route: spec file.
  specsUrl = _.trim(options.specsUrl, '/')
  specsUrl = "#{baseUrl}/#{specsUrl}/*"
  app.get specsUrl, (req, res) -> 
      path = "#{definition.specsDir()}/#{req.params}"
      core.util.send.scriptFile res, path
      
      # TODO Pre-compile .coffee files.
      
