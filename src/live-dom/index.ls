live = require \../live-data

live-dom = exports

live-dom.text = (el) ->
	if not el?
		throw new Error('need an element')

	live.cell!.on \change, (val) ->
		el.text-content = val

live-dom.template = (el, dom) ->
	if not el?
		throw new Error('need an element')

	live.cell!.on \change, (templ) ~>
		if templ? and typeof(templ.bind) == 'function' and typeof(templ.stream) == 'function'
			data = ''
			templ.stream!.on \data, (buf) ->
				data += buf.to-string \utf8
			.on \end, ->
				el.innerHTML = data
				templ.bind(el, dom)
		else
			el.innerHTML = ''