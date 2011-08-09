express  = require 'express'
harness  = require 'harness.server'
core     = harness.core

setDefaults = (options = {}) -> 
    options.specsDir ?= 'test/harness'
    options.specsUrl ?= '/specs'
    options

specsDir = (options) -> 
    dir = options.specsDir
    dir = _.lstrip(dir, '/')
    dir = "#{process.env.PWD}/#{dir}"

supportedFile = (path) -> 
    return true if _.endsWith(path, '_spec.js')
    return true if _.endsWith(path, '_spec.coffee')
    return false


specPaths = (options, callback) -> 
    fs = core.util.fs
    dir = specsDir(options)
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

# Exports
module.exports =
    ###
    Loads the Harness.json definition
    @param callback(data) : Returns the Harness definiton.
    ###
    load: (callback) -> 
        options = harness.options
        specPaths options, (paths) -> 
            def = 
                specs: paths
            callback?(def)
        
        
