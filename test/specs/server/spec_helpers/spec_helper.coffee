paths = require "#{__dirname}/../../../../lib/src/server/config/paths"

global.test =
  paths: paths
  server: require "#{paths.server}/harness.server"
  client: require "#{paths.client}/harness.client"

