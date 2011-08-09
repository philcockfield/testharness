core = require 'open.client/core'

###
The root index control displayed in the left sidebar.
###
module.exports = class RootTmpl extends core.mvc.Template
  root: 
    """
      <div class="th_button_list">
      </div>
    """

  listButton: 
    """
      <div class="th_label">
        <%= tab.label() %>
      </div>
    """
