
semver = require 'semver'

common = require './common'

exports.task = (opts) ->
  context = common.expand opts

  oldVersion = undefined

  for item in context.files
    config = JSON.parse (cat item.from)
    if oldVersion? and config.version isnt oldVersion
      console.warn "[Bump]: version not matching, prefer the first..."
      config.version = oldVersion
    else oldVersion = config.version
    console.log config.version, context.options.at
    config.version = semver.inc config.version, context.options.at

    common.write item.to, (common.stringify config)

  console.log "done: bumped #{opts.files.join ', '} => #{config.version}"