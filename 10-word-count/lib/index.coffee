through2 = require 'through2'

WordCount = ->
  words = 0
  lines = 1
  characters = 0
  bytes = 0

  transform = (chunk, encoding, cb) ->
    tokens = chunk.match(/".*?"|[\w][a-z]+|\b\w+\b/g)
    words = tokens.length
    lines = chunk.split(/[\r\n|\r|\n](?=.)/g).length
    characters = chunk.length
    bytes = Buffer.byteLength(chunk)
    return cb()

  flush = (cb) ->
    this.push {words, lines, characters, bytes}
    this.push null
    return cb()

  return through2.obj transform, flush

module.exports = WordCount