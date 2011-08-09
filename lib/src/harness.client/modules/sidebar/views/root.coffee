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
      
      
      # TEMP 
      @buttonSet.bind 'selectionChanged', (e) -> 
            spec = e.button.spec
            console.log 'SELECTION CHANGED', e.button, e.button.label(), spec, spec.url
            url = e.button.spec.url
            
            console.log 'Loading spec file from server....'
            $.get url, (data) -> 
              console.log 'Loaded:'
              console.log data
              console.log ''
            
      
      
    
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
          @buttonSet.add button
          div.append button.el
          buttons.push button
      
      
          
      
      
      
      
    