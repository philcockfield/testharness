shell      = require '../regions/shell'
Definition  = require './models/definition'
# sidebar = require '../regions/sidebar'

###
The root application module.
###
module.exports =
  title: 'TestHarness (Client)'
  
  ###
  Initialize the module.
  @param options
          - specsUrl:   The base URL from which spec files can be loaded from the client.
                        (Default: /specs)
  ###
  init: (options = {}) -> 
    
    # Setup initial conditions.
    options.specsUrl ?= '/specs'
    
    # Root shell.
    shell.init
          within: 'body'
    
    # TEMP 
    def = new Definition(options)
    console.log 'Loading Definition...'
    def.fetch
        error:   (e) -> console.log 'Error: e', e, e.model
        success: (e) -> 
            console.log 'Success: e', e, def
            console.log 'specs', def.specs()
        
    
    
    
    