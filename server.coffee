
connect = require 'connect'
React = require 'react'

connectRoute = require 'connect-route'
serveStatic = require 'serve-static'
bodyParser = require 'body-parser'

store = require './build/js/store'
Html = require './src/html'

app = connect()

app.use serveStatic './'

app.use bodyParser.urlencoded extended: yes

app.use connectRoute (router) ->

  router.get '/', (req, res) ->
    res.end React.renderToString (Html data: store.get())

  router.post '/create', (req, res) ->
    store.create req.body.text
    res.end React.renderToString (Html data: store.get())

  router.post '/release', (req, res) ->
    store.release()
    res.end React.renderToString (Html data: store.get())

  router.post '/remove', (req, res) ->
    store.remove req.body.id
    res.end React.renderToString (Html data: store.get())

  router.post '/update', (req, res) ->
    store.update req.body.id, req.body.done?, req.body.text
    res.end React.renderToString (Html data: store.get())

app.listen 3000
console.log 'server started at 3000'