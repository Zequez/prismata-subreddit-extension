###*
Generates a mousehover link with the name of the unit
@class
@requires FlyoutService
@param {Unit} unit
@param {HTMLElement} parent
###
class UnitCard
  constructor: (unit, parent)->
    @unit = unit
    @parent = parent
    @el = null # {HTMLElement}
    @flyoutEl = null # {HTMLElement}
    @cardImageUrl = null # {String}

    console.log 'Unit found!', @unit.name

  ###*
  Inserts an <a> element where the first unit name was found in the parent
  @method
  ###
  insertInParent: ->
    # TODO: Optimize this by analyzing text nodes instead of the innerHTML
    parentHTML = @parent.innerHTML

    match = @unit.match(parentHTML)

    matchText = match[0]

    preStart = 0
    preEnd = match.index-1
    postStart = match.index + matchText.length
    postEnd = -1

    preText = parentHTML[preStart..preEnd]
    postText = parentHTML[postStart..postEnd]

    @el = document.createElement('a')
    @el.innerHTML = matchText

    @parent.innerHTML = preText
    @parent.appendChild(@el)
    @parent.insertAdjacentHTML('beforeend', postText)

    @_addEvents()
    return

  _addEvents: ->
    ev = document.createEvent("HTMLEvents")

    @el.addEventListener 'mouseover', => @_showFlyout()
    @el.addEventListener 'mouseout', => @_hideFlyout()

  _showFlyout: ->
    if @cardImageUrl
      FlyoutService.show @cardImageUrl
    else
      @unit.cardImageUrl().then (cardImageUrl)=>
        @cardImageUrl = cardImageUrl
        FlyoutService.show @cardImageUrl

  _hideFlyout: ->
    if @cardImageUrl
      FlyoutService.hide @cardImageUrl
    else
      @unit.cardImageUrl().then (cardImageUrl)=>
        FlyoutService.hide @cardImageUrl


