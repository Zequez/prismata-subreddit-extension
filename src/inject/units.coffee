###*
Loads and generates all the units
@class
###
class Units
  constructor: ->
    @unitsNames = []
    @units = []
    @cards = []

  load: (targetElement)->
    @loadUnits().then =>
      @searchPage(targetElement)

  loadUnits: ->
    # TODO: Load it from the background page
    @unitsNames = [
      "Engineer"
      "Drone"
      "Conduit"
      "Blastforge"
      "Animus"
      "Forcefield"
      "Gauss Cannon"
      "Wall"
      "Steelsplitter"
      "Tarsier"
      "Rhino"
    ]

    cardPromise = new Promise (resolve, reject)->
      resolve('http://potato.com')

    for name in @unitsNames
      @units.push new Unit(name, cardPromise)

    Promise.resolve @units

  searchPage: (targetElement)->
    paragraphs = targetElement.querySelectorAll('.entry .md p')

    # This should be a quick match, as we are matching the whole page
    for element in paragraphs
      html = element.innerHTML
      for unit in @units
        if match = unit.test(html)
          unitCard = new UnitCard(unit, element, html)
          @cards.push unitCard
          html = unitCard.insert()
    return