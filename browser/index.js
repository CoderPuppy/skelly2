// Generated by LiveScript 1.2.0
(function(){
  var streamToArray, live, dom, url, Browser;
  streamToArray = require('stream-to-array');
  live = require('../live');
  dom = require('../dom');
  url = require('url');
  Browser = (function(superclass){
    var prototype = extend$((import$(Browser, superclass).displayName = 'Browser', Browser), superclass).prototype, constructor = Browser;
    function Browser(app){
      var this$ = this instanceof ctor$ ? this : new ctor$;
      this$.app = app;
      Browser.superclass.call(this$);
      dom.on(window, 'popstate', function(e){
        return this$.navigate(window.location.href);
      });
      dom.ready(function(){
        var el;
        el = document.body.parentNode;
        this$.navigate(window.location.href);
        dom.on(el, 'click', 'a', function(e){
          e.preventDefault();
          return this$.navigate(e.srcElement.href);
        });
        return this$.app.mainTemplate(this$).bind(document.body.parentNode, dom);
      });
      return this$;
    } function ctor$(){} ctor$.prototype = prototype;
    prototype.navigate = function(href, back){
      back == null && (back = false);
      this.set('url', new live.KV(url.parse(href, true)));
      if (!back) {
        history.pushState(null, href, href);
      }
      return this;
    };
    return Browser;
  }(live.KV));
  module.exports = Browser;
  function extend$(sub, sup){
    function fun(){} fun.prototype = (sub.superclass = sup).prototype;
    (sub.prototype = new fun).constructor = sub;
    if (typeof sup.extended == 'function') sup.extended(sub);
    return sub;
  }
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
