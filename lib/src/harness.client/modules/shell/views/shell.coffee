core      = require 'open.client/core'
ShellTmpl = require 'harness.client/modules/shell/views/shell.tmpl'
sidebar   = require 'harness.client/modules/sidebar'

###
The root test harness shell.
###
module.exports = class ShellView extends core.mvc.View
  constructor: () -> 
      super className: 'th_harness th_shell'
      @render()

      # Sidebar.
      sidebar.init
              within: @$('div.th_left > div.th_region.th_body')
      
    
  # Renders the control.
  render: -> 
      tmpl = new ShellTmpl()
      @html tmpl.root
                  tmpl: tmpl
    