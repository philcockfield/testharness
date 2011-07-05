express   = require 'express'

module.exports = (harness, options) ->
    testharness = require('testharness')
    app = harness.app

    app.get '/', (req, res)->
        path = "#{harness.paths.views}/index.jade"
        res.render path,
                title: 'TestHarness'
                baseUrl: options.baseUrl
