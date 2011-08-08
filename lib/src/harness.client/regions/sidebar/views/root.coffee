core      = require 'open.client/core'
RootTmpl  = require './root.tmpl'

###
The root index control displayed in the left sidebar.
###
module.exports = class RootView extends core.mvc.View
  constructor: (@app) -> 
      super className: 'th_root_index'
      @tmpl = new RootTmpl()
      
      # Wire up events.
      @app.definition.fetch.onComplete (e) => 
            @render() if e.success
      
    
  # Renders the control.
  render: -> 
      specs = @app.definition.specs()
      tmpl = @tmpl
      @html tmpl.root(specs:specs)
    