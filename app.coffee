# Module dependencies.
express = require 'express'
config = require './lib/src/server/config'

app = module.exports = express.createServer()
paths = require './lib/src/server/config/paths'

baseUrl = '/foo' # TEMP
config app, baseUrl: baseUrl

# Routes
app.get '/', (req, res)->
    path = "#{paths.views}/index.jade"
    res.render path,
            title: 'TestHarness'
            baseUrl: baseUrl


#app.get "#{baseUrl}/stylesheets/*", (req, res) ->
#    sass = require 'sass'
#    console.log 'FOO', sass

    


# Start
app.listen(8000);
console.log ''
console.log "TestHarness server listening on port #{app.address().port} in #{app.settings.env} mode"
