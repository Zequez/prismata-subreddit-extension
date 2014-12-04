###*
This class listen to messages from the reddit tabs and once it receives a
request for a list of units, tries to load it from the Github repository
of this extension.
@class
@param {String} name The official name of the unit
@TODO Validate data, just in case my Github account gets hacked or something
###

class PS.UnitsController
  dataUrl: 'https://raw.githubusercontent.com/Zequez/prismata-subreddit-extension/master/data/units.json'
  localDataUrl: -> chrome.extension.getURL('units.json')

  constructor: ->
    @data = null

  ###*
  Start listening to messages from the tabs. If we receive a message
  with action: units, we fetche the units data and respond with that
  @method
  ###
  listen: ->
    chrome.runtime.onMessage.addListener (message, sender, sendResponse)=>
      if message.action == 'units'
        if @data
          sendResponse(@data)
        else
          @_fetch (data)->
            sendResponse(data)
          return true # async response
      return

  ###*
  Fetch the remote units.json file from the Github repo and save the data
  to @data
  If it fails, fetch it from local and don't save it
  @method
  @private
  @param {Function} callback to call with the data
  ###
  _fetch: (callback)->
    @_get @dataUrl, (data)=>
      @data = JSON.parse data
      callback(@data)
    , =>
      @_fetchLocal callback

  ###*
  When the remote request fails, load the units.json data from the local
  extension filesystem. But don't save it on @data, so the next time
  the user refresh the pages, we request again the remote file.
  @method
  @private
  @param {Function} callback to call with the local data
  ###
  _fetchLocal: (callback)->
    @_get @localDataUrl(), (data)->
      callback JSON.parse(data)

  _get: (url, success, failure)->
    req = new XMLHttpRequest
    req.open 'get', url, true
    req.onload = ->
      if req.status == 200
        success(req.responseText)
      else
        failure()
    req.onerror = ->
      failure()
    req.send()