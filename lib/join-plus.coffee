{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'join-plus:join-csv': => @joinCsv()
    @subscriptions.add atom.commands.add 'atom-workspace', 'join-plus:join-csv-single-quote': => @joinCsvQuoted()
    @subscriptions.add atom.commands.add 'atom-workspace', 'join-plus:join-csv-double-quote': => @joinCsvQuoted2()
    @subscriptions.add atom.commands.add 'atom-workspace', 'join-plus:unjoin-csv': => @unjoinCsv()

  deactivate: ->
    @subscriptions.dispose()

  joinCsv: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      update = selection.replace /\n/g, ","
      update = update.replace /,$/, "\n"
      editor.insertText(update)

  joinCsvQuoted: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      update = selection.replace /\n/g, "','"
      update = update.replace /','$/, ""
      editor.insertText("'" + update + "'")

  joinCsvQuoted2: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      update = selection.replace /\n/g, "\",\""
      update = update.replace /","$/, ""
      editor.insertText("\"" + update + "\"")

  unjoinCsv: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      update = selection.replace /,/g, "\n"
      editor.insertText(update)
