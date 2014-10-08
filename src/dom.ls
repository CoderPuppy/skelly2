dom = -> dom.find(...)

dom.qwery  = require \qwery
dom.find   = dom.qwery
dom.select = dom.qwery

dom.ready = require \domready

dom.walk = require \dom-walk

dom.become = require \become

dom.bean = require \bean
dom.on   = dom.bean.on
dom.one  = dom.bean.one
dom.off  = dom.bean.off
dom.fire = dom.bean.fire
dom.bean.set-selector-engine dom.qwery

dom.atts       = require \atts
dom.attr       = dom.atts.attr
dom.removeAttr = dom.atts.removeAttr
dom.toggleAttr = dom.atts.toggleAttr
dom.hasAttr    = dom.atts.hasAttr
dom.attrs      = dom.atts.anyAttr

dom.ancestors = require \ancestors
dom.parents   = dom.ancestors

dom.alignit = require \alignit

dom.dom-create = require \dom-create
dom.create     = dom.dom-create

dom.live = require \./live-dom

dom.ready -> require \dom-shim

module.exports = dom