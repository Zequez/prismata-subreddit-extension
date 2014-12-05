isPrismataSubreddit = document.location.pathname.match(/^\/r\/prismata/i)

if isPrismataSubreddit
  units = new PS.Units()
  units.load(document.body)

  gamesLinker = new PS.GamesLinker
  gamesLinker.load(document.body)