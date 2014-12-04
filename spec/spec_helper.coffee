$.fn.fireEvent = (name)->
  ev = document.createEvent("HTMLEvents")
  ev.initEvent name, true, true
  this[0].dispatchEvent ev
  return

$.fn.fireMouseEvent = (name, options)->
  ev = document.createEvent('MouseEvents')

  defaults =
    screenX: 50
    screenY: 50
    clientX: 50
    clientY: 50

  for p of defaults
    defaults[p] = options[p] || defaults[p]
  opt = defaults

  ev.initMouseEvent name, # type: click, mousedown, mouseup,
                          # mouseover, mousemove, mouseout
                    true, # canBubble
                    false, # cancelable
                    window, # event's AbstractView : should be window
                    1, # detail: Event's mouse click count
                    opt.screenX, # screenX
                    opt.screenY, # screenY
                    opt.clientX, # clientX
                    opt.clientY, # clientY
                    false, # ctrlKey
                    false, # altKey
                    false, # shiftKey
                    false, # metaKey
                    0, # button: 0 = click, 1 = middle button, 2 = right button
                    null, # relatedTarget: Only used with some event types
                          # (e.g. mouseover and mouseout).
                          # In other cases, pass null.

  this[0].dispatchEvent ev
  return

window.mockCardImageUrlEndpoint = (name, url)->
  spyOn(chrome, 'runtime')
  spyOn(chrome.runtime, 'sendMessage').and.callFake (message, callback)->
    expect(message).toEqual {action: 'unitCardImage', name: name}
    callback url

window.getFile = (name, callback)->
  $.get("/base/_build_test/#{name}", callback)

window.allFutureInstancesOf = (name)->
  klass = PS[name]
  instances = []
  spyOn(PS, name).and.callFake ->
    instance = new klass arguments...
    instances.push instance
    instance
  instances