# TestHarness

Visual test harness for rich client-side JavaScript applications.


#### Install using NPM

    npm install testharness


#### Running from Express

```coffee-script
  # Create the server
  express = require 'express'
  app = express.createServer()

  # Configure your app as you please...

  # Configure the TestHarness
  testharness = require 'testharness'
  testharness.configure app

  # Start
  app.listen(process.env.PORT || 3000);
```

The TestHarness will be available on `/testharness`

If you wish to have the harness on a different URL, pass the `baseUrl`
option to configure like this:

```coffee-script
    testharness.configure app, baseUrl: '/foo'
```