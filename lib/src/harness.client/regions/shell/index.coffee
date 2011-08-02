ShellView = require './views/shell'

module.exports = 
  ###
  Initializes the root module.
  @param options
          - within: Element, or selector of element, to start the module within.
  ###
  init: (options = {}) -> 
    
    # Insert the root view.
    el = options.within
    el = $(el) if _.isString(el)
    rootView = new ShellView()
    el.html rootView.el
    
    
    
    
    
