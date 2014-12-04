Unit = PS.Unit
UnitCard = PS.UnitCard
FlyoutService = PS.FlyoutService

describe 'UnitCard', ->
  describe '#replacementString', ->
    it 'should return the parameter passed wrapped in an A element ready to use', ->
      unit = new Unit 'Potato Salad'

      unitCard = new UnitCard(unit)
      expect(unitCard.replacementString('Potato Salad'))
      .toMatch /<a.*class=".*prismata-subreddit-extension-link.*".*><span class="flair flair-potatosalad"><\/span>Potato Salad<\/a>/

  describe 'flyout', ->
    it 'should display a flyout when hovering the link', (done)->
      unit = new Unit 'Conduit'
      mockCardImageUrlEndpoint('Conduit', 'a')

      a = $('<a class="prismata-subreddit-extension-link">Conduit</a>')

      unitCard = new UnitCard(unit)
      unitCard.setElement(a[0])

      spyOn FlyoutService, 'show'

      a.fireEvent 'mouseover'

      setTimeout ->
        expect(FlyoutService.show).toHaveBeenCalled()
        done()
      , 10

    it 'should hide the flyout when hovering out of the link', (done)->
      unit = new Unit 'Conduit'
      mockCardImageUrlEndpoint('Conduit', 'a')
      a = $('<a class="prismata-subreddit-extension-link">Conduit</a>')

      unitCard = new UnitCard(unit)
      unitCard.setElement(a[0])

      spyOn FlyoutService, 'hide'

      a.fireEvent 'mouseover'
      setTimeout ->
        a.fireEvent('mouseout')
      , 10

      setTimeout ->
        expect(FlyoutService.hide).toHaveBeenCalled()
        done()
      , 10

    it 'should call the flyout with the result of the UnitCard promise', (done)->
      unit = new Unit 'Conduit'
      mockCardImageUrlEndpoint('Conduit', 'rsarsa')
      a = $('<a class="prismata-subreddit-extension-link">Conduit</a>')

      unitCard = new UnitCard(unit)
      unitCard.setElement(a[0])

      spyOn FlyoutService, 'show'

      a.fireEvent 'mouseover'

      setTimeout ->
        expect(FlyoutService.show).toHaveBeenCalledWith('rsarsa')
        done()
      , 10

