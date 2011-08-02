shell      = require '../regions/shell'
TestSuite  = require './models/test_suite'
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
    
    # TEMP 
    suite = new TestSuite()
    console.log 'Loading test suite...'
    suite.fetch
        error:   (e) -> console.log 'Error: e', e, e.model
        success: (e) -> 
            console.log 'Success: e', e, e.model
            console.log 'specs', suite.specs()
            console.log 'suite.rootPath', suite.rootPath()
        
    
    
    
    