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
    "<a class=\"#{PS.UnitCard.className}\" href=\"#\"><span class=\"flair flair-#{@unit.flairName}\"></span>#{match}</a>"

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
    PS.FlyoutService.show @unit.panelUrl

  _hideFlyout: ->
    PS.FlyoutService.hide @unit.panelUrl

  _setHref: ->
    @el.href = @cardImageUrl


