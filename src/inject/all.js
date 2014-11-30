
/**
This class takes care of matching the name and retrieving
the picture from the background
@class
@param name The official name of the unit
@param cardPromise The promise of the unit card
       (the URL of a picture, which loads asynchronically)
 */

(function() {
  var Unit, UnitCard, Units, isPrismataSubreddit, units;

  Unit = (function() {
    function Unit(name, cardPromise) {
      this.name = name;
      this.cardPromise = cardPromise;
      this.generateRegex();
    }

    Unit.prototype.generateRegex = function() {
      return this.regex = new RegExp(this.name, 'i');
    };

    Unit.prototype.test = function(text) {
      return this.regex.test(text);
    };

    Unit.prototype.match = function(text) {
      return text.match(this.regex);
    };

    Unit.prototype.card = function() {
      return this.cardPromise;
    };

    return Unit;

  })();


  /**
  Generates a mousehover link with the name of the unit
  @class
   */

  UnitCard = (function() {
    function UnitCard(unit, element, html) {
      this.unit = unit;
      this.element = element;
      this.html = html;
      console.log('Unit found!', this.unit.name);
    }


    /**
    Inserts an <a> element where the unit name was found
    @returns {String} the new HTML of the parent element
     */

    UnitCard.prototype.insert = function() {
      return this.html;
    };

    return UnitCard;

  })();


  /**
  Loads and generates all the units
  @class
   */

  Units = (function() {
    function Units() {
      this.unitsNames = [];
      this.units = [];
      this.cards = [];
    }

    Units.prototype.load = function(targetElement) {
      return this.loadUnits().then((function(_this) {
        return function() {
          return _this.searchPage(targetElement);
        };
      })(this));
    };

    Units.prototype.loadUnits = function() {
      var cardPromise, name, _i, _len, _ref;
      this.unitsNames = ["Engineer", "Drone", "Conduit", "Blastforge", "Animus", "Forcefield", "Gauss Cannon", "Wall", "Steelsplitter", "Tarsier", "Rhino"];
      cardPromise = new Promise(function(resolve, reject) {
        return resolve('http://potato.com');
      });
      _ref = this.unitsNames;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        name = _ref[_i];
        this.units.push(new Unit(name, cardPromise));
      }
      return Promise.resolve(this.units);
    };

    Units.prototype.searchPage = function(targetElement) {
      var element, html, match, paragraphs, unit, unitCard, _i, _j, _len, _len1, _ref;
      paragraphs = targetElement.querySelectorAll('.entry .md p');
      for (_i = 0, _len = paragraphs.length; _i < _len; _i++) {
        element = paragraphs[_i];
        html = element.innerHTML;
        _ref = this.units;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          unit = _ref[_j];
          if (match = unit.test(html)) {
            unitCard = new UnitCard(unit, element, html);
            this.cards.push(unitCard);
            html = unitCard.insert();
          }
        }
      }
    };

    return Units;

  })();

  isPrismataSubreddit = document.location.pathname.match(/^\/r\/prismata/i);

  if (isPrismataSubreddit) {
    units = new Units();
    units.load(document.body);
  }

}).call(this);
