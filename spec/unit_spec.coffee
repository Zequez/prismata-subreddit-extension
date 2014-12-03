Unit = PS.Unit

describe 'Unit', ->
  describe '#cardImageUrl', ->
    # it 'should resolve to the promise given', (done)->
    #   unit = new Unit('Conduit', Promise.resolve('http://example.com'))
    #   unit.cardImageUrl().then (imageUrl)->
    #     expect(imageUrl).toBe 'http://example.com'
    #     done()

    it 'should get the data from the background page', (done)->
      mockCardImageUrlEndpoint('Conduit', 'http://example.com')

      unit = new Unit('Conduit')
      unit.cardImageUrl().then (imageUrl)->
        expect(imageUrl).toBe 'http://example.com'
        done()

  describe '#matchers', ->
    it 'should return a list of matchers as strings', ->
      unit = new Unit('Conduit', null)
      expect(unit.matchers()).toMatch ['Conduits', 'Conduit']
