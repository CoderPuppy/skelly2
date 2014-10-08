live = require \../live-data
require! browserify
require! http
require! url

class Server
	(@app, @browser-main) ~>
		@http-server = http.create-server (req, res) ~>
			req.parsed-url = url.parse(req.url, true)

			if req.parsed-url.pathname == '/bundle.js'
				browserify(@browser-main).bundle(insert-globals: true, detect-globals: false, debug: true).on(\error, (err) ->
					res.write-head 500
					res.end err.stack
				).once(\data, ->
					res.write-head 200, 'Content-Type': 'application/javascript'
				).pipe(res)
			else
				templ = @app.main-template(new RequestClient(@, req))
				res.write-head 200, 'Content-Type': 'text/html' # todo
				# .once \data, ->
				# 	res.write-head 200, 'Content-Type': 'text/html' # todo
				stream = templ.stream!
				# stream.on \error, (err) ->
				# 	res.write-head 500
				# 	res.end err.stack
				stream.pipe(res)

	listen: ->
		@http-server.listen ...arguments

class RequestClient extends live.KV
	(@server, req) ->
		super!

		@set \app, @server.app
		@set \url, req.parsed-url || url.parse(req.url, true)
		@get \url .get \query .bind @get \query
		console.log req.headers

Server.RequestClient = RequestClient

module.exports = Server