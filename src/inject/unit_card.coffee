###*
Generates a mousehover link with the name of the unit
@class
###
class UnitCard
  constructor: (unit, element, html)->
    @unit = unit
    @element = element
    @html = html

    console.log 'Unit found!', @unit.name

  ###*
  Inserts an <a> element where the unit name was found
  @returns {String} the new HTML of the parent element
  ###
  insert: ->
    @html