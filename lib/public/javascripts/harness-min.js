/*
  Copyright 2011 Phil Cockfield. All rights reserved.
  The MIT License (MIT)
  https://github.com/philcockfield/testharness
*/
(function(){if(!this.require){var a={},b={},c=function(f,g){var h=b[f],i=d(g,f),j;if(h)return h;if(!(j=a[i]||a[i=d(i,"./index")]))throw"module '"+f+"' not found";h={id:f,exports:{}};try{b[f]=h.exports,j(h.exports,function(a){return c(a,e(i))},h);return b[f]=h.exports}catch(k){delete b[f];throw k}},d=function(a,b){var c=[],d,e;/^\.\.?(\/|$)/.test(b)?d=[a,b].join("/").split("/"):d=b.split("/");for(var f=0,g=d.length;f<g;f++)e=d[f],e==".."?c.pop():e!="."&&e!=""&&c.push(e);return c.join("/")},e=function(a){return a.split("/").slice(0,-1).join("/")};this.require=function(a){return c(a,"")},this.require.define=function(b){for(var c in b)a[c]=b[c]}}return this.require.define}).call(this)({"harness/harness.client":function(a,b,c){(function(){c.exports={title:"TestHarness (Client)"}}).call(this)}})