module.exports =
  activate: (state) ->
    require( atom.packages.getLoadedPackage('monokai-e-seti-ui').path + '/lib/settings').init()
