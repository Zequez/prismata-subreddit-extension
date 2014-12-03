Units = PS.Units
Unit = PS.Unit
UnitCard = PS.UnitCard

describe 'Units', ->
  mockUnitsNames = [
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

  mockUnitsEndpoint = ->
    spyOn(chrome, 'runtime')
    spyOn(chrome.runtime, 'sendMessage').and.callFake (message, callback)->
      expect(message).toEqual {action: 'units'}
      callback mockUnitsNames

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

    unitCards = []
    spyOn(PS, 'UnitCard').and.callFake ->
      unitCard = new UnitCard arguments...
      unitCards.push unitCard
      unitCard

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