Unit = PS.Unit
UnitCard = PS.UnitCard
FlyoutService = PS.FlyoutService

describe 'UnitCard', ->
  describe '#insertInParent', ->
    it 'should wrap the unit name in an <a> tag', ->
      unit = new Unit 'Conduit', Promise.resolve('')
      div = $('<div>A good Conduit can make everyone <em>green</em>!</div>')

      unitCard = new UnitCard(unit, div[0])
      unitCard.insertInParent()
      expect(div.html()).toMatch /A good <a.*>Conduit<\/a> can make everyone <em>green<\/em>!/

    it "should just ignore the S on plurals (for now)", ->
      unit = new Unit 'Conduit', Promise.resolve('')
      div = $('<div>I love Conduits and everything green!</div>')

      unitCard = new UnitCard(unit, div[0])
      unitCard.insertInParent()
      expect(div.html()).toMatch /I love <a.*>Conduit<\/a>s and everything green!/

  describe 'flyout', ->
    it 'should display a flyout when hovering the link', (done)->
      unit = new Unit 'Conduit', Promise.resolve('')
      div = $('<div>A good Conduit can be awesome!</div>')

      unitCard = new UnitCard(unit, div[0])
      unitCard.insertInParent()

      spyOn FlyoutService, 'show'

      div.find('a').fireEvent 'mouseover'

      setTimeout ->
        expect(FlyoutService.show).toHaveBeenCalled()
        done()
      , 10

    it 'should hide the flyout when hovering out of the link', (done)->
      unit = new Unit 'Conduit', Promise.resolve('')
      div = $('<div>A good Conduit can be awesome!</div>')

      unitCard = new UnitCard(unit, div[0])
      unitCard.insertInParent()

      spyOn FlyoutService, 'hide'

      a = div.find('a')
      a.fireEvent 'mouseover'
      setTimeout ->
        a.fireEvent('mouseout')
      , 10

      setTimeout ->
        expect(FlyoutService.hide).toHaveBeenCalled()
        done()
      , 10

    it 'should call the flyout with the result of the UnitCard promise', (done)->
      unit = new Unit 'Conduit', Promise.resolve('rsarsa')
      div = $('<div>A good Conduit can be awesome!</div>')

      unitCard = new UnitCard(unit, div[0])
      unitCard.insertInParent()

      spyOn FlyoutService, 'show'

      div.find('a').fireEvent 'mouseover'

      setTimeout ->
        expect(FlyoutService.show).toHaveBeenCalledWith('rsarsa')
        done()
      , 10

