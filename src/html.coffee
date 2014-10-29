
React = require 'react'
$ = React.DOM

Layout = require '../source/app/layout'

module.exports = React.createFactory React.createClass
  displayName: 'app-html'

  render: ->
    $.html {},
      $.head {},
        $.title {}, 'Todolist'
        $.script src: 'build/vendor.min.js'
        $.script src: 'build/main.js'
        $.link rel: 'stylesheet', href: 'source/main.css'
      $.body {},
        Layout data: @props.data