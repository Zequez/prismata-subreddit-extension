Units = PS.Units

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
      expect(message).toBe 'units'
      callback mockUnitsNames

  it 'should get the units names from the chrome API', ->
    mockUnitsEndpoint()
    units = new Units()
    units.load()
    expect(chrome.runtime.sendMessage).toHaveBeenCalled()

  # Cannot mock test, damn. I have to use some kind of DI to test these things
  # it 'should create a new Unit for each name', ->
  #   mockUnitsEndpoint()
  #   units = new Units()

  #   oldUnit = Unit
  #   Unit = jasmine.createSpy('Unit')
  #   Unit.and.callFake oldUnit

  #   units.load()

  #   expect(Unit).toHaveBeenCalled()
  #   expect(Unit.calls.count()).toBe 11
