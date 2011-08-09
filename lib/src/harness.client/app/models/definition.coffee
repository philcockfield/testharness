core = require 'open.client/core'

formatTitle = (url, options) -> 
    title = _.strRightBack(url, '/')
    title = _.strLeftBack(title, '_spec.js')
    title = _.strLeftBack(title, '_spec.coffee')
    title = title.replace('__', ': ')
    title = title.replace('_', ' ')
    title = _.clean(title)
    title = _.titleize(title)
    title

fileExtension = (url) -> 
    return 'js' if _.endsWith(url, '.js')
    return 'coffee' if _.endsWith(url, '.coffee')

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
              url = _.trim(item)
              item = 
                  title:      formatTitle(url, @options)
                  folder:     _.strLeftBack(url, '/')
                  url:        url
                  extension:  fileExtension(url)
          item
          
    response  
        
        
        
      
    

  
      