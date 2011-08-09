core = require 'open.client/core'

###
he root test harness shell
###
module.exports = class ShellTmpl extends core.mvc.Template
  root: 
    """
    <div class="th_left">
      <%= tmpl.header() %>
      <div class="th_region th_body"></div>
      <%= tmpl.footer() %>
    </div>

    <div class="th_main">
      <%= tmpl.header() %>
      <div class="th_region th_body">
        <%= tmpl.mainDefault() %>
      </div>
      <%= tmpl.footer() %>
    </div>
    """
  
  header: 
    """
    <div class="th_header th_bar">
      <div class="bevel highlight"></div>
      <div class="th_region abs_fill"></div>
    </div>
    """

  footer: 
    """
    <div class="th_footer th_bar">
      <div class="bevel highlight"></div>
      <div class="th_region abs_fill"></div>
    </div>
    """

  mainDefault:
    """
    <div class="th_welcome abs_fill">
      <div class="th_grid abs_fill"></div>
      <div class="th_title abs_fill"></div>
    </div>  
    """
  