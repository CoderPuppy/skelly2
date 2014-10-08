Base = require \./base

get = (pointer) ->
	if pointer.kv instanceof Base
		pointer.kv._get(pointer.key)
	else
		pointer.kv[pointer.key]

set = (pointer, val) ->
	if pointer.kv instanceof Base
		pointer.kv.set(pointer.key, val)
	else
		pointer.kv[pointer.key] = val

class Pointer extends Base
	(@kv, @key, @live) ~>
		super!

		custom-emit = ~>
			@emit ...
			old-emit.call(@val, ...)

		@val = get @

		if @val? && typeof(@val.emit) == 'function'
			old-emit = @val.emit
			@val.emit = custom-emit

		if @kv instanceof Base
			@kv.on \change, ~>
				new-val = get @
				old-val = @val

				if old-val? && typeof(old-val.emit) == 'function'
					old-val.emit = old-emit

				if new-val? and typeof(new-val.emit) == 'function'
					old-emit = new-val.emit
					new-val.emit = custom-emit

				@val = new-val

				if new-val != old-val
					@emit \change, new-val, old-val

			@kv.on "change:#{@key}", (new-val, old-val) ~>
				if old-val? and typeof(old-val.emit) == 'function'
					old-val.emit = old-emit

				if new-val? and typeof(new-val.emit) == 'function'
					old-emit = new-val.emit
					new-val.emit = custom-emit

				@val = new-val

				@emit \change, new-val, old-val

	_get: (key) ->
		if @val instanceof Base
			@val._get(key)
		else
			@val[key]

	get: (key, live = true) ->
		if key?
			new Pointer(@, key, live)
		else
			@val

	set: (key, val) ->
		if arguments.length >= 2
			if @val instanceof Base
				@val.set(key, val)
			else if @val?
				@val[key] = val
			else
				throw new Error('nothing here yet') # todo: fix
		else if arguments.length >= 1
			set @, val
		else
			throw new Error 'Pointer#set takes one or two arguments'

module.exports = Pointer