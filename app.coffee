# Module dependencies.
express = require 'express'
config = require './lib/src/server/config'

app = module.exports = express.createServer()
paths = require './lib/src/server/config/paths'


baseUrl = '/testharness'
config app, baseUrl: baseUrl

# Routes
app.get '/', (req, res)->
    path = "#{paths.views}/index.jade"
    res.render path,
            title: 'TestHarness'
            baseUrl: baseUrl


# Start
app.listen(8000);
console.log ''
console.log "TestHarness server listening on port #{app.address().port} in #{app.settings.env} mode"
