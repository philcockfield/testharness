core = require 'open.client/core'

###
The root index control displayed in the left sidebar.
###
module.exports = class RootTmpl extends core.mvc.Template
  root: 
    """
      <ul class="th_specs">
        <% _.each(specs, function(item) { %> 
          <li class="th_spec">
            <%= item.title %>
          </li>
        <% }); %>
      </ul>
    """
