
chokidar = require 'chokidar'
path = require 'path'

common = require './common'

exports.task = (opts) ->
  context = common.expand opts

  files = context.files

  files.forEach (item) ->
    watcher = chokidar.watch item.from,
      ignored: /[\/\\]\./
      persistent: true
    watcher.on 'change', (filepath) ->
      extname = path.extname filepath
      context.trigger filepath, extname

  fileFroms = files.map (item) ->
    item.from
  console.log "done: watching #{fileFroms.join(' ')}"