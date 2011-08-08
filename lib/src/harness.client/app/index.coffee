shell      = require '../regions/shell'
Definition  = require './models/definition'

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
    
    # Create child models.
    @definition = new Definition(options)
    
    # Root shell.
    shell.init
          within: 'body'
    
    
    # Load state from server.
    @definition.fetch()
        
    
    
    
    