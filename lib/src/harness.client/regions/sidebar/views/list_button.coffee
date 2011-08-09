controls = require 'open.client/controls'

module.exports = class ListButton extends controls.Button
  constructor: (@spec) -> 
      super className:'th_list_button', canToggle:true, label:@spec.title
      @render()
      
      # TEMP 
      @onClick () => console.log 'CLICK | => ', @spec.title
      
  onStateChanged: -> @render()
  
  render: -> 
      html = "#{@spec.title} | over:#{@over()} | down:#{@down()} | selected:#{@selected()}" # TEMP 
      @html html
      @
