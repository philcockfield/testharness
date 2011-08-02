core = require 'core'

module.exports = class Suite extends core.mvc.Model
  constructor: (args) -> 
      super
      @addProps
        specs: []

  url: '/harness.json'
  
      