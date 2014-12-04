Unit = PS.Unit

unitData =
  'names': [
    'Conduit'
    'Conduits'
  ]
  'url': 'http://prismata.gamepedia.com/Conduit'
  'panelUrl': 'http://hydra-media.cursecdn.com/prismata.gamepedia.com/9/9a/Conduit-panel.png'

describe 'Unit', ->
  describe '#name', ->
    it 'should be read from the first parameter', ->
      unit = new Unit('Conduitttt', unitData)
      expect(unit.name).toBe 'Conduitttt'

  describe '#names', ->
    it 'should be read from the data', ->
      unit = new Unit('Conduitttt', unitData)
      expect(unit.names).toMatch ['Conduit', 'Conduits']

  describe '#panelUrl', ->
    it 'should be read from the data', ->
      unit = new Unit('Conduitttt', unitData)
      expect(unit.panelUrl).toMatch 'http://hydra-media.cursecdn.com/prismata.gamepedia.com/9/9a/Conduit-panel.png'

  describe '#url', ->
    it 'should be read from the data', ->
      unit = new Unit('Conduitttt', unitData)
      expect(unit.url).toMatch 'http://prismata.gamepedia.com/Conduit'

  describe '#flairName', ->
    it 'should be all lowercase and without spaces', ->
      unit = new Unit('Iso Cronus Potato Salad', unitData)
      expect(unit.flairName).toMatch 'isocronuspotatosalad'