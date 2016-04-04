AtomGemfileUnlock = require '../lib/atom-gemfile-unlock'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomGemfileUnlock", ->
  [activationPromise] = []

  beforeEach ->
    activationPromise = atom.packages.activatePackage('atom-gemfile-unlock')

  describe "when the atom-gemfile-unlock:unpack event is triggered", ->
    it "checks for a Gemfile.lock", -> "pending"

    it "creates a tmp project with gems", -> "pending"
