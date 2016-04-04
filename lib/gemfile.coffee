fs = require 'fs'
module.exports =
class Gemfile
  constructor: ()->
    @projectPath = atom.project.getPaths()[0]
    @lockFilePath = [@projectPath, 'Gemfile.lock'].join('/')

  lockExists: ()->
    fs.existsSync(@lockFilePath)
