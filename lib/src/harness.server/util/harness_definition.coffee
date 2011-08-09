express  = require 'express'
harness  = require 'harness.server'
core     = harness.core

supportedFile = (path) -> 
    return true if _.endsWith(path, '_spec.js')
    return true if _.endsWith(path, '_spec.coffee')
    return false


# Exports.
# NOTE: Default options are declared on the harness in the Configuration module.
module.exports =
  ###
  Loads the Harness.json definition
  @param callback(data) : Returns the Harness definiton.
  ###
  load: (callback) -> 
      @specPaths (paths) -> 
          def = 
              specs: paths
          callback?(def)

  ###
  Retrieves the physical directory containing the specifications.
  ###
  specsDir: -> 
      dir = harness.options.specsDir
      dir = _.lstrip(dir, '/')
      dir = "#{process.env.PWD}/#{dir}"


  ###
  Retrieves the array of URL paths to all spec files.
  @param callback(paths) : Returns the paths array.
  ###
  specPaths: (callback) -> 
      fs = core.util.fs
      dir = @specsDir()
      url = _.rtrim(harness.options.specsUrl, '/')
    
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
        
