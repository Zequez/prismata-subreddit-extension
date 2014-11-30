/**
 * This class takes care of matching the name and retrieving
 * the picture from the background
 * @constructor
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

var isPrismataSubreddit = document.location.pathname == '/r/prismata';

if (isPrismataSubreddit) {
  
}