{CompositeDisposable} = require 'atom'

module.exports = AtomJoinCsv =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-join-csv:joincsv': => @joinCsv()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-join-csv:joincsvsinglequote': => @joinCsvQuoted()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-join-csv:joincsvdoublequote': => @joinCsvQuoted2()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomJoinCsvView.destroy()

  serialize: ->
    atomJoinCsvViewState: @atomJoinCsvView.serialize()

  joinCsv: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      update = selection.replace /\r?\n/g, ","
      update = update.replace /,$/, "\n"
      editor.insertText(update)

  joinCsvQuoted: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      update = selection.replace /\r?\n/g, "','"
      update = update.replace /','$/, ""
      editor.insertText("'" + update + "'")

  joinCsvQuoted2: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      update = selection.replace /\r?\n/g, "\",\""
      update = update.replace /","$/, ""
      editor.insertText("\"" + update + "\"")
