express   = require 'express'

module.exports = (harness, options) ->
    app = harness.app
    paths = harness.paths

    app.get '/', (req, res)->
        path = "#{harness.paths.views}/index.jade"
        res.render path,
                title: 'TestHarness'
                baseUrl: options.baseUrl
