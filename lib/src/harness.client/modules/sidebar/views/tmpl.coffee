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
        <%= tab.label() + ' | ' + tab.selected() %>
      </div>
    """
    
  
  
  # TEMP 
  temp:
    """
        <% _.each(specs, function(item) { %> 
          <li class="th_spec">
            <b>
              <%= item.title %>
            </b>
            <br/>
            <%= item.folder %>
            <br/>
            </li>
        <% }); %>
    """
    