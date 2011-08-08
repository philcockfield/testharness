core      = require 'open.client/core'
RootTmpl  = require './root.tmpl'
Button    = require './list_button'

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
      # Base HTML.
      tmpl = @tmpl
      @html tmpl.root()
      
      # Add buttons.
      div = @$('div.th_button_list')
      for spec in @app.definition.specs()
          button = new Button(spec:spec)
          div.append button.el
          
      
      
      
      
    