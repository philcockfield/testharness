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
  var Definition, shell;
  shell = require('../regions/shell');
  Definition = require('./models/definition');
  /*
  The root application module.
  */
  module.exports = {
    title: 'TestHarness (Client)',
    /*
      Initialize the module.
      @param options
              - specsUrl:   The base URL from which spec files can be loaded from the client.
                            (Default: /specs)
      */
    init: function(options) {
      var _ref;
      if (options == null) {
        options = {};
      }
            if ((_ref = options.specsUrl) != null) {
        _ref;
      } else {
        options.specsUrl = '/specs';
      };
      this.definition = new Definition(options);
      shell.init({
        within: 'body'
      });
      return this.definition.fetch();
    }
  };
}).call(this);
}, "harness/app/models/definition": function(exports, require, module) {(function() {
  var HarnessDefinition, core, formatTitle;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  core = require('open.client/core');
  formatTitle = function(url, options) {
    var title;
    title = _.strRightBack(url, '/');
    title = _.strLeftBack(title, '_spec.js');
    title = title.replace('__', ': ');
    title = title.replace('_', ' ');
    title = _.clean(title);
    title = _.titleize(title);
    title = _.trim(title);
    return title;
  };
  module.exports = HarnessDefinition = (function() {
    __extends(HarnessDefinition, core.mvc.Model);
    HarnessDefinition.prototype.url = '/harness.json';
    HarnessDefinition.prototype.defaults = {
      specs: []
    };
    /*
      Constructor.
      @param options
              - specsUrl:   The base URL from which spec files can be loaded from the client.
                            (Default: /specs)
      */
    function HarnessDefinition(options) {
      this.options = options;
      HarnessDefinition.__super__.constructor.apply(this, arguments);
    }
    HarnessDefinition.prototype.parse = function(response) {
      if (response.specs != null) {
        response.specs = _.map(response.specs, __bind(function(item) {
          if (_.isString(item)) {
            item = {
              title: formatTitle(item, this.options),
              folder: _.strLeftBack(item, '/'),
              url: item
            };
          }
          return item;
        }, this));
      }
      return response;
    };
    return HarnessDefinition;
  })();
}).call(this);
}, "harness/index": function(exports, require, module) {(function() {
  module.exports = {
    app: require('./app'),
    regions: require('./regions')
  };
}).call(this);
}, "harness/regions/index": function(exports, require, module) {(function() {
  module.exports = {
    shell: require('./shell'),
    sidebar: require('./sidebar')
  };
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
  core = require('open.client/core');
  ShellTmpl = require('./shell.tmpl');
  sidebar = require('../../sidebar');
  /*
  The root test harness shell.
  */
  module.exports = ShellView = (function() {
    __extends(ShellView, core.mvc.View);
    function ShellView() {
      ShellView.__super__.constructor.call(this, {
        className: 'th_harness th_shell'
      });
      this.render();
      sidebar.init({
        within: this.$('div.th_left > div.th_region.th_body')
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
  core = require('open.client/core');
  /*
  he root test harness shell
  */
  module.exports = ShellTmpl = (function() {
    __extends(ShellTmpl, core.mvc.Template);
    function ShellTmpl() {
      ShellTmpl.__super__.constructor.apply(this, arguments);
    }
    ShellTmpl.prototype.root = "<div class=\"th_left\">\n  <%= tmpl.header() %>\n  <div class=\"th_region th_body\"></div>\n  <%= tmpl.footer() %>\n</div>\n\n<div class=\"th_main\">\n  <%= tmpl.header() %>\n  <div class=\"th_region th_body\">\n    <%= tmpl.mainDefault() %>\n  </div>\n  <%= tmpl.footer() %>\n</div>";
    ShellTmpl.prototype.header = "<div class=\"th_header th_bar\">\n  <div class=\"bevel highlight\"></div>\n  <div class=\"th_region abs_fill\"></div>\n</div>";
    ShellTmpl.prototype.footer = "<div class=\"th_footer th_bar\">\n  <div class=\"bevel highlight\"></div>\n  <div class=\"th_region abs_fill\"></div>\n</div>";
    ShellTmpl.prototype.mainDefault = "<div class=\"th_welcome abs_fill\">\n  <div class=\"th_grid abs_fill\"></div>\n  <div class=\"th_title abs_fill\"></div>\n</div>  ";
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
      var app, el, rootView;
      if (options == null) {
        options = {};
      }
      app = require('harness/app');
      el = options.within;
      if (_.isString(el)) {
        el = $(el);
      }
      rootView = new RootView(app);
      return el.append(rootView.el);
    }
  };
}).call(this);
}, "harness/regions/sidebar/views/list_button": function(exports, require, module) {(function() {
  var ListButton, controls;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  controls = require('open.client/controls');
  module.exports = ListButton = (function() {
    __extends(ListButton, controls.Button);
    function ListButton(spec) {
      this.spec = spec;
      ListButton.__super__.constructor.call(this, {
        className: 'th_list_button',
        canToggle: true,
        label: this.spec.title
      });
      this.render();
      this.onClick(__bind(function() {
        return console.log('CLICK | => ', this.spec.title);
      }, this));
    }
    ListButton.prototype.onStateChanged = function() {
      return this.render();
    };
    ListButton.prototype.render = function() {
      var html;
      html = "" + this.spec.title + " | over:" + (this.over()) + " | down:" + (this.down()) + " | selected:" + (this.selected());
      this.html(html);
      return this;
    };
    return ListButton;
  })();
}).call(this);
}, "harness/regions/sidebar/views/root": function(exports, require, module) {(function() {
  var Button, RootTmpl, RootView, controls, core;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  core = require('open.client/core');
  controls = require('open.client/controls');
  RootTmpl = require('./root.tmpl');
  Button = require('./list_button');
  /*
  The root index control displayed in the left sidebar.
  */
  module.exports = RootView = (function() {
    __extends(RootView, core.mvc.View);
    function RootView(app) {
      this.app = app;
      RootView.__super__.constructor.call(this, {
        className: 'th_root_index'
      });
      this.tmpl = new RootTmpl();
      this.buttonSet = new controls.ButtonSet();
      this.app.definition.fetch.onComplete(__bind(function(e) {
        if (e.success) {
          return this.render();
        }
      }, this));
    }
    RootView.prototype.render = function() {
      var button, buttons, div, spec, tmpl, _i, _len, _ref;
      tmpl = this.tmpl;
      this.html(tmpl.root());
      this.buttonSet.clear();
      div = this.$('div.th_button_list');
      buttons = [];
      _ref = this.app.definition.specs();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        spec = _ref[_i];
        button = new Button(spec);
        div.append(button.el);
        buttons.push(button);
      }
      buttons[0].canToggle(false);
      this.buttonSet.add(buttons[1]);
      return this.buttonSet.add(buttons[2]);
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
  core = require('open.client/core');
  /*
  The root index control displayed in the left sidebar.
  */
  module.exports = RootTmpl = (function() {
    __extends(RootTmpl, core.mvc.Template);
    function RootTmpl() {
      RootTmpl.__super__.constructor.apply(this, arguments);
    }
    RootTmpl.prototype.root = "<div class=\"th_button_list\">\n</div>";
    RootTmpl.prototype.temp = "<% _.each(specs, function(item) { %> \n  <li class=\"th_spec\">\n    <b>\n      <%= item.title %>\n    </b>\n    <br/>\n    <%= item.folder %>\n    <br/>\n    </li>\n<% }); %>";
    return RootTmpl;
  })();
}).call(this);
}});
