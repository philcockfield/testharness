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
  var sidebar;
  sidebar = require('../regions/sidebar');
  module.exports = {
    title: 'TestHarness (Client)',
    init: function() {
      return sidebar.init({
        within: 'div.left > div.region.body'
      });
    }
  };
}).call(this);
}, "harness/regions/sidebar/index": function(exports, require, module) {(function() {
  var RootView;
  RootView = require('./views/root');
  module.exports = {
    /*
      Initializes the module.
      @param options
              - within: Element, or selector of element, to start the module within.
      */
    init: function(options) {
      var el, rootView;
      if (options == null) {
        options = {};
      }
      el = options.within;
      if (_.isString(el)) {
        el = $(el);
      }
      rootView = new RootView();
      return el.append(rootView.el);
    }
  };
}).call(this);
}, "harness/regions/sidebar/views/root": function(exports, require, module) {(function() {
  var RootTmpl, RootView, core;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  core = require('core');
  RootTmpl = require('./root.tmpl');
  /*
  The root index control displayed in the left sidebar.
  */
  module.exports = RootView = (function() {
    __extends(RootView, core.mvc.View);
    function RootView() {
      RootView.__super__.constructor.call(this, {
        className: 'root_index'
      });
      this.tmpl = new RootTmpl();
      this.render();
    }
    RootView.prototype.render = function() {
      var tmpl;
      tmpl = this.tmpl;
      return this.html(tmpl.root());
    };
    return RootView;
  })();
}).call(this);
}, "harness/regions/sidebar/views/root.tmpl": function(exports, require, module) {(function() {
  var RootTmpl, core;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  core = require('core');
  /*
  The root index control displayed in the left sidebar.
  */
  module.exports = RootTmpl = (function() {
    __extends(RootTmpl, core.mvc.Template);
    function RootTmpl() {
      RootTmpl.__super__.constructor.apply(this, arguments);
    }
    RootTmpl.prototype.root = "<h3>Left sidebar</h3>";
    return RootTmpl;
  })();
}).call(this);
}});
