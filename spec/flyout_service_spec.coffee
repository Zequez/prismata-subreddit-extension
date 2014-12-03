FlyoutService = PS.FlyoutService

describe 'FlyoutService', ->
  flyoutEl = -> $('.' + FlyoutService.className)

  describe '#show', ->
    it 'should inject an element into the document body', ->
      FlyoutService.show('sratrsat')
      expect(flyoutEl().length).toBe(1)

    it 'should also add an image into the element, with the correct SRC', ->
      FlyoutService.show('http://example.com/potato')
      expect(flyoutEl().find('img').attr('src'))
        .toBe 'http://example.com/potato'

    it 'should change the src of the existing element with repeated calls', ->
      FlyoutService.show('http://example.com/potato')
      $img = flyoutEl().find('img')
      FlyoutService.show('http://example.com/potato-salad')
      expect($img.attr('src')).toBe 'http://example.com/potato-salad'

    it 'should make the element visible', ->
      FlyoutService.show('a')
      expect(flyoutEl().is(':visible')).toBe true

    it 'should make the element visible after calling #hide', ->
      FlyoutService.show('a')
      FlyoutService.hide()
      FlyoutService.show('a')
      expect(flyoutEl().is(':visible')).toBe true

    describe 'flyout position', ->
      iit 'should position the flyout 10px up/right next to the mouse', (done)->
        pageHeight = document.documentElement.clientHeight
        $(document.body).fireMouseEvent 'mousemove', clientX: 50, clientY: 100
        setTimeout ->
          FlyoutService.show('a')
          setTimeout ->
            left = flyoutEl().position().left
            bottom = parseInt flyoutEl().css('bottom')

            expect(left).toBe 50 + 10
            expect(bottom).toBe pageHeight - 100 + 10
            done()
          , 10
        , 10

      it 'should move with the mouse', (done)->
        height = document.documentElement.clientHeight
        FlyoutService.show('a')
        $(document.body).fireMouseEvent 'mousemove', clientX: 50, clientY: 100
        setTimeout ->
          left = flyoutEl().position().left
          bottom = parseInt flyoutEl().css('bottom')
          expect(left).toBe 50 + 10
          expect(bottom).toBe height - 100 + 10
          $(document.body).fireMouseEvent 'mousemove', clientX: 60, clientY: 110
          setTimeout ->
            left = flyoutEl().position().left
            bottom = parseInt flyoutEl().css('bottom')
            expect(left).toBe 60 + 10
            expect(bottom).toBe height - 110 + 10
            done()
          , 10
        , 10

  describe '#hide', ->
    it 'should make the element non-visible', ->
      FlyoutService.show('a')
      FlyoutService.hide()
      expect(flyoutEl().length).toBe 1
      expect(flyoutEl().is(':visible')).toBe false

    it 'should not hide the element if it is called with a different URL', ->
      FlyoutService.show('a')
      FlyoutService.hide('b')
      expect(flyoutEl().length).toBe 1
      expect(flyoutEl().is(':visible')).toBe true

