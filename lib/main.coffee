root = document.documentElement
{CompositeDisposable} = require 'atom'

module.exports =
  package: atom.packages.getLoadedPackage 'monokai-e-ui'

  activate: (state) ->
    @disposables = new CompositeDisposable
    @disposables.add atom.config.observe 'monokai-e-ui.fontSize', (value) ->
      setFontSize(value)

    @disposables.add atom.config.observe 'monokai-e-ui.tabSizing', (value) ->
      setTabSizing(value)

    @disposables.add atom.config.observe 'monokai-e-ui.hideDockButtons', (value) ->
      setHideDockButtons(value)

    @disposables.add atom.config.onDidChange 'monokai-e-ui.accentColor', (value) =>
      setAccentColor value.newValue, (err) =>
        if err then console.error err else @refresh()

  deactivate: ->
    @disposables.dispose()
    unsetFontSize()
    unsetTabSizing()
    unsetHideDockButtons()

  refresh: ->
    @package.deactivate()
    setImmediate => @package.activate()

# Font Size -----------------------

setFontSize = (currentFontSize) ->
  if Number.isInteger(currentFontSize)
    root.style.fontSize = "#{currentFontSize}px"
  else if currentFontSize is 'Auto'
    unsetFontSize()

unsetFontSize = ->
  root.style.fontSize = ''


# Tab Sizing -----------------------

setTabSizing = (tabSizing) ->
  root.setAttribute('theme-monokai-e-ui-tabsizing', tabSizing.toLowerCase())

unsetTabSizing = ->
  root.removeAttribute('theme-monokai-e-ui-tabsizing')


# Dock Buttons -----------------------

setHideDockButtons = (hideDockButtons) ->
  if hideDockButtons
    root.setAttribute('theme-monokai-e-ui-dock-buttons', 'hidden')
  else
    unsetHideDockButtons()

unsetHideDockButtons = ->
  root.removeAttribute('theme-monokai-e-ui-dock-buttons')

# AccentColor ------------------------------
setAccentColor = (accentColor, cb) ->
  fs = require 'fs'
  path = require 'path'
  color = accentColor.toLowerCase()
  pkg = atom.packages.getLoadedPackage 'monokai-e-ui'
  optionsPath = "#{pkg.path}/styles/ui-options.less"
  fs.readFile(optionsPath, (err, data) =>
    if (not err and data.toString().includes(color))
      cb(new Error("accentColor already set to #{color}"))
    else
      fs.writeFile optionsPath, "@accentColorName: '#{color}';", cb
  )
