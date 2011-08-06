{exec}  = require 'child_process'
harness = require './lib/src/harness.server'
core    = require 'open.core'

logDone = -> core.util.log 'Done', color.green


task 'specs', 'Runs the Jasmine BDD specs', ->
  exec 'jasmine-node --color --coffee test/specs/harness.server', (err, stdout, stderr) ->
      console.log stdout + stderr

task 'build', 'Packages all client-code into files', ->
  console.log 'Building all client-code into files...'
  harness.util.build.client (result) ->
          console.log ' - Packed file:   ', result.paths.packed
          console.log ' - Minified file: ', result.paths.minified
          logDone()
          console.log ''

