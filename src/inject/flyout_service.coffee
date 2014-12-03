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
    @x = null
    @y = null
    @visible = false
    @_addWindowEvents()

  ###*
  Shows the flyout next to the mouse pointer with the provided image URL
  @method
  @param {String} imageUrl - The URL of the image to be inserted into the flyout
  ###
  show: (imageUrl)->
    @_insert() unless @el
    @imageUrl = imageUrl
    @imgEl.src = @imageUrl
    @el.style.display = 'block'
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
    document.body.appendChild @el

    @imgEl = document.createElement('img')
    @el.appendChild @imgEl

  _addWindowEvents: ->
    document.body.addEventListener 'mousemove', (ev)=>
      @x = ev.clientX + 10
      @y = ev.clientY - 10
      @_setPosition()

  _setPosition: ->

    if @visible
      @el.style.top = @y + 'px'
      @el.style.left = @x + 'px'


PS.FlyoutService = new PS.FlyoutService
