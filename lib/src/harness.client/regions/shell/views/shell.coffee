core      = require 'core.client/core'
ShellTmpl = require './shell.tmpl'
sidebar   = require '../../sidebar'

###
The root test harness shell.
###
module.exports = class ShellView extends core.mvc.View
  constructor: () -> 
      super className: 'harness shell'
      @render()

      # Sidebar.
      sidebar.init
              within: @$('div.left > div.region.body')
      
    
  # Renders the control.
  render: -> 
      tmpl = new ShellTmpl()
      @html tmpl.root
                  tmpl: tmpl
    