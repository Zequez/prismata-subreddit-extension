# console.log modulejs

###*
This class takes care of matching the name and retrieving
the picture from the background
@class
@param {String} name The official name of the unit
@param {String} cardImageUrlPromise The promise of the unit card picture URL
       (loads asynchronically)
###
class PS.Unit
  constructor: (name, cardImageUrlPromise)->
    @name = name
    @cardImageUrlPromise = cardImageUrlPromise
    @generateRegex()

  generateRegex: ->
    @regex = new RegExp(@name, 'i') # TODO: make an actual regex

  test: (text)->
    @regex.test text

  match: (text)->
    text.match(@regex)

  cardImageUrl: ->
    @cardImageUrlPromise