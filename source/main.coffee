
superagent = require 'superagent'
React = require 'react'

store = require './store'
Layout = require './app/layout'

window.onload = ->

  store.emit = ->
    component = Layout
      data: store.get()
    React.render component, document.body

  superagent
  .get('/api')
  .end (res) ->
    store.reset res.body