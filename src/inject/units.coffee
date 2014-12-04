PS.Unit
PS.UnitCard

###*
Loads and generates all the units
@class
@requires Unit, UnitCard
###
class PS.Units
  constructor: ->
    @unitsData = null
    @units = []
    @cards = []

  load: (targetElement)->
    @_loadUnits()
    .then =>
      @searchPage(targetElement)
    .catch (error)-> console.error error.stack

  _loadUnits: ->
    new Promise (resolve)=>
      chrome.runtime.sendMessage { action: 'units' }, (response)=>
        @unitsData = response

        for name, data of @unitsData
          @units.push new PS.Unit(name, data)

        resolve()


  searchPage: (targetElement)->
    # List of pharagraphs on the page
    # We might want to change this matcher in the future,
    # probably move it to it's own method
    paragraphs = targetElement.querySelectorAll('.entry .md p')

    # Map mapping the matchers to units
    # this way we can know what unit we are matching
    # when replacing it with a single regex
    unitsMap = {}

    # List of all units matchers. Plural and singular.
    matchers = @units.reduce (a, unit)->
      unitsMap[name.toLowerCase()] = unit for name in unit.names
      a.concat unit.names
    , []

    # We sort by the length of the words, so plurals
    # are replaced before singulars
    matchers.sort((a, b)-> b.length - a.length)

    # Combined regex of all the possible matches (plural and singular)
    # of all known units
    combinedRegex = new RegExp(matchers.join('|'), 'ig')


    # Iterate all the pharagraphs individually and
    # replace all the matches at the same time on each one
    for element in paragraphs
      elementUnitsCards = []

      # Get the current paragraph HTML and replace the matches
      # with links by sending the match to a new UnitCard.
      # Save the UnitCard so we can use it later to send
      # the generated link later.
      html = element.innerHTML
      html = html.replace combinedRegex, (match)->
        unit = unitsMap[match.toLowerCase()]
        unitCard = new PS.UnitCard(unit)
        elementUnitsCards.push unitCard
        unitCard.replacementString(match)
      element.innerHTML = html

      # Find the inserted elements and send 'em to the corresponding unitCard
      insertedElements = element.getElementsByClassName(PS.UnitCard.className)
      for el, i in insertedElements
        elementUnitsCards[i].setElement el
    return