###*
This class takes care of matching the name and retrieving
the picture from the background
@class
@param name The official name of the unit
@param cardPromise The promise of the unit card
       (the URL of a picture, which loads asynchronically)
###
class Unit
  constructor: (name, cardPromise)->
    @name = name
    @cardPromise = cardPromise
    @generateRegex()

  generateRegex: ->
    @regex = new RegExp(@name, 'i') # TODO: make an actual regex

  test: (text)->
    @regex.test text

  match: (text)->
    text.match(@regex)

  card: ->
    @cardPromise