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
      Builder    = core.util.javascript.Builder

      paths = [
        { path: harness.paths.client, namespace: 'harness.client' }
      ]
      
      builder = new Builder(paths, header: harness.copyright( asComment: true ))
      builder.save dir:"#{harness.paths.public}/javascripts", name:'harness', callback

