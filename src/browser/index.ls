stream-to-array = require \stream-to-array
live = require \../live
dom = require \../dom
require! url

class Browser extends live.KV
	(@app) ~>
		super!

		dom.on window, \popstate, (e) ~>
			@navigate window.location.href

		dom.ready ~>
			el = document.body.parentNode

			@navigate window.location.href

			dom.on el, 'click', 'a', (e) ~>
				e.prevent-default!
				@navigate e.srcElement.href

			@app.main-template(@).bind document.body.parentNode, dom

	navigate: (href, back = false) ->
		@set \url, new live.KV(url.parse(href, true))

		if not back
			history.push-state null, href, href

		@

module.exports = Browser