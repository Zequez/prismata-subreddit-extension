Units = PS.Units
Unit = PS.Unit
UnitCard = PS.UnitCard

describe 'Units', ->
  # The basic 11 units, taken from units.json
  mockUnits = {"Engineer":{"names":["Engineer","Engineers"],"url":"http://prismata.gamepedia.com/Engineer","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/0/01/Engineer-panel.png"},"Drone":{"names":["Drone","Drones"],"url":"http://prismata.gamepedia.com/Drone","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/9/9e/Drone-panel.png"},"Conduit":{"names":["Conduit","Conduits"],"url":"http://prismata.gamepedia.com/Conduit","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/9/9a/Conduit-panel.png"},"Blastforge":{"names":["Blastforge","Blastforges"],"url":"http://prismata.gamepedia.com/Blastforge","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/c/c6/Blastforge-panel.png"},"Animus":{"names":["Animus","Animuses"],"url":"http://prismata.gamepedia.com/Animus","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/d/d8/Animus-panel.png"},"Forcefield":{"names":["Forcefield","Forcefields"],"url":"http://prismata.gamepedia.com/Forcefield","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/d/de/Forcefield-panel.png"},"Gauss Cannon":{"names":["Gauss Cannon","Gauss Cannons"],"url":"http://prismata.gamepedia.com/Gauss_Cannon","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/c/ca/GaussCannon-panel.png"},"Wall":{"names":["Wall","Walls"],"url":"http://prismata.gamepedia.com/Wall","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/5/50/Wall-panel.png"},"Steelsplitter":{"names":["Steelsplitter","Steelsplitters","Steelspitter","Steelspitters"],"url":"http://prismata.gamepedia.com/Steelsplitter","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/a/a4/Steelsplitter-panel.png"},"Tarsier":{"names":["Tarsier","Tarsiers"],"url":"http://prismata.gamepedia.com/Tarsier","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/7/7d/Tarsier-panel.png"},"Rhino":{"names":["Rhino","Rhinos"],"url":"http://prismata.gamepedia.com/Rhino","panelUrl":"http://hydra-media.cursecdn.com/prismata.gamepedia.com/5/58/Rhino-panel.png"}}

  mockUnitsEndpoint = ->
    spyOn(chrome, 'runtime')
    spyOn(chrome.runtime, 'sendMessage').and.callFake (message, callback)->
      expect(message).toEqual {action: 'units'}
      callback mockUnits

  it 'should get the units names from the chrome API', ->
    mockUnitsEndpoint()
    doc = $('<div></div>')
    units = new Units()
    units.load(doc[0])
    expect(chrome.runtime.sendMessage).toHaveBeenCalled()

  it 'should create a new Unit for each name', (done)->
    mockUnitsEndpoint()
    doc = $('<div></div>')
    units = new Units()

    # Using PS.Unit on all the code it's the only way to be able to
    # mock it and test it, sadly. I was so proud of my Ghetto DI idea :(
    spyOn(PS, 'Unit').and.callFake -> new Unit arguments...

    units.load(doc[0]).then ->
      expect(PS.Unit).toHaveBeenCalled()
      expect(PS.Unit.calls.count()).toBe 11
      done()

  it 'should create an UnitCard for each time it finds an unit', (done)->
    mockUnitsEndpoint()
    doc = $ """
    <div class="entry">
      <div class="md">
        <p>
          The Conduit in this Animus is very much an impressive
          piece of <em>alien<em> tech. The Gauss Cannon is a powerful
          heavy artillery. But I love the Conduit.
          Also Conduits are plural!
          And think about Steelsplitters! How cool are they?
        </p>
      </div>
    </div>
    """
    units = new Units()

    unitCards = allFutureInstancesOf 'UnitCard'

    units.load(doc[0]).then ->
      expect(PS.UnitCard).toHaveBeenCalled()
      expect(PS.UnitCard.calls.count()).toBe 6

      aa = doc.find('a.prismata-subreddit-extension-link')
      expect(aa.length).toBe 6
      expect(aa.map((i, e)->e.innerText).toArray())
        .toMatch [
          'Conduit',
          'Animus',
          'Gauss Cannon',
          'Conduit',
          'Conduits',
          'Steelsplitters'
        ]

      for a, i in aa.toArray()
        expect(unitCards[i].el).toEqual a
      done()

  it "shouldn't replace the names on text inside HTML elements or in the middle of words", (done)->
    mockUnitsEndpoint()
    doc = $ """
    <div class="entry">
      <div class="md">
        <p>
          superDRONEistic
          <a href="http://challonge.com/TARSIERcup">Let's go to the TaRSiEr cup!</a>
          This is a real Engineer
          WALLnuts is not spelled correctly
        </p>
      </div>
    </div>
    """
    unitCards = allFutureInstancesOf 'UnitCard'

    units = new Units()
    units.load(doc[0]).then ->
      matches = unitCards.map((i,e)-> i.match)
      expect(matches.length).toBe 2
      expect(matches).toMatch ['TaRSiEr', 'Engineer']
      done()
