fs = require 'fs'

root  = fs.realpathSync("#{__dirname}/../../..")

module.exports =
    root: root
    public: "#{root}/public"
    views: "#{root}/views"
