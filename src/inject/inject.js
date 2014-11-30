'use strict';

/**
 * This class takes care of matching the name and retrieving
 * the picture from the background
 * @class
 * @param name The official name of the unit
 * @param cardPromise The promise of the unit card (the URL of a picture, which loads asynchronically)
 */
var Unit = function (name, cardPromise) {
  this.name = name;
  this.cardPromise = cardPromise;
  this.generateRegex();
};

Unit.prototype.generateRegex = function () {
  this.regex = new RegExp(this.name); // TODO: make an actual regex
};

Unit.prototype.match = function (text) {
  this.regex.test(text);
};

Unit.prototype.card = function () {
  return this.cardPromise;
};

/**
 * Generates a mousehover link with the name of the unit
 * @class
 */
var UnitCard = function (unit, element) {
  this.unit = unit;
  this.element = element;
};

/**
 * Loads and generates all the units
 * @class
 */
var Units = function () {
  this.unitsNames = [];
  this.units = [];
  this.cards = [];
};

Units.prototype.load = function () {
  this.loadUnits().then(function () {
    this.searchPage();
  }.bind(this));
};

Units.prototype.loadUnits = function () {
  // TODO: Load it from the background page
  this.unitsNames = ['Engineer', 'Drone', 'Conduit',
                     'Blastforge', 'Animus', 'Forcefield',
                     'Gauss Cannon', 'Wall', 'Steelsplitter',
                     'Tarsier', 'Rhino'];

  this.unitsNames.forEach(function (name) {
    var cardPromise = new Promise(function () {});
    this.units.push(new Unit(name, cardPromise));
  }.bind(this));

  return Promise.resolve(this.units);
};

Units.prototype.searchPage = function () {
  var pageText = document.body.textContent;
  this.units.forEach(function (unit) {
    if (unit.match(pageText)) {
      this.cards.push(new UnitCard(unit, document.body));
    }
  }.bind(this));
};

var isPrismataSubreddit = document.location.pathname === '/r/prismata';

if (isPrismataSubreddit) {
  var units = new Units();
  units.load();
}