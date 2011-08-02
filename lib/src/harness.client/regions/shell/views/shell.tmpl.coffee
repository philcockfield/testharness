core = require 'core'

###
he root test harness shell
###
module.exports = class ShellTmpl extends core.mvc.Template
  root: 
    """
    <div class="left">
      <%= tmpl.header() %>
      <div class="region body"></div>
      <%= tmpl.footer() %>
    </div>

    <div class="main">
      <%= tmpl.header() %>
      <div class="region body">
        <%= tmpl.mainDefault() %>
      </div>
      <%= tmpl.footer() %>
    </div>
    """
  
  header: 
    """
    <div class="header bar">
      <div class="bevel highlight"></div>
      <div class="region abs_fill"></div>
    </div>
    """

  footer: 
    """
    <div class="footer bar">
      <div class="bevel highlight"></div>
      <div class="region abs_fill"></div>
    </div>
    """

  mainDefault:
    """
    <div class="welcome abs_fill">
      <div class="grid abs_fill"></div>
      <div class="title abs_fill"></div>
    </div>  
    """
  