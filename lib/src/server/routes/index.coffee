express = require 'express'

module.exports = (harness, options) ->
    app = harness.app
    paths = harness.paths

    baseUrl = options.baseUrl
    baseUrl = '' if baseUrl is '/'

    app.get options.baseUrl, (req, res)->
        path = "#{harness.paths.views}/index.jade"
        res.render path,
                title: 'TestHarness'
                baseUrl: baseUrl
