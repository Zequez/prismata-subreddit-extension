describe 'spec_helper', ->
  describe 'rmws', ->
    it 'should remove white space from outside from not from the inside', ->
      expect(rmws ' ').toBe ''
      expect(rmws '<a href="Hello"> No pe </a>').toBe '<a href="Hello">Nope</a>'
      expect(rmws '  <a href="Hello"> No pe </a>  ').toBe '<a href="Hello">Nope</a>'
      expect(rmws undefined).toBe undefined