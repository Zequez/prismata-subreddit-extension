UnitsScraper = PS.UnitsScraper
UnitData = PS.UnitData

# Ghetto query to get the units links names from the Wiki page manually
#######################################################################
# var nodes = document.querySelectorAll('.wikitable td:first-child a');
# var arr = [];
# for (var i = 0; i < nodes.length; ++i) { arr.push(nodes[i]) };
# var unitsNames = arr.map(function(v){ return v.innerHTML; })
# var unitsUrls = arr.map(function(v){ return v.href; })
#######################################################################

unitsNames = ["Cluster Bolt", "Auride Core", "Barrier", "Cryo Ray", "Forcefield", "Gauss Charge", "Pixie", "Thermite Core", "Doomed Drone", "Engineer", "Frostbite", "Husk", "Plexo Cell", "Trinity Drone", "Drone", "Immolite", "Perforator", "Steelforge", "Venge Cannon", "Blood Pact", "Chrono Filter", "Conduit", "Electrovore", "Fission Turret", "Frost Brooder", "Grimbotch", "Tarsier", "Tia Thurnax", "Vivid Drone", "Auric Impulse", "Blastforge", "Feral Warden", "Hellhound", "Iso Kronus", "Rhino", "Shiver Yeti", "Shredder", "Victory Bond", "Wall", "Wild Drone", "Aegis", "Animus", "Gauss Cannon", "Militia", "Ossified Drone", "Steelsplitter", "Synthesizer", "Zemora Voidbringer", "Bloodrager", "Chieftain", "Deadeye Operative", "Doomed Wall", "Flame Animus", "Gaussite Symbiote", "Iceblade Golem", "Protoplasm", "Scorchilla", "Shadowfang", "Xeno Guardian", "Doomed Mech", "Sentinel", "Energy Matrix", "Hannibull", "Grenade Mech", "Polywall", "Tesla Coil", "Cauterizer", "Cynestra", "Tatsu Nullifier", "Amporilla", "Centrifuge", "Plasmafier", "Gauss Fabricator", "Omega Splitter", "Drake", "Asteri Cannon", "Defense Grid", "Apollo", "Centurion", "Lucina Spinos"]
unitsUrls = ["http://prismata.gamepedia.com/Cluster_Bolt", "http://prismata.gamepedia.com/Auride_Core", "http://prismata.gamepedia.com/Barrier", "http://prismata.gamepedia.com/Cryo_Ray", "http://prismata.gamepedia.com/Forcefield", "http://prismata.gamepedia.com/Gauss_Charge", "http://prismata.gamepedia.com/Pixie", "http://prismata.gamepedia.com/Thermite_Core", "http://prismata.gamepedia.com/Doomed_Drone", "http://prismata.gamepedia.com/Engineer", "http://prismata.gamepedia.com/Frostbite", "http://prismata.gamepedia.com/Husk", "http://prismata.gamepedia.com/Plexo_Cell", "http://prismata.gamepedia.com/Trinity_Drone", "http://prismata.gamepedia.com/Drone", "http://prismata.gamepedia.com/Immolite", "http://prismata.gamepedia.com/Perforator", "http://prismata.gamepedia.com/Steelforge", "http://prismata.gamepedia.com/Venge_Cannon", "http://prismata.gamepedia.com/Blood_Pact", "http://prismata.gamepedia.com/Chrono_Filter", "http://prismata.gamepedia.com/Conduit", "http://prismata.gamepedia.com/Electrovore", "http://prismata.gamepedia.com/Fission_Turret", "http://prismata.gamepedia.com/Frost_Brooder", "http://prismata.gamepedia.com/Grimbotch", "http://prismata.gamepedia.com/Tarsier", "http://prismata.gamepedia.com/Tia_Thurnax", "http://prismata.gamepedia.com/Vivid_Drone", "http://prismata.gamepedia.com/Auric_Impulse", "http://prismata.gamepedia.com/Blastforge", "http://prismata.gamepedia.com/Feral_Warden", "http://prismata.gamepedia.com/Hellhound", "http://prismata.gamepedia.com/Iso_Kronus", "http://prismata.gamepedia.com/Rhino", "http://prismata.gamepedia.com/Shiver_Yeti", "http://prismata.gamepedia.com/Shredder", "http://prismata.gamepedia.com/Victory_Bond", "http://prismata.gamepedia.com/Wall", "http://prismata.gamepedia.com/Wild_Drone", "http://prismata.gamepedia.com/Aegis", "http://prismata.gamepedia.com/Animus", "http://prismata.gamepedia.com/Gauss_Cannon", "http://prismata.gamepedia.com/Militia", "http://prismata.gamepedia.com/Ossified_Drone", "http://prismata.gamepedia.com/Steelsplitter", "http://prismata.gamepedia.com/Synthesizer", "http://prismata.gamepedia.com/Zemora_Voidbringer", "http://prismata.gamepedia.com/Bloodrager", "http://prismata.gamepedia.com/Chieftain", "http://prismata.gamepedia.com/Deadeye_Operative", "http://prismata.gamepedia.com/Doomed_Wall", "http://prismata.gamepedia.com/Flame_Animus", "http://prismata.gamepedia.com/Gaussite_Symbiote", "http://prismata.gamepedia.com/Iceblade_Golem", "http://prismata.gamepedia.com/Protoplasm", "http://prismata.gamepedia.com/Scorchilla", "http://prismata.gamepedia.com/Shadowfang", "http://prismata.gamepedia.com/Xeno_Guardian", "http://prismata.gamepedia.com/Doomed_Mech", "http://prismata.gamepedia.com/Sentinel", "http://prismata.gamepedia.com/Energy_Matrix", "http://prismata.gamepedia.com/Hannibull", "http://prismata.gamepedia.com/Grenade_Mech", "http://prismata.gamepedia.com/Polywall", "http://prismata.gamepedia.com/Tesla_Coil", "http://prismata.gamepedia.com/Cauterizer", "http://prismata.gamepedia.com/Cynestra", "http://prismata.gamepedia.com/Tatsu_Nullifier", "http://prismata.gamepedia.com/Amporilla", "http://prismata.gamepedia.com/Centrifuge", "http://prismata.gamepedia.com/Plasmafier", "http://prismata.gamepedia.com/Gauss_Fabricator", "http://prismata.gamepedia.com/Omega_Splitter", "http://prismata.gamepedia.com/Drake", "http://prismata.gamepedia.com/Asteri_Cannon", "http://prismata.gamepedia.com/Defense_Grid", "http://prismata.gamepedia.com/Apollo", "http://prismata.gamepedia.com/Centurion", "http://prismata.gamepedia.com/Lucina_Spinos"]

ddescribe 'UnitsScraper', ->

  afterEach ->
    jasmine.Ajax.uninstall()

  describe '#scrap', ->
    it 'call the wiki page and get all the units names', (done)->
      getFixurePage 'units_page', (response)->
        jasmine.Ajax.install()
        jasmine.Ajax.stubRequest('http://prismata.gamepedia.com/Unit')
          .andReturn responseText: response

        scraper = new UnitsScraper

        unitDatas = []
        spyOn(PS, 'UnitData').and.callFake ->
          unitData = new UnitData arguments...
          unitDatas.push unitData
          unitData

        scraper.scrap()

        expect(jasmine.Ajax.requests.mostRecent().url)
          .toBe('http://prismata.gamepedia.com/Unit')

        expect(unitDatas.map((u)->u.name)).toMatch unitsNames

        done()

  describe '#_sanitizeName', ->
    it 'should return false on an invalid name and sanitize legitimate-looking ones', ->
      # scraper = new UnitsScraper
      # expect(scraper._sanitizeName('aa')).toEq false
      # expect(scraper._sanitizeName('aaa')).toEq 'aaa'
      # expect(scraper._sanitizeName('aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa')).toEq true

