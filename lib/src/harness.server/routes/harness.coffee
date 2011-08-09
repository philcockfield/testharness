express = require 'express'
harness = null
core    = null
options = null

setDefaults = (options = {}) -> 
    options.specsDir ?= 'test/harness'
    options.specsUrl ?= '/specs'
    options

specsDir = -> 
    dir = options.specsDir
    dir = _.lstrip(dir, '/')
    dir = "#{process.env.PWD}/#{dir}"

supportedFile = (path) -> 
    return true if _.endsWith(path, '_spec.js')
    return true if _.endsWith(path, '_spec.coffee')
    return false

specPaths = (callback) -> 
    fs = core.util.fs
    dir = specsDir()
    url = _.rtrim(options.specsUrl, '/')
    
    # 1. Do a deep retrieval of all paths within the specs directory.
    fs.readDir dir, hidden:false, deep:true, (err, paths) -> 
          if err?
              if err.code is fs.ERROR.NOT_EXIST
                err.message = "Cannot get TestHarness specification paths. The directory does not exist: #{dir}"
              throw err
            
          # 2. Filter for '_spec' files only and format into URL.
          paths = _.map paths, (path) -> 
                      return if not supportedFile(path)
                      path = _.strRight(path, dir + '/')
                      "#{url}/#{path}"
          paths = _.compact(paths)
          callback?(paths)
    

jsonDefinition = (callback) -> 
    specPaths (paths) -> 
        def = 
            specs: paths
        callback?(def)
    

module.exports = -> 
  # Setup initial conditions.
  harness         = require 'harness.server'
  harness.options = setDefaults(harness.options)
  options         = harness.options
  core            = harness.core
  
  # Route: Harness definition (JSON).
  harness.app.get "#{harness.baseUrl}/harness.json", (req, res) -> 
      jsonDefinition (def) -> 
          res.json def
        
  

