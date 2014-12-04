###*
This class listen to messages from the reddit tabs and once it receives a
request for a list of units, tries to load it from the Github repository
of this extension.
@class
@param {String} name The official name of the unit
@TODO Validate data, just in case my Github account gets hacked or something
@TODO Make logic to request a local backup of the data in case Github doesn't load or something
###

class PS.UnitsController
  @dataUrl: 'http://raw.github.com/zequez/prismata-subreddit-extension/data/units.json'

  constructor: ->
    @data = null

  listen: ->
    chrome.runtime.onMessage.addListener (message, sender, sendResponse)=>
      if message.action == 'units'
        if @data
          sendResponse(@data)
        else
          @_fetch (data)->
            sendResponse(data)

  _fetch: (callback, count = 1)->
    request = new XMLHttpRequest
    request.open 'get', PS.UnitsController.dataUrl, true
    request.onload = =>
      @data = JSON.parse `this.responseText`
      callback(@data)
    request.onerror = =>
      setTimeout =>
        @_fetch(callback, count + 1)
      , 1000 * count

    request.send()

  # _fetchLocal: ->
  #   @data = {
  #     "Conduit": {
  #       "names": [
  #         "Conduit"
  #         "Conduits"
  #       ]
  #       "url": "http://prismata.gamepedia.com/Conduit"
  #       "panelUrl": "http://hydra-media.cursecdn.com/prismata.gamepedia.com/9/9a/Conduit-panel.png"
  #     }
  #   }
