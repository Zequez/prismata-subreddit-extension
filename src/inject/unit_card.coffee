PS.FlyoutService

###*
Generates a mousehover link with the name of the unit
@class
@requires FlyoutService
@param {Unit} unit
###
class PS.UnitCard
  @className: 'prismata-subreddit-extension-link'

  constructor: (unit)->
    @unit = unit
    @el = null # {HTMLElement}
    @cardImageUrl = null # {String}

    console.log 'Unit found!', @unit.name

  ###*
  This method is called from Units. It returns a replacement string, and then
  it expects to receive the element generated from such string on #setElement
  @method
  @returns {String} Element to be generated in a string form
  ###
  replacementString: (match)->
    "<a class=\"#{PS.UnitCard.className}\" href=\"#\">#{match}</a>"

  ###*
  Should be called to set the element generated from the #replacementString
  @method
  @param {HTMLElement} element
  ###
  setElement: (el)->
    @el = el
    @_addEvents()
    return

  _addEvents: ->
    @el.addEventListener 'mouseover', => @_showFlyout()
    @el.addEventListener 'mouseout', => @_hideFlyout()

  _showFlyout: ->
    if @cardImageUrl
      PS.FlyoutService.show @cardImageUrl
    else
      @unit.cardImageUrl().then (cardImageUrl)=>
        @cardImageUrl = cardImageUrl
        @_setHref()
        PS.FlyoutService.show @cardImageUrl

  _hideFlyout: ->
    if @cardImageUrl
      PS.FlyoutService.hide @cardImageUrl
    else
      @unit.cardImageUrl().then (cardImageUrl)=>
        PS.FlyoutService.hide @cardImageUrl

  _setHref: ->
    @el.href = @cardImageUrl


