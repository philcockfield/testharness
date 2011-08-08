controls = require 'open.client/controls'

module.exports = class ListButton extends controls.Button
  constructor: (params) -> 
      super params
      @render()
      
  
  render: -> 
      @html 'ListButton'
      @
