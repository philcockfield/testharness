controls  = require 'open.client/controls'
Tmpl      = require 'harness.client/modules/sidebar/views/tmpl'

module.exports = class ListButton extends controls.Button
  constructor: (@spec) -> 
      super className:'th_list_button', canToggle:true, label:@spec.title
      @render()
      
      # TEMP 
      @onClick () => console.log 'CLICK | => ', @spec.title
  
  updateClasses: => 
      el = @el
      el.toggleClass 'th_over', @over()
      el.toggleClass 'th_selected', @selected()
  
  onStateChanged: -> 
      # @updateClasses()
      
      @render() # TEMP 
      
      
  render: -> 
      
      tmpl = new Tmpl()
      html = tmpl.listButton(tab:@)
      @html html
      @updateClasses()
      @
