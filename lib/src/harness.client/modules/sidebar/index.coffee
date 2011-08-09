RootView  = require 'harness.client/modules/sidebar/views/root'

module.exports = 
  ###
  Initializes the module.
  @param options
          - within: Element, or selector of element, to start the module within.
  ###
  init: (options = {}) -> 
    app = require 'harness.client/app'
    
    # Insert the root view.
    el = options.within
    el = $(el) if _.isString(el)
    rootView = new RootView(app)
    el.append rootView.el

    
    
    
    
    
