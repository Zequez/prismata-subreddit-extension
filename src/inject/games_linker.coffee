###*
Automatically finds games-strings in the subreddit and
replace them with links to the game replay page.
@class
###
class PS.GamesLinker
  load: (targetElement)->
    paragraphs = targetElement.querySelectorAll('.entry .md p')

    regex = ///
      (^|\s)([a-z0-9+_]{5}
      -
      [a-z0-9+_]{5})(\s|$)
    ///ig

    for element in paragraphs
      html = element.innerHTML
      html = html.replace regex, (match, sp1, id, sp2, index, string)=>
        # Check what's closer, the next </a> or the next <a>
        nextA = string.indexOf('<a>', index) + 1 || string.length
        nextAA = string.indexOf('</a>', index) + 1 || string.length
        insideLink = nextAA < nextA

        if insideLink
          match
        else
          link = @_getLink id
          "#{sp1}<a href=\"#{link}\">#{id}</a>#{sp2}"

      element.innerHTML = html

    return


  _getLink: (gameId)->
    "http://play.prismata.net/?r=#{gameId}"