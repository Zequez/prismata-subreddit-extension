###*
This file loads the Prismata Wiki list of units and takes cares of
making all the neccesary requests to get the images links.
###

# chrome.extension.onMessage.addListener (request, sender, sendResponse)->
#   chrome.pageAction.show sender.tab.id
#   sendResponse()

chrome.runtime.onMessage.addListener (message, sender, sendResponse)->
  console.log message
  console.log sender
  sendResponse 'YES IM ALIVE!'

# setInterval ->
#   console.log 'Sending message!'
#   chrome.tabs.sendMessage 'Hello buddy!'
# , 1000