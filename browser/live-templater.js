// Generated by LiveScript 1.2.0
(function(){
  var live, dom, LiveTemplater;
  live = require('../live-data');
  dom = require('../dom');
  LiveTemplater = (function(){
    LiveTemplater.displayName = 'LiveTemplater';
    var prototype = LiveTemplater.prototype, constructor = LiveTemplater;
    function LiveTemplater(client, templ, el){
      var this$ = this instanceof ctor$ ? this : new ctor$;
      this$.client = client;
      this$.templ = templ;
      this$.el = el;
      if (!this$.templ instanceof live.Base) {
        this$.templ = live.cell(this$.templ);
      }
      this$.templ.on('change', function(templ){
        var data;
        data = '';
        return templ.stream().on('data', function(buf){
          return data += buf.toString('utf8');
        }).on('end', function(){
          this.el.innerHTML = data;
          templ.bind(this.el, dom);
          return console.log(this.el);
        });
      });
      return this$;
    } function ctor$(){} ctor$.prototype = prototype;
    return LiveTemplater;
  }());
}).call(this);
