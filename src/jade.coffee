
jade = require 'jade'
path = require 'path'

common = require './common'

exports.task = (opts) ->
  fromPath = path.join opts.from, opts.file
  context = common.expand opts
  options = context.options
  for item in context.files
    html = jade.compile((cat item.from), options) options.data
    common.write item.to, html
  console.log 'done: jade'