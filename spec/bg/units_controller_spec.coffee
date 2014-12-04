UnitsController = PS.UnitsController

describe 'UnitsController', ->

  afterEach ->
    jasmine.Ajax.uninstall()


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
      jasmine.Ajax.stubRequest('http://raw.github.com/zequez/prismata-subreddit-extension/data/units.json')
        .andReturn responseText: JSON.stringify(units)

      spyOn(chrome, 'runtime')
      chrome.runtime.onMessage = {}
      spyOn(chrome.runtime, 'onMessage')
      chrome.runtime.onMessage.addListener = {}
      spyOn(chrome.runtime.onMessage, 'addListener').and.callFake (listener)->
        listener {action: 'units'}, '123123123', (units)->
          expect(jasmine.Ajax.requests.mostRecent().url)
            .toMatch 'http://raw.github.com/zequez/prismata-subreddit-extension/data/units.json'
          expect(units).toMatch units

        listener {action: 'units'}, '123123123', (units)->
          expect(jasmine.Ajax.requests.count()).toBe 1
          done()

      unitsController = new UnitsController
      unitsController.listen()