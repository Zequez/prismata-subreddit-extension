# console.log modulejs

###*
This class takes care of matching the name and retrieving
the picture from the background
@class
@param {String} name The official name of the unit
###
class PS.Unit
  constructor: (name)->
    @name = name
    @pluralName = pluralize(@name, 2)
    @cardImageUrlPromise = null

  ###*
  This method sends a request to the background page to the cardImageUrl
  @method
  @returns {Promise} resolves to the cardImageUrl from the background page
  ###
  cardImageUrl: ->
    @cardImageUrlPromise ||=
    new Promise (resolve)=>
      chrome.runtime.sendMessage @_cardImageUrlMessage(), (response)->
        resolve(response)
    .catch (error)->
      console.error error.stack

  ###*
  List of all possible matchers for the unit.
  Should be Regex-safe, as they're going to be
  joined in a big regex
  @method
  @returns {Array} of all matching names of the unit
  ###
  matchers: ->
    [@pluralName, @name]

  _cardImageUrlMessage: ->
    { action: 'unitCardImage', name: @name }