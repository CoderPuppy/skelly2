// Generated by LiveScript 1.2.0
(function(){
  var live, liveDom;
  live = require('../live-data');
  liveDom = exports;
  liveDom.text = function(el){
    if (el == null) {
      throw new Error('need an element');
    }
    return live.cell().on('change', function(val){
      return el.textContent = val;
    });
  };
  liveDom.template = function(el, dom){
    var this$ = this;
    if (el == null) {
      throw new Error('need an element');
    }
    return live.cell().on('change', function(templ){
      var data;
      if (templ != null && typeof templ.bind === 'function' && typeof templ.stream === 'function') {
        data = '';
        return templ.stream().on('data', function(buf){
          return data += buf.toString('utf8');
        }).on('end', function(){
          el.innerHTML = data;
          return templ.bind(el, dom);
        });
      } else {
        return el.innerHTML = '';
      }
    });
  };
}).call(this);
