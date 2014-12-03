isPrismataSubreddit = document.location.pathname.match(/^\/r\/prismata/i)


chrome.runtime.sendMessage 'units', (response)->
  console.log 'MESSAGE FROM BEYOND', response

# if isPrismataSubreddit
#   units = new Units()
#   units.load(document.body)