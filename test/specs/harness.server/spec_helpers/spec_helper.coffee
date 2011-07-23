paths = require "#{__dirname}/../../../../lib/src/harness.server/config/paths"
global.harness = require 'harness.server'

global.test =
  paths: paths
  server: harness
  client: harness.client

