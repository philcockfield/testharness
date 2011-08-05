core = require 'core.client/core'

module.exports = class TestSuite extends core.mvc.Model
  constructor: (args) -> 
      super
      @addProps
          rootPath: null
          specs:    []

  url: '/harness.json'
  
      