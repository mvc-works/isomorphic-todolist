
React = require 'react'
$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'app-item'

  render: ->

    $.form key: @props.data.id, className: 'app-item', method: 'post',
      $.input type: 'hidden', name: 'id', value: @props.data.id
      $.input
        type: 'checkbox', className: 'check', name: 'done'
        checked: @props.data.done
        onChange: ->
        value: @props.data.done
      $.input
        type: 'text', name: 'text'
        onChange: ->
        value: @props.data.text
      $.button type: 'submit', formaction: '/update', 'update'
      $.button type: 'submit', formaction: '/remove', 'remove'