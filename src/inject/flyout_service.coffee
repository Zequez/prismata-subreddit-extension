###*
Generates a mousehover link with the name of the unit
@class
@requires FlyoutService
@param {Unit} unit
@param {HTMLElement} parent
###
class PS.FlyoutService
  className: 'prismata-subreddit-extension-flyout'

  constructor: ->
    @el = null
    @imgEl = null
    @imageUrl = null
    @mouseX = null
    @mouseY = null
    @visible = false
    @_addWindowEvents()

  ###*
  Shows the flyout next to the mouse pointer with the provided image URL
  @method
  @param {String} imageUrl - The URL of the image to be inserted into the flyout
  ###
  show: (imageUrl)->
    @_insert() unless @el
    if @imageUrl and @imageUrl isnt imageUrl
      @imgEl.onload = => @el.style.display = 'block'
    else
      @el.style.display = 'block'

    @imageUrl = imageUrl
    @imgEl.src = @imageUrl
    @visible = true
    @_setPosition()

  ###*
  Hides the flyout if the imageUrl matches or if none is provided
  @method
  @param {String} [imageUrl=null] - The URL that was used when calling #show
  ###
  hide: (imageUrl = null)->
    @_insert() unless @el
    if (imageUrl == null) or (@imageUrl is imageUrl)
      @el.style.display = 'none'
      @visible = false

  ###*
  Creates the flyout and image elements and inserts them into the DOM
  @method
  ###
  _insert: ->
    @el = document.createElement('div')
    @el.className = @className
    @el.style.position = 'fixed'
    @el.style.zIndex = '9999'
    document.body.appendChild @el

    @imgEl = document.createElement('img')
    @el.appendChild @imgEl

  _addWindowEvents: ->
    document.body.addEventListener 'mousemove', (ev)=>
      @mouseX = ev.clientX
      @mouseY = ev.clientY
      @_setPosition()

  _setPosition: ->
    if @visible
      height = document.documentElement.clientHeight
      top = @mouseX + 10
      bottom = height - @mouseY + 10
      @el.style.left = top + 'px'
      @el.style.bottom = bottom + 'px'

PS.FlyoutService = new PS.FlyoutService
