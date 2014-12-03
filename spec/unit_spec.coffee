Unit = PS.Unit

describe 'Unit', ->
  describe '#match', ->
    it 'should match its name exactly', ->
      unit = new Unit('Conduit', null)
      expect(unit.match('rsarsasrar Conduit arstras')).toBeTruthy()

    it 'should not match the name whe its not there', ->
      unit = new Unit('Conduit', null)
      expect(unit.match('rsarsasrar Potato arstras')).toBeFalsy()

    it 'should match the name case insensitive', ->
      unit = new Unit('Conduit', null)
      expect(unit.match('nitnihi COnDUIt trast')).toBeTruthy()

    it 'should match the name plurally', ->
      unit = new Unit('Conduit', null)
      expect(unit.match('nienienie Conduits tarstras')).toBeTruthy()

  describe '#cardImageUrl', ->
    it 'should resolve to the promise given', (done)->
      unit = new Unit('Conduit', Promise.resolve('http://example.com'))
      unit.cardImageUrl().then (imageUrl)->
        expect(imageUrl).toBe 'http://example.com'
        done()
