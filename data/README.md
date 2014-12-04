### Automatic units.json data scraping

Note that this was run just once, and then I subscribed to the units page to
edit the changes manually. Changes are not often enough to be worth an automation
script. Specially considering anyone can edit the Wiki.

Run the following on http://prismata.gamepedia.com/Unit

```JavaScript

// Copy the units with copy(units) after all the requests finish
var units = (function() {
  var script = document.createElement('script');
  script.src = 'https://rawgit.com/blakeembrey/pluralize/master/pluralize.js';
  document.head.appendChild(script);

  while(typeof pluralize === 'undefined'){};

  var units = {}
  var nodes = document.querySelectorAll('.wikitable td:first-child a');
  var arr = [];
  for (var i = 0; i < nodes.length; ++i) { arr.push(nodes[i]) };

  arr.forEach(function(a) {
    var name = a.innerHTML;
    var url = a.href;
    var unit = {
      names: [name, pluralize(name, 2)]
      , url: url
      , panelUrl: null
    };

    units[name] = unit;

    $.get(url, function(response){
      var div = document.createElement('div');
      div.innerHTML = response;
      var panelImage = div.querySelector('img[alt$="-panel.png"]');
      if (panelImage) {
        unit.panelUrl = panelImage.src.replace(/\?.*$/, '');
      }
    });
  });

  return units;
})();

```