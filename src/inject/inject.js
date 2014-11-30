/**
 * This class takes care of matching the name and retrieving
 * the picture from the background
 * @class
 * @param name The official name of the unit
 * @param cardPromise The promise of the unit card (the URL of a picture, which loads asynchronically)
 */
var Unit = function(name, cardPromise) {
  this.name = name;
  this.cardPromise = cardPromise;
  this.generateRegex();
}

Unit.prototype.generateRegex = function() {
  this.regex = new RegExp(name); // TODO: make an actual regex
};

Unit.prototype.match = function(text) {
  this.regex.text(text);
};

Unit.prototype.card = function() {
  return this.cardPromise;
};

/**
 * Loads and generates all the units
 * @class
 */
var Units = function() {
  this.unitsNames = [];
  this.units = [];
  this.load();
};

Units.prototype.load = function() {
  // TODO: Load it from the background page
  this.unitsNames = ['Engineer', 'Drone', 'Conduit', 
                     'Blastforge', 'Animus', 'Forcefield',
                     'Gauss Cannon', 'Wall', 'Steelsplitter',
                     'Tarsier', 'Rhino'];

  this.unitsNames.forEach(function(name) {
    console.log(this);
    var cardPromise = new Promise(function() {});
    this.units.push(new Unit(name, cardPromise))
  }.bind(this));
};

var isPrismataSubreddit = document.location.pathname == '/r/prismata';

if (isPrismataSubreddit) {
  var units = new Units();
}