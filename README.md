### data/units.json

This file is loaded by the extension from this same repo. It has information
about all the units in the game, along with a link to the wiki page, and
a link to the official Wiki panel picture with all the unit information.

When a unit change we should update it here. You can make a pull request if you want.

### Changelog

- 0.1.0 (in development)
  - Inject script into the subreddit page and match the whole name of units
  - Load units data from the Github repo /data/units.json
  - Display the unit picture on mouse hover
  - Display flails for matches
  - Link to the wiki on each match
- 0.2.0 (planned)
  - Automatically add links to replays
  - Match prismata post on the front page too, and on titles
  - Add an options page
    - Define if you want to display only the text
    - Define if you want to display only the flails
    - Define the size of the flails
  - Replace standalone letters of basic unit with icons
    - B: Conduit
    - R: Blastforge
    - G: Animus
    - E: Energy
    - <number-at-the-begining>: Gold
- 0.3.0 (planned)
  - Add a toolbox for injecting units when creating a post or a comment
- 0.4.0 (planned)
  - Automatically replace units with CSS-friendly equivalent to display icons and allow non-extensions users to see icons too
    gonna need to coordinate with mods to add the ability to use the flail icons with links on the subreddit CSS.