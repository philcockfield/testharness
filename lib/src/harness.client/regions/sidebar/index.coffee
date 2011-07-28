module.exports = 
  ###
  Initializes the module.
  @param options
          - within: Element, or selector of element, to start the module within.
  ###
  init: (options = {}) -> 
    
    elContainer = options.within
    elContainer = $(elContainer) if _.isString(elContainer)
    
    console.log '_.isString(elContainer)', _.isString(elContainer)
    console.log 'elContainer', elContainer
    