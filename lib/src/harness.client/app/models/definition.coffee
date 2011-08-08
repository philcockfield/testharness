core = require 'open.client/core'

formatTitle = (url, options) -> 
    title = _.strRightBack(url, '/')
    title = _.strLeftBack(title, '_spec.js')
    title = title.replace('__', ': ')
    title = title.replace('_', ' ')
    title = _.clean(title)
    title = _.titleize(title)
    title = _.trim(title)
    title
    

module.exports = class HarnessDefinition extends core.mvc.Model
  url: '/harness.json'
  defaults: 
      specs: []

  ###
  Constructor.
  @param options
          - specsUrl:   The base URL from which spec files can be loaded from the client.
                        (Default: /specs)
  ###
  constructor: (@options) -> 
      super

  parse: (response) -> 
    
    if response.specs?
      response.specs = _.map response.specs, (item) => 
          if _.isString(item)
              item = 
                title: formatTitle(item, @options)
                folder: _.strLeftBack(item, '/')
                url: item
          item
          
    response  
        
        
        
      
    

  
      