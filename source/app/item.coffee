
React = require 'react'
$ = React.DOM
superagent = require 'superagent'

store = require '../store'

module.exports = React.createFactory React.createClass
  displayName: 'app-item'

  onCheckChange: (event) ->
    store.update @props.data.id, event.target.checked, @props.data.text

  onTextChange: (event) ->
    store.update @props.data.id, @props.data.done, event.target.value

  onSubmit: (event) ->
    event.preventDefault()

  onUpdate: (event) ->
    superagent
    .post '/api/update'
    .send @props.data
    .end (res) ->
      store.emit()

  onRemove: (event) ->
    superagent
    .post '/api/remove'
    .send id: @props.data.id
    .end (res) =>
      store.remove @props.data.id

  render: ->

    $.form
      key: @props.data.id, className: 'app-item', method: 'post'
      onSubmit: @onSubmit
      $.input type: 'hidden', name: 'id', value: @props.data.id
      $.input
        ref: 'check'
        type: 'checkbox', className: 'check', name: 'done'
        checked: @props.data.done
        onChange: @onCheckChange
        value: @props.data.done
      $.input
        ref: 'text'
        type: 'text', name: 'text'
        onChange: @onTextChange
        value: @props.data.text
      $.button
        type: 'submit', formaction: '/update', onClick: @onUpdate
        'update'
      $.button
        type: 'submit', formaction: '/remove', onClick: @onRemove
        'remove'