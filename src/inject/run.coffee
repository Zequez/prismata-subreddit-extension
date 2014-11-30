isPrismataSubreddit = document.location.pathname.match(/^\/r\/prismata/i)

if isPrismataSubreddit
  units = new Units()
  units.load(document.body)