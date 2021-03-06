fs = require 'fs'

root  = fs.realpathSync("#{__dirname}/../../../..")
lib   = "#{root}/lib"

paths =
    root:   root
    lib:    lib
    public: "#{lib}/public"
    views:  "#{lib}/views"
    src:    "#{lib}/src"
    server: "#{lib}/src/harness.server"
    client: "#{lib}/src/harness.client"
    test:   "#{root}/test"
    specs:  "#{root}/test/specs"
module.exports = paths

# Put the root modules into the global paths.
require.paths.unshift paths.src
