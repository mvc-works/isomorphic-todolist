
React = require 'react'
$ = React.DOM

Item = require './item'

module.exports = React.createFactory React.createClass
  displayName: 'app-layout'

  renderItems: ->
    @props.data
    .sort (a, b) =>
      a.done - b.done
    .map (item) =>
      Item key: item.id, data: item

  render: ->
    $.div className: 'app-layout',
      $.form action: '/', method: 'post',
        $.input type: 'text', name: 'text', required: 'true'
        $.button type: 'submit', formaction: '/create', 'create'
      @renderItems()
      if @props.data.length > 0
        $.form action: '/', method: 'post',
          $.button type: 'submit', formaction: '/release', 'release'