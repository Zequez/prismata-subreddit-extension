UnitsController = PS.UnitsController

describe 'UnitsController', ->

  afterEach ->
    jasmine.Ajax.uninstall()

  mockAddListener = (callback)->
    spyOn(chrome, 'runtime')
    chrome.runtime.onMessage = {}
    spyOn(chrome.runtime, 'onMessage')
    chrome.runtime.onMessage.addListener = {}
    spyOn(chrome.runtime.onMessage, 'addListener').and.callFake (listener)->
      callback(listener)


  describe '#listen', ->
    it 'should respond with all the loaded units when requested', (done)->
      units =
        "Conduit":
          "names": ["Conduit", "Conduits"]
          "url": "http://prismata.gamepedia.com/Conduit",
          "panelUrl": "http://hydra-media.cursecdn.com/prismata.gamepedia.com/9/9a/Conduit-panel.png"
        "Electrovore":
          "names": ["Electrovore", "Electrovores"]
          "url": "http://prismata.gamepedia.com/Electrovore",
          "panelUrl": "http://hydra-media.cursecdn.com/prismata.gamepedia.com/0/02/Electrovore-panel.png"

      jasmine.Ajax.install()
      jasmine.Ajax.stubRequest('https://raw.githubusercontent.com/zequez/prismata-subreddit-extension/data/units.json')
        .andReturn
          responseText: JSON.stringify(units)

      mockAddListener (listener)->
        listener {action: 'units'}, '123123123', (units)->
          expect(jasmine.Ajax.requests.mostRecent().url)
            .toMatch 'https://raw.githubusercontent.com/zequez/prismata-subreddit-extension/data/units.json'
          expect(units).toMatch units

        listener {action: 'units'}, '123123123', (units)->
          expect(jasmine.Ajax.requests.count()).toBe 1
          done()

      unitsController = new UnitsController
      unitsController.listen()

    it 'should return the static units.json if the request fails', (done)->
      getFile 'units.json', (unitsData)->
        jasmine.Ajax.install()
        jasmine.Ajax.stubRequest('https://raw.githubusercontent.com/zequez/prismata-subreddit-extension/data/units.json')
          .andReturn
            responseText: 'NOT FOUND'
            status: 404

        chrome.extension = {}

        spyOn(chrome, 'extension')
        chrome.extension.getURL = {}
        spyOn(chrome.extension, 'getURL').and.callFake (unitsJson)->
          "/base/_build_test/#{unitsJson}"

        jasmine.Ajax.stubRequest('/base/_build_test/units.json')
          .andReturn
            responseText: JSON.stringify(unitsData)

        mockAddListener (listener)->
          listener {action: 'units'}, '123123123', (units)->
            expect(chrome.extension.getURL).toHaveBeenCalled()
            expect(units).toMatch unitsData
            done()

        unitsController = new UnitsController
        unitsController.listen()
