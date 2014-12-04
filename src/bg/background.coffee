###*
This file loads the Prismata Wiki list of units and takes cares of
making all the neccesary requests to get the images links.
###

# chrome.extension.onMessage.addListener (request, sender, sendResponse)->
#   chrome.pageAction.show sender.tab.id
#   sendResponse()

class UnitScraper


unitsNames = [
  "Engineer"
  "Drone"
  "Conduit"
  "Blastforge"
  "Animus"
  "Forcefield"
  "Gauss Cannon"
  "Wall"
  "Steelsplitter"
  "Tarsier"
  "Rhino"
]

units = [

]

chrome.runtime.onMessage.addListener (message, sender, sendResponse)->
  if message.action == 'units'
    sendResponse(unitsNames)
  else if message.action == 'unitCardImage'
    sendResponse('http://hydra-media.cursecdn.com/prismata.gamepedia.com/6/60/Chieftain-panel.png?version=124c47a962b2813a9b3397ba81753ecc')

# setInterval ->
#   console.log 'Sending message!'
#   chrome.tabs.sendMessage 'Hello buddy!'
# , 1000