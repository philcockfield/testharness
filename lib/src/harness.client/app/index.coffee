module.exports =
  title: 'TestHarness (Client)'
  
  init: -> 
    # Sidebar.
    sidebar = require 'harness/regions/sidebar'
    sidebar.init
            within: 'div.left > div.region.body'
    