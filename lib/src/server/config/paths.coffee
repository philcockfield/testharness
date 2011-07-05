fs = require 'fs'

root  = fs.realpathSync("#{__dirname}/../../../..")
lib   = "#{root}/lib"

module.exports =
    root:   root
    lib:    lib
    public: "#{lib}/public"
    views:  "#{lib}/views"
    server: "#{lib}/src/server"
    client: "#{lib}/src/client"
