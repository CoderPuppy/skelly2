Pointer = require \./pointer
Base      = require \./base

class KV extends Base
	(@store = {}) ~>

	_get: (key) -> @store[key]

	get: (key, live = true) ~>
		if key?
			new Pointer(@, key, live)
		else
			@store

	set: (key, val) ~>
		if arguments.length >= 2
			if val != @store[key]
				@emit "change:#{key}", val, @store[key]
				@store[key] = val

			val
		else if arguments.length >= 1
			@emit \change, val, @store
			@store = val
		else
			throw new Error 'KV#set takes one or two arguments'

module.exports = KV