RootView = require './views/root'

module.exports = 
  ###
  Initializes the module.
  @param options
          - within: Element, or selector of element, to start the module within.
  ###
  init: (options = {}) -> 
    
    # Insert the root view.
    el = options.within
    el = $(el) if _.isString(el)
    rootView = new RootView()
    el.append rootView.el
    
    
    
    
