{CompositeDisposable} = require 'atom'
Gemfile = require './gemfile'
Project = require './project'

module.exports = AtomGemfileUnlock =
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @gemfile = new Gemfile
    @subscriptions = new CompositeDisposable

    # Register command
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-gemfile-unlock:unpack': => @unpack()

  deactivate: ->
    @gemfile = undefined
    @subscriptions.dispose()

  serialize: ->
    # atomGemfileUnlockViewState: @atomGemfileUnlockView.serialize()

  unpack: ->
    if @gemfile.lockExists()
      data = @gemfile.parse()
      project = new Project(data)
      project.load()
    else
      console.log 'no lock file found'
