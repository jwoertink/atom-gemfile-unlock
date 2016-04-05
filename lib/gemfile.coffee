fs = require 'fs'
module.exports =
class Gemfile
  @WHITESPACE = /^(\s*)/
  @GEMFILE_KEY_VALUE = /^\s*([^:(]*)\s*\:*\s*(.*)/

  constructor: ()->
    @projectPath = atom.project.getPaths()[0]
    @lockFilePath = [@projectPath, 'Gemfile.lock'].join('/')

  lockExists: ()->
    fs.existsSync(@lockFilePath)

  parse: ()->
    file = fs.readFileSync(@lockFilePath, 'utf8')
    stack = []
    lockFile = {}
    lines = file.split("\n")
    index = 0
    previousWhitespace = -1
    while (line = lines[index++]) != undefined
      whitespace = Gemfile.WHITESPACE.exec(line)[1].length
      if whitespace <= previousWhitespace
        stackIndex = stack.length - 1
        while stack[stackIndex] and whitespace <= stack[stackIndex].depth
          stack.pop()
          stackIndex--
      previousWhitespace = whitespace
      parts = Gemfile.GEMFILE_KEY_VALUE.exec(line)
      key = parts[1].trim()
      value = parts[2] or ''
      if key?
        level = lockFile
        stackIndex = 0
        while stackIndex < stack.length
          if level[stack[stackIndex].key]
            level = level[stack[stackIndex].key]
          stackIndex++
        data = {}
        if value.indexOf('/') > -1
          data.path = value
        else if value.indexOf('(') > -1
          if value[value.length - 1] == '!'
            value = value.substring(0, value.length - 1)
            data.outsourced = true
          if value[1] != ')'
            data.version = value.substring(1, value.length - 1)
        else if /\b[0-9a-f]{7,40}\b/.test(value)
          data.sha = value
        level[key] = data
        stack.push(key: key, depth: whitespace)
    keys = Object.keys(lockFile)
    hasGemKey = keys.indexOf('GEM') > -1
    hasDependenciesKey = keys.indexOf('DEPENDENCIES') > -1
    hasPlatformsKey = keys.indexOf('PLATFORMS') > -1
    if lockFile['BUNDLED WITH']?
      lockFile['BUNDLED WITH'] = Object.keys(lockFile['BUNDLED WITH'])[0]
    lockFile
