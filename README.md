# TestHarness

Visual test harness for rich client-side JavaScript applications.

--------

### Install using NPM

    npm install testharness
  

### Including TestHarness in your [Express](http://expressjs.com/) application

```coffee-script

  # Create the server.
  express = require 'express'
  app = express.createServer()

  # Configure your app as you please
  # ...

  # Turn on the TestHarness.
  require('testharness').configure app

  # Start
  app.listen process.env.PORT ?= 8000

```

The **TestHarness** will be available on `http://localhost:8000/testharness`

If you wish to have the harness on a different URL, pass the **baseUrl**
option to `configure` like this:

```coffee-script

  require('testharness').configure app, baseUrl: '/foo'

```

## For Developing TestHarness

### Starting the Development Server
To run the server:

    node app

To run in auto-restart mode while developing, first install
[nodemon](https://github.com/remy/nodemon):

    npm install -g nodemon

Then to start the server, from the application folder:

    nodemon app.js

### Development Home Page
This page provides an index into the various test and UI facets of the FavStar development project:

    http://localhost:3000/dev


## Licence

The [MIT License](http://www.opensource.org/licenses/mit-license.php) (MIT)
Copyright © 2011 Phil Cockfield

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.