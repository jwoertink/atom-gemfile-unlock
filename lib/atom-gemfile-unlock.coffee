AtomGemfileUnlockView = require './atom-gemfile-unlock-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomGemfileUnlock =
  atomGemfileUnlockView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomGemfileUnlockView = new AtomGemfileUnlockView(state.atomGemfileUnlockViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomGemfileUnlockView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-gemfile-unlock:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomGemfileUnlockView.destroy()

  serialize: ->
    atomGemfileUnlockViewState: @atomGemfileUnlockView.serialize()

  toggle: ->
    console.log 'AtomGemfileUnlock was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()