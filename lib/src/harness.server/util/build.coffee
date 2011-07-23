module.exports =
  ###
  Builds the entire client scripts to a single package.
  @param options:
            - callback      : invoked upon completion (optional).
                              Passes a function with two properties:
                                - packed: the packed code
                                - minified: the minified code if a minified path was specified
                              The function can be invoked like so:
                                fn(minified):
                                  - minified: true - returns the minified code.
                                  - minified: false - returns the unminified, packed code.
  ###
  client: (callback) ->


      harness  = require 'harness.server'
      core     = harness.core
      folder    = "#{harness.paths.public}/javascripts"

      folders = [
        { source: harness.paths.client, target: '/harness' }
      ]
      compiler  = new core.util.javascript.Compiler(folders, header: harness.copyright( asComment: true ))
      compiler.save
            packed:         "#{folder}/harness.js"
            minified:       "#{folder}/harness-min.js"
            callback:       callback

