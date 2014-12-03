Unit = PS.Unit
UnitCard = PS.UnitCard

###*
Loads and generates all the units
@class
###
class PS.Units
  constructor: ->
    @unitsNames = []
    @units = []
    @cards = []

  load: (targetElement)->
    @_loadUnits().then =>
      @searchPage(targetElement)

  _loadUnits: ->
    new Promise (resolve)->
      # TODO: Load it from the background page
      chrome.runtime.sendMessage 'units', (response)=>
        @unitsNames = response

        cardPromise = new Promise (resolve, reject)->
          resolve('http://potato.com')

        for name in @unitsNames
          @units.push new Unit(name, cardPromise)

        resolve()


  searchPage: (targetElement)->
    paragraphs = targetElement.querySelectorAll('.entry .md p')

    # This should be a quick match, as we are matching the whole page
    for element in paragraphs
      html = element.innerHTML
      for unit in @units
        if match = unit.test(html)
          unitCard = new UnitCard(unit, element, html)
          @cards.push unitCard
          html = unitCard.insertInParent()
    return