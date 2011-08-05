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
  var TestSuite, shell;
  shell = require('../regions/shell');
  TestSuite = require('./models/test_suite');
  /*
  The root application module.
  */
  module.exports = {
    title: 'TestHarness (Client)',
    init: function() {
      var suite;
      shell.init({
        within: 'body'
      });
      suite = new TestSuite();
      console.log('Loading test suite...');
      return suite.fetch({
        error: function(e) {
          return console.log('Error: e', e, e.model);
        },
        success: function(e) {
          console.log('Success: e', e, e.model);
          console.log('specs', suite.specs());
          return console.log('suite.rootPath', suite.rootPath());
        }
      });
    }
  };
}).call(this);
}, "harness/app/models/test_suite": function(exports, require, module) {(function() {
  var TestSuite, core;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  core = require('core.client/core');
  module.exports = TestSuite = (function() {
    __extends(TestSuite, core.mvc.Model);
    function TestSuite(args) {
      TestSuite.__super__.constructor.apply(this, arguments);
      this.addProps({
        rootPath: null,
        specs: []
      });
    }
    TestSuite.prototype.url = '/harness.json';
    return TestSuite;
  })();
}).call(this);
}, "harness/regions/shell/index": function(exports, require, module) {(function() {
  var ShellView;
  ShellView = require('./views/shell');
  module.exports = {
    /*
      Initializes the root module.
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
      rootView = new ShellView();
      return el.html(rootView.el);
    }
  };
}).call(this);
}, "harness/regions/shell/views/shell": function(exports, require, module) {(function() {
  var ShellTmpl, ShellView, core, sidebar;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  core = require('core.client/core');
  ShellTmpl = require('./shell.tmpl');
  sidebar = require('../../sidebar');
  /*
  The root test harness shell.
  */
  module.exports = ShellView = (function() {
    __extends(ShellView, core.mvc.View);
    function ShellView() {
      ShellView.__super__.constructor.call(this, {
        className: 'harness shell'
      });
      this.render();
      sidebar.init({
        within: this.$('div.left > div.region.body')
      });
    }
    ShellView.prototype.render = function() {
      var tmpl;
      tmpl = new ShellTmpl();
      return this.html(tmpl.root({
        tmpl: tmpl
      }));
    };
    return ShellView;
  })();
}).call(this);
}, "harness/regions/shell/views/shell.tmpl": function(exports, require, module) {(function() {
  var ShellTmpl, core;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  core = require('core.client/core');
  /*
  he root test harness shell
  */
  module.exports = ShellTmpl = (function() {
    __extends(ShellTmpl, core.mvc.Template);
    function ShellTmpl() {
      ShellTmpl.__super__.constructor.apply(this, arguments);
    }
    ShellTmpl.prototype.root = "<div class=\"left\">\n  <%= tmpl.header() %>\n  <div class=\"region body\"></div>\n  <%= tmpl.footer() %>\n</div>\n\n<div class=\"main\">\n  <%= tmpl.header() %>\n  <div class=\"region body\">\n    <%= tmpl.mainDefault() %>\n  </div>\n  <%= tmpl.footer() %>\n</div>";
    ShellTmpl.prototype.header = "<div class=\"header bar\">\n  <div class=\"bevel highlight\"></div>\n  <div class=\"region abs_fill\"></div>\n</div>";
    ShellTmpl.prototype.footer = "<div class=\"footer bar\">\n  <div class=\"bevel highlight\"></div>\n  <div class=\"region abs_fill\"></div>\n</div>";
    ShellTmpl.prototype.mainDefault = "<div class=\"welcome abs_fill\">\n  <div class=\"grid abs_fill\"></div>\n  <div class=\"title abs_fill\"></div>\n</div>  ";
    return ShellTmpl;
  })();
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
  core = require('core.client/core');
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
  core = require('core.client/core');
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
