import Testing
@testable import SpellSPM

@Test func spellDBAccess() async throws {
	let dba = try SpellDBAccess()
	
	let names = try await dba.getAllNames(force: false)
	
	#expect(!names.isEmpty)
	#expect(names.count > 2000)
	
	let MM = try await dba.allFieldsFor(spell: "Magic Missile")
	#expect(MMSpell == MM)
	
	let dom = try await dba.allFieldsFor(spell: "Dominate Monster")
	#expect(DominateSpell == dom)
	
	let best = try await dba.allFieldsFor(spell: "Bestow Curse")
	#expect(BestowCurseSpell == best)
	
	let schoolInts = try await dba.getAllIntValues(field: "school")
	#expect(!schoolInts.isEmpty)
	print(schoolInts[..<25])
	
	await #expect(throws: SpellsDBEx.notAString) {
		try await dba.getAllTextValues(field: "school")
	}
	
	
}

private let BestowCurseSpell = SpellFields(
	name : "Bestow Curse",
	school : 6,
	subschool : nil,
	source: "core",
	theme : "",
	verbal : true,
	somatic : true,
	material : false,
	focus : false,
	divFocus : false,
	cost : 0,
	dismissible : false,
	shapeable : false,
	ct : "1 standard action",
	ct_std : true,
	ct_swf : false,
	ct_immed : false,
	ct_free : false,
	ct_fullRd : false,
	ct_min : false,
	ct_hours : false,
	sor : 4,
	wiz : 4,
	clr : 3,
	drd : nil,
	rgr : nil,
	brd : nil,
	pal : nil,
	alc : nil,
	smn : nil,
	wit : 3,
	inq : nil,
	ora : 3,
	apal : 3,
	mag : nil,
	adp : 3,
	brg : 4,
	shm : 3,
	psy : nil,
	med : 2,
	mes : 3,
	occ : 3,
	spi : 4,
	acid : false,
	air : false,
	chaotic : false,
	cold : false,
	curse : true,
	darkness : false,
	death : false,
	disease : false,
	earth : false,
	electricity : false,
	emotion : false,
	evil : false,
	fear : false,
	fire : false,
	force : false,
	good : false,
	language_dependent : false,
	lawful : false,
	light : false,
	mind_affecting : false,
	pain : false,
	poison : false,
	shadow : false,
	sonic : false,
	water : false,
	mythic : false,
	SR : "yes",
	sr_no : false,
	sr_yes : true,
	sr_harmless : false,
	sr_object : false,
	sr_text : false,
	saves : "Will negates",
	fortNeg : false,
	fortPart : false,
	fortHalf : false,
	refNeg : false,
	refPart : false,
	refHalf : false,
	willNeg : true,
	willPart : false,
	willHalf : false,
	willDis : false,
	duration : "permanent",
	dur_instan : false,
	dur_rds : false,
	dur_mins : false,
	dur_hours : false,
	range : "touch",
	rge_self : false,
	rge_tch : true,
	rge_close : false,
	rge_med : false,
	rge_long : false,
	rge_feet : 0,
	target : "creature touched",
	sglTarget : false,
	targetPerCL : false,
	effect : "",
	emanation : false,
	burst : false,
	cone : false,
	spread : false,
	line : false,
	cylinder : false,
	bloodlines : "Accursed",
	domains : "Curse",
	brisk : false,
	empower : false,
	intensify : false,
	umbral : true,
	vast : false,
	widen : false,
	yai : false,
	hp_dmg : false
)

private let DominateSpell = SpellFields(
	name : "Dominate Monster",
	school : 3,
	subschool : 2,
	source: "core",
	theme : "",
	verbal : true,
	somatic : true,
	material : false,
	focus : false,
	divFocus : false,
	cost : 0,
	dismissible : false,
	shapeable : false,
	ct : "1 round",
	ct_std : false,
	ct_swf : false,
	ct_immed : false,
	ct_free : false,
	ct_fullRd : false,
	ct_min : false,
	ct_hours : false,
	sor : 9,
	wiz : 9,
	clr : nil,
	drd : nil,
	rgr : nil,
	brd : nil,
	pal : nil,
	alc : nil,
	smn : 6,
	wit : 9,
	inq : nil,
	ora : nil,
	apal : nil,
	mag : nil,
	adp : nil,
	brg : nil,
	shm : nil,
	psy : 9,
	med : nil,
	mes : nil,
	occ : nil,
	spi : nil,
	acid : false,
	air : false,
	chaotic : false,
	cold : false,
	curse : false,
	darkness : false,
	death : false,
	disease : false,
	earth : false,
	electricity : false,
	emotion : false,
	evil : false,
	fear : false,
	fire : false,
	force : false,
	good : false,
	language_dependent : false,
	lawful : false,
	light : false,
	mind_affecting : true,
	pain : false,
	poison : false,
	shadow : false,
	sonic : false,
	water : false,
	mythic : false,
	SR : "yes",
	sr_no : false,
	sr_yes : true,
	sr_harmless : false,
	sr_object : false,
	sr_text : false,
	saves : "Will negates",
	fortNeg : false,
	fortPart : false,
	fortHalf : false,
	refNeg : false,
	refPart : false,
	refHalf : false,
	willNeg : true,
	willPart : false,
	willHalf : false,
	willDis : false,
	duration : "1day/level",
	dur_instan : false,
	dur_rds : false,
	dur_mins : false,
	dur_hours : false,
	range : "close (25 ft. + 5 ft./2 levels)",
	rge_self : false,
	rge_tch : false,
	rge_close : true,
	rge_med : false,
	rge_long : false,
	rge_feet : 5,
	target : "one creature",
	sglTarget : false,
	targetPerCL : false,
	effect : "",
	emanation : false,
	burst : false,
	cone : false,
	spread : false,
	line : false,
	cylinder : false,
	bloodlines : "Oni, Rakshasa, Serpentine",
	domains : "Charm",
	brisk : false,
	empower : false,
	intensify : false,
	umbral : true,
	vast : false,
	widen : false,
	yai : false,
	hp_dmg : false
)

private let MMSpell = SpellFields(name : "Magic Missile",
								  school : 4,
		  subschool : nil,
		  source: "core",
		  theme : "",
		  verbal : true,
		  somatic : true,
		  material : false,
		  focus : false,
		  divFocus : false,
		  cost : 0,
		  dismissible : false,
		  shapeable : false,
		  ct : "1 standard action",
		  ct_std : true,
		  ct_swf : false,
		  ct_immed : false,
		  ct_free : false,
		  ct_fullRd : false,
		  ct_min : false,
		  ct_hours : false,
		  sor : 1,
		  wiz : 1,
		  clr : nil,
		  drd : nil,
		  rgr : nil,
		  brd : nil,
		  pal : nil,
		  alc : nil,
		  smn : nil,
		  wit : nil,
		  inq : nil,
		  ora : nil,
		  apal : nil,
		  mag : 1,
		  adp : nil,
		  brg : 1,
		  shm : nil,
		  psy : 1,
		  med : nil,
		  mes : nil,
		  occ : nil,
		  spi : nil,
		  acid : false,
		  air : false,
		  chaotic : false,
		  cold : false,
		  curse : false,
		  darkness : false,
		  death : false,
		  disease : false,
		  earth : false,
		  electricity : false,
		  emotion : false,
		  evil : false,
		  fear : false,
		  fire : false,
		  force : true,
		  good : false,
		  language_dependent : false,
		  lawful : false,
		  light : false,
		  mind_affecting : false,
		  pain : false,
		  poison : false,
		  shadow : false,
		  sonic : false,
		  water : false,
		  mythic : true,
		  SR : "yes",
		  sr_no : false,
		  sr_yes : true,
		  sr_harmless : false,
		  sr_object : false,
		  sr_text : false,
		  saves : "none",
		  fortNeg : false,
		  fortPart : false,
		  fortHalf : false,
		  refNeg : false,
		  refPart : false,
		  refHalf : false,
		  willNeg : false,
		  willPart : false,
		  willHalf : false,
		  willDis : false,
		  duration : "instantaneous",
		  dur_instan : true,
		  dur_rds : false,
		  dur_mins : false,
		  dur_hours : false,
		  range : "medium (100 ft. + 10 ft./level)",
		  rge_self : false,
		  rge_tch : false,
		  rge_close : false,
		  rge_med : true,
		  rge_long : false,
		  rge_feet : 0,
		  target : "up to five creatures, no two of which can be more than 15 ft. apart",
		  sglTarget : false,
		  targetPerCL : false,
		  effect : "",
		  emanation : false,
		  burst : false,
		  cone : false,
		  spread : false,
		  line : false,
		  cylinder : false,
		  bloodlines : nil,
		  domains : nil,
		  brisk : false,
		  empower : true,
		  intensify : false,
		  umbral : false,
		  vast : false,
		  widen : false,
		  yai : false,
		  hp_dmg : true
)

@Test func spellObject() async throws {
	let dba = try SpellDBAccess()
	let spellMM = await dba.getSpellObject(spell: "Magic Missile")
	#expect(spellMM != nil)
	
	if let spellMM {
		#expect(spellMM.schoolEvo)
		#expect(spellMM.subschool == nil)
		#expect(spellMM.isVerbal)
		#expect(spellMM.isSomatic)
		#expect(!spellMM.isMaterial)
		#expect(spellMM.sourceIsCore)
		#expect(spellMM.ctStandard)
		#expect(spellMM.isWizard)
		#expect(!spellMM.isPaladin)
		#expect(spellMM.isClassLevel(.wizard, lvl: 1))
		#expect(spellMM.descForce)
		#expect(!spellMM.descFire)
		#expect(spellMM.srYes)
		#expect(!spellMM.fort)
		#expect(!spellMM.reflex)
		#expect(!spellMM.will)
		#expect(spellMM.durInstantaneous)
		#expect(spellMM.rgeMedium)
	}
	
	#expect( await dba.getSpellObject(spell: "magic") == nil)
}
