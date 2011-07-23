express = require 'express'
configure = require "#{harness.paths.server}/config/configure"

describe 'server/config', ->
  app = null

  beforeEach ->
      test.resetServer()
      app = express.createServer()

  it 'stores the app reference on the server', ->
    configure(harness, app)
    expect(harness.app).toEqual app

  describe 'baseUrl', ->
    it 'puts default baseUrl on the server', ->
      configure(harness, app)
      expect(harness.baseUrl).toEqual '/testharness'

    it 'puts custom baseUrl on the server', ->
      configure(harness, app, baseUrl:'/foo')
      expect(harness.baseUrl).toEqual '/foo'

    it 'stores baseUrl of / as empty string', ->
      configure(harness, app, baseUrl:'/')
      expect(harness.baseUrl).toEqual ''







