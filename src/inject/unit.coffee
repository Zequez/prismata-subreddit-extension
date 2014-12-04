# console.log modulejs

###*
This class takes care of matching the name and retrieving
the picture from the background
@class
@param {String} name The official name of the unit
###
class PS.Unit
  constructor: (name, data)->
    @name = name
    @names = data.names
    @panelUrl = data.panelUrl
    @url = data.url

    @flairName = @_flairName()

  _flairName: ->
    @name.toLowerCase().replace(/\s/g, '')