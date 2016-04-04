{CompositeDisposable} = require 'atom'
Gemfile = require './gemfile'

module.exports = AtomGemfileUnlock =
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @gemfile = new Gemfile
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-gemfile-unlock:unpack': => @unpack()

  deactivate: ->
    @gemfile = undefined
    @subscriptions.dispose()

  serialize: ->
    # atomGemfileUnlockViewState: @atomGemfileUnlockView.serialize()

  unpack: ->
    if @gemfile.lockExists()
      console.log 'got a lock file!'
    else
      console.log 'no lock file found'
