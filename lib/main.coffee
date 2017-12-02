root = document.documentElement

module.exports =
  activate: (state) ->
    atom.config.observe 'monokai-e-ui.fontSize', (value) ->
      setFontSize(value)

    atom.config.observe 'monokai-e-ui.tabSizing', (value) ->
      setTabSizing(value)

    atom.config.observe 'monokai-e-ui.hideDockButtons', (value) ->
      setHideDockButtons(value)

    atom.config.observe 'monokai-e-ui.accentColor', (value) ->
      setAccentColor(value)

    # DEPRECATED: This can be removed at some point (added in Atom 1.17/1.18ish)
    # It removes `layoutMode`
    if atom.config.get('monokai-e-ui.layoutMode')
      atom.config.unset('monokai-e-ui.layoutMode')

  deactivate: ->
    unsetFontSize()
    unsetTabSizing()
    unsetHideDockButtons()
    unsetAccentColor()


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

setAccentColor = (accentColor) ->
  console.log(accentColor)

unsetAccentColor = ->
  console.log('unsetting accentColor')
