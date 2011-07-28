/*
  Copyright 2011 Phil Cockfield. All rights reserved.
  The MIT License (MIT)
  https://github.com/philcockfield/testharness
*/

(function(/*! Stitch !*/) {
  if (!this.require) {
    var modules = {}, cache = {}, require = function(name, root) {
      var module = cache[name], path = expand(root, name), fn;
      if (module) {
        return module;
      } else if (fn = modules[path] || modules[path = expand(path, './index')]) {
        module = {id: name, exports: {}};
        try {
          cache[name] = module.exports;
          fn(module.exports, function(name) {
            return require(name, dirname(path));
          }, module);
          return cache[name] = module.exports;
        } catch (err) {
          delete cache[name];
          throw err;
        }
      } else {
        throw 'module \'' + name + '\' not found';
      }
    }, expand = function(root, name) {
      var results = [], parts, part;
      if (/^\.\.?(\/|$)/.test(name)) {
        parts = [root, name].join('/').split('/');
      } else {
        parts = name.split('/');
      }
      for (var i = 0, length = parts.length; i < length; i++) {
        part = parts[i];
        if (part == '..') {
          results.pop();
        } else if (part != '.' && part != '') {
          results.push(part);
        }
      }
      return results.join('/');
    }, dirname = function(path) {
      return path.split('/').slice(0, -1).join('/');
    };
    this.require = function(name) {
      return require(name, '');
    }
    this.require.define = function(bundle) {
      for (var key in bundle)
        modules[key] = bundle[key];
    };
  }
  return this.require.define;
}).call(this)({"harness/app/index": function(exports, require, module) {(function() {
  module.exports = {
    title: 'TestHarness (Client)',
    init: function() {
      var sidebar;
      sidebar = require('harness/regions/sidebar');
      return sidebar.init({
        within: 'div.left > div.region.body'
      });
    }
  };
}).call(this);
}, "harness/regions/sidebar/index": function(exports, require, module) {(function() {
  module.exports = {
    /*
      Initializes the module.
      @param options
              - within: Element, or selector of element, to start the module within.
      */
    init: function(options) {
      var elContainer;
      if (options == null) {
        options = {};
      }
      elContainer = options.within;
      if (_.isString(elContainer)) {
        elContainer = $(elContainer);
      }
      console.log('_.isString(elContainer)', _.isString(elContainer));
      return console.log('elContainer', elContainer);
    }
  };
}).call(this);
}});
