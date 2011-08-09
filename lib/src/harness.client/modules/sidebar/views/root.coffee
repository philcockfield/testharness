core      = require 'open.client/core'
controls  = require 'open.client/controls'
Tmpl      = require 'harness.client/modules/sidebar/views/tmpl'
Button    = require 'harness.client/modules/sidebar/views/list_button'

###
The root index control displayed in the left sidebar.
###
module.exports = class RootView extends core.mvc.View
  constructor: (@app) -> 
      super className: 'th_root_index'
      @buttonSet  = new controls.ButtonSet()
      
      # Wire up events.
      @app.definition.fetch.onComplete (e) => 
            @render() if e.success
      
    
  # Renders the control.
  render: -> 
      # Base HTML.
      tmpl = new Tmpl()
      @html tmpl.root()
      
      # Add buttons.
      @buttonSet.clear()
      div = @$('div.th_button_list')
      
      buttons = []
      
      for spec in @app.definition.specs()
          button = new Button(spec)
          # @buttonSet.add button
          div.append button.el
          buttons.push button
      
      # TEMP 
      buttons[0].canToggle false
      @buttonSet.add buttons[1]
      @buttonSet.add buttons[2]
      
          
      
      
      
      
    