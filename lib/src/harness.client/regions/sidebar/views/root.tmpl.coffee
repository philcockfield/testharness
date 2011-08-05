core = require 'core.client/core'

###
The root index control displayed in the left sidebar.
###
module.exports = class RootTmpl extends core.mvc.Template
  root: """
          <h3>Left sidebar</h3>
        """
