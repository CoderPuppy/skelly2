EE   = require \events .EventEmitter

class Base implements EE::
	->
		@on \newListener, (name, fn) ~>
			if name == \change
				fn @get!

	pipe: (other) ->
		other.set @get!

		@on \change, (new-val) ->
			other.set new-val

		other

	bind: (other) ->
		other.pipe(@).pipe(other)

	map: (fn) ->
		other = require(\./cell)!

		@on \change, (val) ->
			other.set fn(val)

		other

module.exports = Base