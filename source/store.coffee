
shortid = require 'shortid'
store = []

exports.emit = ->
  console.log 'store change'

exports.get = ->
  store

exports.reset = (data) ->
  store = data
  @emit()

exports.create = (text) ->
  data =
    id: shortid.generate()
    text: text
    done: no

  store.unshift data
  @emit()
  data

exports.update = (id, done, text) ->
  for item in store
    if item.id is id
      item.text = text
      item.done = done
      @emit()
      break

exports.remove = (id) ->
  for item, index in store
    if item.id is id
      store.splice index, 1
      @emit()
      break

exports.release = ->
  store = store.filter (item) ->
    not item.done
  @emit()