class PS.UnitsScraper
  unitsUrl: 'http://prismata.gamepedia.com/Unit'

  constructor: ->
    @units = []

  scrap: ->
    request = new XMLHttpRequest
    request.open 'get', @unitsUrl, true
    request.onload = =>
      @_parse(`this.responseText`)
    request.send()

  _parse: (html)->
    doc = document.createElement('div')
    doc.innerHTML = html
    linksNodes = doc.querySelectorAll('.wikitable td:first-child a')
    for a in linksNodes
      # TODO: Sanitize data
      @units.push new PS.UnitData a.innerHTML, a.href

  _sanitizeName: ->

  _sanitizeLink: ->