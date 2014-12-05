## PSE: Prismata Subreddit Extension

<img src="https://raw.githubusercontent.com/Zequez/prismata-subreddit-extension/master/images/screenshot.png"/>

This is a *non-official* Chrome extension for the
[Prismata Subreddit /r/Prismata](http://www.reddit.com/r/Prismata/).

It adds a bunch of cool features:
 - Adds icons next to the name the units (the same icons used on flails!).
 - When you hover the mouse on an unit name it displays the unit panel with all the information
   just like in the game. These panels come directly from the [official Prismata Wiki](http://prismata.gamepedia.com/).
 - Each unit name detected is turned into a link to the Wiki page of that unit.
 - Automatically links the game replays IDs

<p align="center">
  <a href="https://chrome.google.com/webstore/detail/prismata-subreddit-extens/kibofaneppnocghmpkmanakeojkakblp">
    <img src="https://raw.githubusercontent.com/Zequez/prismata-subreddit-extension/master/images/chrome-web-store.png"/>
  </a>
</p>

## data/units.json

This file is loaded by the extension from this same repo. It has information
about all the units in the game, along with a link to the Wiki page, and
a link to the official wiki panel picture with all of the unit information.

When a unit change or new units are added we should update it here. You can make
a pull request if you want. Although I have the wiki units page on my watchlist,
so I get an email when anything changes and I'll try to keep it in sync with the wiki.

## Changelog (and planned features)

- 0.1.0 (current)
  - :heavy_check_mark: Inject script into the subreddit page and match the whole name of units
  - :heavy_check_mark: Load units data from the Github repo /data/units.json
  - :heavy_check_mark: Display the unit picture on mouse hover
  - :heavy_check_mark: Display flails for matches
  - :heavy_check_mark: Link to the wiki on each match
- 0.2.0 (in development)
  - :heavy_check_mark: Automatically add links to replays
  - Match Prismata post on the front page too, and on titles
  - Add an options page
    - Define if you want to display only the text
    - Define if you want to display only the flails
    - Define the size of the flails
  - Replace standalone letters of basic unit with icons
    - E: Engineer
    - D: Drone
    - C: Conduit
    - B: Blastforge
    - A: Animus
    - F: Forcefield
    - G: Gauss Cannon
    - W: Wall
    - S: Steelsplitter
    - T: Tarsier
    - R: Rhino
- 0.3.0 (planned)
  - Add a toolbox for injecting units when creating a post or a comment
- 0.4.0 (planned)
  - Using the toolbox, automatically replace units with CSS-friendly-link equivalent to display icons
    and allow non-extensions users to see icons too. Gonna need to coordinate with mods
    to add the ability to use links to display the flail icons changing the subreddit CSS.
- 0.5.0 (planned)
  - Add instant units search tool to the Reddit search box when inside /r/Prismata

## License

Prismata Subreddit Extension is released under the [MIT License](http://www.opensource.org/licenses/MIT).

## Legal

Prismata and all the Prismata art, images, and lore are copyrighted by [Lunarch Studios](http://lunarchstudios.com/).


