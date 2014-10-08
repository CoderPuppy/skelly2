Pointer = require \./pointer
Base = require \./base

class Cell extends Base
	(@val) ~>
		super!

	_get: (key) ->
		if @val instanceof Base
			@val._get(key)
		else if @val?
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
				throw new Error('bad') # todo: better
		else if arguments.length >= 1
			if key != @val
				@emit \change, key, @val
				@val = key

			key
		else
			throw new Error 'Cell#set takes one or two arguments'

module.exports = Cell