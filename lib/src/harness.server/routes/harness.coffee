fs           = require 'fs'
coffee       = require 'coffee-script'
harness      = require 'harness.server'
definition   = require 'harness.server/util/harness_definition'
core         = harness.core
send         = core.util.send


compileCoffee = (path, callback) -> 
    fs.readFile path, 'utf8', (err, src) -> 
        callback coffee.compile(src)


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
      if _.endsWith(path, '.coffee')
          # Send .coffee file.
          compileCoffee path, (spec) -> send.script res, spec
      else
          # Send .js file.
          send.scriptFile res, path
      
      
