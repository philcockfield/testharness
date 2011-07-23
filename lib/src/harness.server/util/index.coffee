module.exports =
  build: require './build'

  ###
  Renders the specified template from the 'views' path.
  @param response   : object to write to.
  @param template   : path to the template within the 'views' folder.
  @param options    : variables to pass to the template.
  ###
  render: (response, template, options = {}) ->
          harness = require 'harness.server'
          extension = options.extension ?= 'jade'
          options.baseUrl ?= harness.baseUrl
          response.render "#{harness.paths.views}/#{template}.#{extension}", options
