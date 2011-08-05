core      = require 'core.client/core'
RootTmpl  = require './root.tmpl'

###
The root index control displayed in the left sidebar.
###
module.exports = class RootView extends core.mvc.View
  constructor: () -> 
      super className: 'root_index'
      @tmpl = new RootTmpl()
      @render()
    
  # Renders the control.
  render: -> 
      tmpl = @tmpl
      @html tmpl.root()
    