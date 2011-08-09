controls  = require 'open.client/controls'
Tmpl      = require 'harness.client/modules/sidebar/views/tmpl'

module.exports = class ListButton extends controls.Button
  constructor: (@spec) -> 
      super className:'th_list_button', canToggle:true, label:@spec.title
      @render()
      
      # TEMP 
      @onClick () => console.log 'CLICK | => ', @spec.title
      
  onStateChanged: -> @render()
  
  render: -> 
      tmpl = new Tmpl()
      html = tmpl.listButton(spec: @spec)
      

      
      
      @html html
      @
