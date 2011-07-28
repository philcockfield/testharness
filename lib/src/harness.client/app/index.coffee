sidebar = require '../regions/sidebar'

module.exports =
  title: 'TestHarness (Client)'
  
  init: -> 
    # Sidebar.
    sidebar.init
            within: 'div.left > div.region.body'
    
    