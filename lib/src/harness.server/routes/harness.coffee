harness = require 'harness.server'

module.exports = -> 
  app = harness.app
  
  # Route: Harness definition (JSON).
  app.get "#{harness.baseUrl}/harness.json", (req, res) -> 
      definition = require 'harness.server/util/harness_definition'
      definition.load (data) -> res.json data
          
        
  

