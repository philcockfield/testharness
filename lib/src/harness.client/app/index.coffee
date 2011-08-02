shell      = require '../regions/shell'
SuiteModel = require './models/suite'
# sidebar = require '../regions/sidebar'

###
The root application module.
###
module.exports =
  title: 'TestHarness (Client)'
  
  init: -> 
    # Root shell.
    shell.init
          within: 'body'
    
    console.log 'SuiteModel', SuiteModel
    suite = new SuiteModel()
    
    # TEMP 
    suite.fetch
        error:   (e) -> console.log 'Error: e', e, e.model
        success: (e) -> 
            console.log 'Success: e', e, e.model
            console.log 'specs', suite.specs()
        
    
    
    
    