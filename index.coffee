# Put the TestHarness module into the global paths.
paths = require './lib/src/server/config/paths'
require.paths.unshift paths.server

# Alias from here to the actual TestHarness module.
module.exports = require 'testharness'


