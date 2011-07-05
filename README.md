# TestHarness

Visual test harness for rich client-side JavaScript applications.


### Install
Using NPM:

    npm install testharness


### Running from Express

    # Create the server.
    express = require 'express'
    app = express.createServer()

    # ... Do the setup on your app.

    # Configure the TestHarness.
    testharness = require 'testharness'
    testharness.configure app, baseUrl: '/harness'

    # Start.
    app.listen(process.env.PORT || 3000);
