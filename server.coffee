
fs = require 'fs'

express = require 'express'
React = require 'react'

serveStatic = require 'serve-static'
bodyParser = require 'body-parser'

store = require './source/store'
Layout = require './source/app/layout'

app = express()

urlParser = bodyParser.urlencoded extended: yes
jsonParser = bodyParser.json()

template = fs.readFileSync 'index.html', 'utf8'
renderPage = ->
  body = React.renderToString (Layout data: store.get())
  template.replace '%s', body

# server render

app.get '/', urlParser, (req, res) ->
  res.end renderPage()

app.post '/create', urlParser, (req, res) ->
  store.create req.body.text
  res.end renderPage()

app.post '/release', urlParser, (req, res) ->
  store.release()
  res.end renderPage()

app.post '/remove', urlParser, (req, res) ->
  store.remove req.body.id
  res.end renderPage()

app.post '/update', urlParser, (req, res) ->
  store.update req.body.id, req.body.done?, req.body.text
  res.end renderPage()

# apis

app.get '/api', jsonParser, (req, res) ->
  res.json store.get()

app.post '/api/create', jsonParser, (req, res) ->
  item = store.create req.body.text
  res.json item

app.post '/api/release', jsonParser, (req, res) ->
  store.release()
  res.json {}

app.post '/api/remove', jsonParser, (req, res) ->
  store.remove req.body.id
  res.json {}

app.post '/api/update', jsonParser, (req, res) ->
  store.update req.body.id, req.body.done?, req.body.text
  res.json {}

app.use serveStatic './'

app.listen 3000
console.log 'server started at 3000'