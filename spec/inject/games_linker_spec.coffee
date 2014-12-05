GamesLinker = PS.GamesLinker

describe 'GamesLinker', ->
  it 'should replace all the games strings with links', ->
    doc = $ """
    <div class="entry"><div class="md"><p>
      Game 1: EezGQ-iGXGk
      Game 2: +3C8U-RJPej
      Game 3: 3k4Cz-GC6Rp
      Game 4: 3k4C+-+C6Rp
      Game 5: __k4a-aat32
    </p></div></div>
    """

    gl = new GamesLinker
    gl.load doc[0]

    expect(rmws doc.html()).toBe rmws """
    <div class="md"><p>
      Game 1: <a href="http://play.prismata.net/?r=EezGQ-iGXGk">EezGQ-iGXGk</a>
      Game 2: <a href="http://play.prismata.net/?r=+3C8U-RJPej">+3C8U-RJPej</a>
      Game 3: <a href="http://play.prismata.net/?r=3k4Cz-GC6Rp">3k4Cz-GC6Rp</a>
      Game 4: <a href="http://play.prismata.net/?r=3k4C+-+C6Rp">3k4C+-+C6Rp</a>
      Game 5: <a href="http://play.prismata.net/?r=__k4a-aat32">__k4a-aat32</a>
    </p></div>
    """

  it "should not replace the games when they're already linked", ->
    doc = $ """
    <div class="entry"><div class="md"><p>
      Game 1: <a href="http://play.prismata.net/?r=EezGQ-iGXGk">EezGQ-iGXGk</a>
      Game 2: <a href="http://play.prismata.net/?r=+3C8U-RJPej">Check out this game +3C8U-RJPej is rad!</a>
      Game 3: <a href="http://play.prismata.net/?r=3k4Cz-GC6Rp">3k4Cz-GC6Rp</a>
      Game 4: <a href="http://play.prismata.net/?r=3k4C+-+C6Rp">3k4C+-+C6Rp</a>
      Game 5: <a href="http://play.prismata.net/?r=__k4a-aat32">__k4a-aat32</a>
      This is a cool game! rsatd-dtasr
    </p></div></div>
    """

    gl = new GamesLinker
    gl.load doc[0]

    expect(rmws doc.html()).toBe rmws """
    <div class="md"><p>
      Game 1: <a href="http://play.prismata.net/?r=EezGQ-iGXGk">EezGQ-iGXGk</a>
      Game 2: <a href="http://play.prismata.net/?r=+3C8U-RJPej">Check out this game +3C8U-RJPej is rad!</a>
      Game 3: <a href="http://play.prismata.net/?r=3k4Cz-GC6Rp">3k4Cz-GC6Rp</a>
      Game 4: <a href="http://play.prismata.net/?r=3k4C+-+C6Rp">3k4C+-+C6Rp</a>
      Game 5: <a href="http://play.prismata.net/?r=__k4a-aat32">__k4a-aat32</a>
      This is a cool game! <a href="http://play.prismata.net/?r=rsatd-dtasr">rsatd-dtasr</a>
    </p></div>
    """

  it 'should replace individual games', ->
    doc = $ '<div class="entry"><div class="md"><p>EezGQ-iGXGk</p></div></div>'

    gl = new GamesLinker
    gl.load doc[0]

    expect(rmws doc.html()).toBe rmws '<div class="md"><p><a href="http://play.prismata.net/?r=EezGQ-iGXGk">EezGQ-iGXGk</a></p></div>'
