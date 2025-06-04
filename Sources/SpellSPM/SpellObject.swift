//
//  SpellObject.swift
//  SpellList
//
//  Created by tridiak on 28/04/21.
//

import Foundation

public final class Spell : Hashable, Sendable {
	let name : String
	
	let spellData : SpellFields
	let source : String
	let school : SpellSchools
	let subschool : SpellSubschool?
	let domains : [String]
	let bloodlines : [String]
	
	init(name n: String, data: SpellFields) {
		self.name = n
		self.spellData = data
		self.source = spellData.source ?? "other"
		self.school = SpellSchools.from(int: spellData.school) ?? .unv
		self.subschool = SpellSubschool.from(int: spellData.subschool)
		if let d = spellData.domains {
			self.domains = Array(d.split(separator: ",").map { SS in
				return SS.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
			})
		}
		else {
			self.domains = []
		}
		
		if let d = spellData.bloodlines {
			self.bloodlines = Array(d.split(separator: ",").map { SS in
				return SS.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
			})
		}
		else {
			self.bloodlines = []
		}
	}
	
	//----------
	public static func == (lhs: Spell, rhs: Spell) -> Bool {
		return lhs.name == rhs.name
	}
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(name)
	}
}

//-------------------------------------------------------------------

// Whole pile of convenience functions and properties
extension Spell {
	// MARK: School
	
	var schoolAbj : Bool { return school == .abj }
	var schoolCnj : Bool { return school == .cnj }
	var schoolDiv : Bool { return school == .div }
	var schoolEnc : Bool { return school == .enc }
	var schoolEvo : Bool { return school == .evo }
	var schoolIll : Bool { return school == .ill }
	var schoolNec : Bool { return school == .nec }
	var schoolTrn : Bool { return school == .trn }
	var schoolUnv : Bool { return school == .unv }
	
	//--------------------------------------
	// MARK: subschool
	
	var hasCalling : Bool { return subschool == .calling }
	var hasCharm : Bool { return subschool == .charm }
	var hasCompulsion : Bool { return subschool == .compulsion }
	var hasCreation : Bool { return subschool == .creation }
	var hasFigment : Bool { return subschool == .figment }
	var hasGlamour : Bool { return subschool == .glamour }
	var hasHealing : Bool { return subschool == .healing }
	var hasPattern : Bool { return subschool == .pattern }
	var hasPhantasm : Bool { return subschool == .phantasm }
	var hasPolymorph : Bool { return subschool == .polymorph }
	var hasScrying : Bool { return subschool == .scrying }
	var hasShadow : Bool { return subschool == .shadow }
	var hasSummoning : Bool { return subschool == .summoning }
	var hasTeleportation : Bool { return subschool == .teleportation }
	var hasNoSubschool : Bool { return subschool == nil }
	
	//----------------------
	// MARK: Source
	
	var sourceIsCore : Bool { return source == "core" }
	var sourceIsAPG : Bool { return source == "apg" }
	var sourceIsACG : Bool { return source == "acg" }
	var sourceIsARG : Bool { return source == "arg" }
	var sourceIsUltimate : Bool { return source == "ultimate" }
	var sourceIsOther : Bool { return
		!(sourceIsCore || sourceIsAPG || sourceIsACG || sourceIsARG || sourceIsUltimate)
	}
	
	//--------------------------------------
	// MARK: Components
	
	func isComponent(_ comp: SpellComponents) -> Bool {
		return switch comp {
			case .V:
				spellData.verbal
			case .S:
				spellData.somatic
			case .M:
				spellData.material
			case .F:
				spellData.focus
			case .DF:
				spellData.divFocus
		}
	}
	
	var isVerbal : Bool { return isComponent(.V) }
	var isSomatic : Bool { return isComponent(.S) }
	var isMaterial : Bool { return isComponent(.M) }
	var isFocus : Bool { return isComponent(.F) }
	var isDivFocus : Bool { return isComponent(.DF) }
	
	//----------------------
	// MARK: -
	
	var goldCost : Int { return spellData.cost }
	
	var isDismissible : Bool { return spellData.dismissible }
	
	var isShapeable : Bool { return spellData.shapeable }
	
	var isMythic : Bool { return spellData.mythic }
	
	//---------------------------
	// MARK: Casting Time
	
	func isCT(_ ct: SpellCastingTime) -> Bool {
		return switch ct {
			case .standard:
				spellData.ct_std
			case .swift:
				spellData.ct_swf
			case .immediate:
				spellData.ct_immed
			case .free:
				spellData.ct_free
			case .fullRound:
				spellData.ct_fullRd
			case .minutes:
				spellData.ct_min
			case .hours:
				spellData.ct_hours
			case .other:
				!(spellData.ct_std || spellData.ct_swf || spellData.ct_immed ||
				 spellData.ct_free || spellData.ct_fullRd || spellData.ct_min ||
				 spellData.ct_hours)
		}
	}
	
	var ctStandard : Bool { return isCT(.standard) }
	var ctSwift : Bool { return isCT(.swift) }
	var ctImmediate : Bool { return isCT(.immediate) }
	var ctFree : Bool { return isCT(.free) }
	var ctFullRound : Bool { return isCT(.fullRound) }
	var ctMinutes : Bool { return isCT(.minutes) }
	var ctHours : Bool { return isCT(.hours) }
	var ctOther : Bool { return isCT(.other) }
	
	//---------------------------
	// MARK: Char Class
	
	func isCharClass(_ cc: CharClass) -> Bool {
		return switch cc {
			case .sorcerer:
				spellData.sor != nil
			case .wizard:
				spellData.wiz != nil
			case .cleric:
				spellData.clr != nil
			case .druid:
				spellData.drd != nil
			case .ranger:
				spellData.rgr != nil
			case .bard:
				spellData.brd != nil
			case .paladin:
				spellData.pal != nil
			case .alchemist:
				spellData.alc != nil
			case .summoner:
				spellData.smn != nil
			case .witch:
				spellData.wit != nil
			case .inquisitor:
				spellData.inq != nil
			case .oracle:
				spellData.ora != nil
			case .antipaladin:
				spellData.apal != nil
			case .magus:
				spellData.mag != nil
			case .adept:
				spellData.adp != nil
			case .bloodrager:
				spellData.brg != nil
			case .shaman:
				spellData.shm != nil
			case .psychic:
				spellData.psy != nil
			case .medium:
				spellData.med != nil
			case .mesmerist:
				spellData.mes != nil
			case .occultist:
				spellData.occ != nil
			case .spiritualist:
				spellData.spi != nil
			case .arcanist:
				false
				//spellData.arc != nil
			case .hunter:
				false
				//spellData.htr != nil
		}
	}
	
	var isSorcerer : Bool { return isCharClass(.sorcerer) }
	var isWizard : Bool { return isCharClass(.wizard) }
	var isCleric : Bool { return isCharClass(.cleric) }
	var isDruid : Bool { return isCharClass(.druid) }
	var isRanger : Bool { return isCharClass(.ranger) }
	var isBard : Bool { return isCharClass(.bard) }
	var isPaladin : Bool { return isCharClass(.paladin) }
	var isAlchemist : Bool { return isCharClass(.alchemist) }
	var isSummoner : Bool { return isCharClass(.summoner) }
	var isWitch : Bool { return isCharClass(.witch) }
	var isInquisitor : Bool { return isCharClass(.inquisitor) }
	var isOracle : Bool { return isCharClass(.oracle) }
	var isAntipaladin : Bool { return isCharClass(.antipaladin) }
	var isMagus : Bool { return isCharClass(.magus) }
	var isAdept : Bool { return isCharClass(.adept) }
	var isBloodrager : Bool { return isCharClass(.bloodrager) }
	var isShaman : Bool { return isCharClass(.shaman) }
	var isPsychic : Bool { return isCharClass(.psychic) }
	var isMedium : Bool { return isCharClass(.medium) }
	var isMesmerist : Bool { return isCharClass(.mesmerist) }
	var isOccultist : Bool { return isCharClass(.occultist) }
	var isSpiritualist : Bool { return isCharClass(.spiritualist) }
	var isArcanist : Bool { return isCharClass(.arcanist) }
	// var isSkald : Bool { return isCharClass(.skald) }
	// var isWarpriest : Bool { return isCharClass(.warpriest) }
	var isHunter : Bool { return isCharClass(.hunter) }
	
	//---------------------------
	
	func isClassLevel(_ cc: CharClass, lvl: UInt8) -> Bool {
		if !isCharClass(cc) { return false }
		return switch cc {
			case .sorcerer:
				spellData.sor! == lvl
			case .wizard:
				spellData.wiz! == lvl
			case .cleric:
				spellData.clr! == lvl
			case .druid:
				spellData.drd! == lvl
			case .ranger:
				spellData.rgr! == lvl
			case .bard:
				spellData.brd! == lvl
			case .paladin:
				spellData.pal! == lvl
			case .alchemist:
				spellData.alc! == lvl
			case .summoner:
				spellData.smn! == lvl
			case .witch:
				spellData.wit! == lvl
			case .inquisitor:
				spellData.inq! == lvl
			case .oracle:
				spellData.ora! == lvl
			case .antipaladin:
				spellData.apal! == lvl
			case .magus:
				spellData.mag! == lvl
			case .adept:
				spellData.adp! == lvl
			case .bloodrager:
				spellData.brg! == lvl
			case .shaman:
				spellData.shm! == lvl
			case .psychic:
				spellData.psy! == lvl
			case .medium:
				spellData.med! == lvl
			case .mesmerist:
				spellData.mes! == lvl
			case .occultist:
				spellData.occ! == lvl
			case .spiritualist:
				spellData.spi! == lvl
			case .arcanist:
				false
				//spellData.arc! == lvl
			case .hunter:
				false
				//spellData.htr! == lvl
		}
	}
	
	func isClassLevelNE(_ cc: CharClass, lvl: UInt8) -> Bool {
		return !isClassLevel(cc, lvl: lvl)
	}
	
	func isClassLevelLT(_ cc: CharClass, lvl: UInt8) -> Bool {
		if !isCharClass(cc) { return false }
		return switch cc {
			case .sorcerer:
				spellData.sor! < lvl
			case .wizard:
				spellData.wiz! < lvl
			case .cleric:
				spellData.clr! < lvl
			case .druid:
				spellData.drd! < lvl
			case .ranger:
				spellData.rgr! < lvl
			case .bard:
				spellData.brd! < lvl
			case .paladin:
				spellData.pal! < lvl
			case .alchemist:
				spellData.alc! < lvl
			case .summoner:
				spellData.smn! < lvl
			case .witch:
				spellData.wit! < lvl
			case .inquisitor:
				spellData.inq! < lvl
			case .oracle:
				spellData.ora! < lvl
			case .antipaladin:
				spellData.apal! < lvl
			case .magus:
				spellData.mag! < lvl
			case .adept:
				spellData.adp! < lvl
			case .bloodrager:
				spellData.brg! < lvl
			case .shaman:
				spellData.shm! < lvl
			case .psychic:
				spellData.psy! < lvl
			case .medium:
				spellData.med! < lvl
			case .mesmerist:
				spellData.mes! < lvl
			case .occultist:
				spellData.occ! < lvl
			case .spiritualist:
				spellData.spi! < lvl
			case .arcanist:
				false
				//spellData.arc! < lvl
			case .hunter:
				false
				//spellData.htr! < lvl
		}
	}
	
	func isClassLevelLTE(_ cc: CharClass, lvl: UInt8) -> Bool {
		if lvl == UInt8.max { return true }
		return isClassLevelLT(cc, lvl: lvl + 1)
	}
	
	func isClassLevelGT(_ cc: CharClass, lvl: UInt8) -> Bool {
		if lvl == 0 { return true }
		return !isClassLevelLT(cc, lvl: lvl - 1)
	}
	
	func isClassLevelGTE(_ cc: CharClass, lvl: UInt8) -> Bool {
		return !isClassLevelLT(cc, lvl: lvl)
	}
	
	//------------------------------------
	// MARK: Descriptors
	
	func hasDesc(_ desc: SpellDescriptors) -> Bool {
		return switch desc {
			case .acid:
				spellData.acid
			case .air:
				spellData.air
			case .chaotic:
				spellData.chaotic
			case .cold:
				spellData.cold
			case .curse:
				spellData.curse
			case .darkness:
				spellData.darkness
			case .death:
				spellData.death
			case .disease:
				spellData.disease
			case .earth:
				spellData.earth
			case .electricity:
				spellData.electricity
			case .emotion:
				spellData.emotion
			case .evil:
				spellData.evil
			case .fear:
				spellData.fear
			case .fire:
				spellData.fire
			case .force:
				spellData.force
			case .good:
				spellData.good
			case .language_dependent:
				spellData.language_dependent
			case .lawful:
				spellData.lawful
			case .light:
				spellData.light
			case .mind_affecting:
				spellData.mind_affecting
			case .pain:
				spellData.pain
			case .poison:
				spellData.poison
			case .shadow:
				spellData.shadow
			case .sonic:
				spellData.sonic
			case .water:
				spellData.water
		}
	}
	
	var descAcid : Bool { return spellData.acid }
	var descAir : Bool { return spellData.air }
	var descChaotic : Bool { return spellData.chaotic }
	var descCold : Bool { return spellData.cold }
	var descCurse : Bool { return spellData.curse }
	var descDarkness : Bool { return spellData.darkness }
	var descDeath : Bool { return spellData.death }
	var descDisease : Bool { return spellData.disease }
	var descEarth : Bool { return spellData.earth }
	var descElectricity : Bool { return spellData.electricity }
	var descEmotion : Bool { return spellData.emotion }
	var descEvil : Bool { return spellData.evil }
	var descFear : Bool { return spellData.fear }
	var descFire : Bool { return spellData.fire }
	var descForce : Bool { return spellData.force }
	var descGood : Bool { return spellData.good }
	var descLanguageDep : Bool { return spellData.language_dependent }
	var descLawful : Bool { return spellData.lawful }
	var descLight : Bool { return spellData.light }
	var descMindAffecting : Bool { return spellData.mind_affecting }
	var descPain : Bool { return spellData.pain }
	var descPoison : Bool { return spellData.poison }
	var descShadow : Bool { return spellData.shadow }
	var descSonic : Bool { return spellData.sonic }
	var descWater : Bool { return spellData.water }
	
	//------------------------------------
	// MARK: SR
	
	var srYes : Bool { return spellData.sr_yes }
	var srNo : Bool { return spellData.sr_no }
	var srObject : Bool { return spellData.sr_object }
	var srHarmless : Bool { return spellData.sr_harmless }
	
	// MARK: Saves
	
	var fortNeg : Bool { return spellData.fortNeg }
	var fortHalf : Bool { return spellData.fortHalf }
	var fortPart : Bool { return spellData.fortPart }
	var refNeg : Bool { return spellData.refNeg }
	var refHalf : Bool { return spellData.refHalf }
	var refPart : Bool { return spellData.refPart }
	var willNeg : Bool { return spellData.willNeg }
	var willHalf : Bool { return spellData.willHalf }
	var willPart : Bool { return spellData.willPart }
	var willDis : Bool { return spellData.willDis }
	var fort : Bool { return fortNeg || fortHalf || fortPart }
	var reflex : Bool { return refNeg || refHalf || refPart }
	var will : Bool { return willDis || willNeg || willHalf || willPart }
	
	//--------------------------------
	// MARK: duration
	
	var durInstantaneous : Bool { return spellData.dur_instan }
	var durRounds : Bool { return spellData.dur_rds }
	var durMinutes : Bool { return spellData.dur_mins }
	var durHours : Bool { return spellData.dur_hours }
	
	//----------------------------------
	// MARK: range
	func isRange(_ rge: SpellRange) -> Bool {
		return switch rge {
			case .personal:
				spellData.rge_self
			case .touch:
				spellData.rge_tch
			case .close:
				spellData.rge_close
			case .medium:
				spellData.rge_med
			case .long:
				spellData.rge_long
			case .feet(_):
				spellData.rge_feet > 0
		}
	}
	
	var rgePersonal : Bool { return isRange(.personal) }
	var rgeTouch : Bool { return isRange(.touch) }
	var rgeClose : Bool { return isRange(.close) }
	var rgeMedium : Bool { return isRange(.medium) }
	var rgeLong : Bool { return isRange(.long) }
	var isSetDistance : Bool { return isRange(.feet(0)) }
	
	/// feet comparison only
	func rangeLT(feet: UInt) -> Bool {
		return spellData.rge_feet < feet
	}
	
	func rangeLTE(feet: UInt) -> Bool {
		return spellData.rge_feet <= feet
	}
	
	func rangeGT(feet: UInt) -> Bool {
		return spellData.rge_feet > feet
	}
	
	func rangeGTE(feet: UInt) -> Bool {
		return spellData.rge_feet >= feet
	}
	
	func rangeEQ(feet: UInt) -> Bool {
		return spellData.rge_feet == feet
	}
	
	func rangeNE(feet: UInt) -> Bool {
		return spellData.rge_feet != feet
	}
	
	/// Comparison order: personal, touch, close, medium, long. Feet field is ignored.
	func rangeLT(feet: UInt, CL: UInt8) -> Bool {
		if rgePersonal { return true }
		if rgeTouch { return true }
		if rgeClose { return 25 + (UInt(CL) / 2) * 5 < feet }
		if rgeMedium { return 100 + UInt(CL) * 10 < feet }
		if rgeLong { return 400 + UInt(CL) * 40 < feet }
		return false
	}
	
	func rangeLTE(feet: UInt, CL: UInt8) -> Bool {
		if rgePersonal { return true }
		if rgeTouch { return true }
		if rgeClose { return 25 + (UInt(CL) / 2) * 5 <= feet }
		if rgeMedium { return 100 + UInt(CL) * 10 <= feet }
		if rgeLong { return 400 + UInt(CL) * 40 <= feet }
		return false
	}
	
	func rangeGT(feet: UInt, CL: UInt8) -> Bool {
		if rgePersonal { return false }
		if rgeTouch { return false }
		if rgeClose { return 25 + (UInt(CL) / 2) * 5 > feet }
		if rgeMedium { return 100 + UInt(CL) * 10 > feet }
		if rgeLong { return 400 + UInt(CL) * 40 > feet }
		return false
	}
	
	func rangeGTE(feet: UInt, CL: UInt8) -> Bool {
		if rgePersonal { return feet == 0 }
		if rgeTouch { return feet == 0 }
		if rgeClose { return 25 + (UInt(CL) / 2) * 5 >= feet }
		if rgeMedium { return 100 + UInt(CL) * 10 >= feet }
		if rgeLong { return 400 + UInt(CL) * 40 >= feet }
		return false
	}
	
	// MARK: -
	
	var isSingleTarget : Bool { return spellData.sglTarget }
	var isTargetsPerCL : Bool { return spellData.targetPerCL }
	
	var isBurst : Bool { return spellData.burst }
	var isCone : Bool { return spellData.cone }
	var isSpread : Bool { return spellData.spread }
	var isLine : Bool { return spellData.line }
	var isEmanation : Bool { return spellData.emanation }
	var isCylinder : Bool { return spellData.cylinder }
	
	// MARK: -
	
	var isDomain : Bool { return !domains.isEmpty }
	var isBloodline : Bool { return !bloodlines.isEmpty }
	
	func hasDomain(name: String) -> Bool {
		return domains.contains(name.lowercased())
	}
	
	func hasBloodline(name: String) -> Bool {
		return bloodlines.contains(name.lowercased())
	}
	
	//-----------------------
	// MARK: metamagic
	
	var canMMEmpowered : Bool { return spellData.empower }
	var canMMBrisk : Bool { return spellData.brisk }
	var canMMIntensified : Bool { return spellData.intensify }
	var canMMUmbral : Bool { return spellData.umbral }
	var canMMVast : Bool { return spellData.vast }
	var canMMWiden : Bool { return spellData.widen }
	var canMMYaiMimic : Bool { return spellData.yai }
	var isHPDmg : Bool { return spellData.hp_dmg }
	var canMMAuthorative : Bool { return isSingleTarget }
	var canMMBenthic : Bool { return descAcid || descCold || descElectricity || descFire }
	var canMMBlissful : Bool { return isSingleTarget }
	var canMMBrackish : Bool { return descWater }
	var canMMBurning : Bool { return descAcid || descFire }
	var canMMCentred : Bool { return durInstantaneous && (isBurst || isEmanation || isSpread || isCylinder ) }
	var canMMConcussive : Bool { return descSonic }
	var canMMCrypt : Bool { return isHPDmg }
	var canMMEclipsed : Bool { return descLight || descDarkness }
	var canMMElemental : Bool { return descFire || descCold || descAcid || descElectricity }
	var canMMEnlarge : Bool { return rgeClose || rgeMedium || rgeLong }
	var canMMFearsome : Bool { return isHPDmg }
	var canMMFlaring : Bool { return descFire || descLight || descElectricity }
	var canMMFurious : Bool { return isHPDmg }
	var canMMLatentCurse : Bool { return descCurse }
	var canMMLingering : Bool { return durInstantaneous }
	var canMMMaximised : Bool { return spellData.empower }
	var canMMMerciful : Bool { return isHPDmg }
	var canMMPersistent : Bool { return fort || reflex || will }
	var canMMQuicken : Bool { return ctStandard }
	var canMMReach : Bool { return rgeTouch || rgeClose || rgeMedium }
	var canMMRime : Bool { return isHPDmg && descCold }
	var canMMScarring : Bool { return descEmotion || descFear }
	var canMMScouting : Bool { return schoolCnj && hasSummoning }
	var canMMSilent : Bool { return isVerbal }
	var canMMSolar : Bool { return descLight }
	var canMMStill : Bool { return isSomatic }
	var canMMSteam : Bool { return descFire }
	var canMMTenebrous : Bool { return descLight }
	var canMMThreateningIllusion : Bool { return schoolIll && hasFigment }
	var canMMThrenodic : Bool { return descMindAffecting }
	var canMMThundering : Bool { return isHPDmg }
	var canMMToxic : Bool { return fortNeg && !descPoison }
	var canMMTraumatic : Bool { return descEmotion && descFear }
	var canMMTrick : Bool { return schoolEnc && willNeg && isSingleTarget }
}

//------------------------------------------------
// MARK: - Spell Storage

public actor SpellStorage {
	init() throws {
		spellDB = try SpellDBAccess()
	}
	
	init(dbPath: String) throws {
		spellDB = try SpellDBAccess(dbPath: dbPath)
	}
	
	private let spellDB : SpellDBAccess
	private var spells : [String:Spell] = [:]
	
	/// If spell already exists, it will be returned. If name is empty (after white space is trimmed), nil will be returned.
	/// Will retreive from spell DB otherwise.
	@discardableResult func retrieveSpell(name: String) async -> Spell? {
		let n = name.trimmingCharacters(in: .whitespacesAndNewlines)
		if n.isEmpty { return nil }
		
		if let s = spells[n] { return s }
		
		guard let data = await spellDB.getSpellObject(spell: name) else {
			return nil
		}
		
		spells[n] = data
		
		return data
	}
	
	func getSpell(name: String) -> Spell? {
		let n = name.trimmingCharacters(in: .whitespacesAndNewlines)
		
		return spells[n]
	}
	
	
	/// Memory release.
	func purgeAllSpells() {
		spells.removeAll()
	}
}
