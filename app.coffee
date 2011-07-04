# Module dependencies.
express = require 'express'

app = module.exports = express.createServer()

# Configuration
app.configure ->
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'

    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.session( secret: 'your secret here' )
    app.use express.compiler( src: __dirname + '/public', enable: ['sass'] )

    app.use app.router
    app.use express.static(__dirname + '/public')
    app.use '/foo', express.static(__dirname + '/node_modules/foo/public')

app.configure 'development', ->
    app.use express.errorHandler( dumpExceptions: true, showStack: true )

app.configure 'production', ->
    app.use express.errorHandler()


# Routes
app.get '/', (req, res)->
    res.render 'index', title: 'TestHarness'

# Start
app.listen(8000);
console.log ''
console.log "TestHarness server listening on port #{app.address().port} in #{app.settings.env} mode"
