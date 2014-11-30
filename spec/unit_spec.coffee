describe 'Unit', ->
  it 'should match its name exactly', ->
    unit = new Unit('Conduit', null)
    expect(unit.match('rsarsasrar Conduit arstras')).toBeTruthy()

  it 'should not match the name whe its not there', ->
    unit = new Unit('Conduit', null)
    expect(unit.match('rsarsasrar Potato arstras')).toBeFalsy()

  it 'should match the name case insensitive', ->
    unit = new Unit('Conduit', null)
    expect(unit.match('nitnihi COnDUIt trast')).toBeTruthy()

  # it 'should match the name plurally', ->
  #   unit = new Unit('Conduit', null)
  #   expect(unit.match('nienienie Conduits tarstras')).toBeTruthy()