stylus  = require 'stylus'
nib     = require 'nib'
paths   = require './paths'

# Setup CSS (with references to Core).
module.exports =
  configure: (use) ->
      core = require 'open.server'
      compile = (str, path) ->
            stylus(str)
                .include("#{core.paths.public}/stylesheets")
                .include("#{paths.public}/stylesheets")
                .use(nib())
      use stylus.middleware
              src:     paths.public
              compile: compile

