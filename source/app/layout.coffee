
React = require 'react'
$ = React.DOM
superagent = require 'superagent'

store = require '../store'
Item = require './item'

module.exports = React.createFactory React.createClass
  displayName: 'app-layout'

  renderItems: ->
    @props.data
    .sort (a, b) =>
      a.done - b.done
    .map (item) =>
      Item key: item.id, data: item

  onCreate: (event) ->
    event.preventDefault()
    target = event.target[0]
    text = target.value
    superagent
    .post '/api/create'
    .send {text}
    .end (res) ->
      target.value = ''
      store.create text

  onRelease: (event) ->
    event.preventDefault()
    superagent
    .post '/api/release'
    .end (res) ->
      store.release()

  render: ->
    $.div className: 'app-layout',
      $.form
        action: '/'
        method: 'post',
        onSubmit: @onCreate
        $.input type: 'text', name: 'text', required: 'true'
        $.button type: 'submit', formaction: '/create', 'create'
      @renderItems()
      if @props.data.length > 0
        $.form action: '/', method: 'post', onSubmit: @onRelease,
          $.button type: 'submit', formaction: '/release', 'release'