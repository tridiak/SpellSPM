//
//  SpellObject.swift
//  SpellList
//
//  Created by tridiak on 28/04/21.
//

import Foundation

/// All properties are readonly.
public final class Spell : Hashable, Sendable {
	public let name : String
	
	public let spellData : SpellFields
	public let source : String
	public let school : SpellSchools
	public let subschool : SpellSubschool?
	public let domains : [String]
	public let bloodlines : [String]
	
	public init(name n: String, data: SpellFields) {
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
	
	public var schoolAbj : Bool { return school == .abj }
	public var schoolCnj : Bool { return school == .cnj }
	public var schoolDiv : Bool { return school == .div }
	public var schoolEnc : Bool { return school == .enc }
	public var schoolEvo : Bool { return school == .evo }
	public var schoolIll : Bool { return school == .ill }
	public var schoolNec : Bool { return school == .nec }
	public var schoolTrn : Bool { return school == .trn }
	public var schoolUnv : Bool { return school == .unv }
	
	//--------------------------------------
	// MARK: subschool
	
	public var hasCalling : Bool { return subschool == .calling }
	public var hasCharm : Bool { return subschool == .charm }
	public var hasCompulsion : Bool { return subschool == .compulsion }
	public var hasCreation : Bool { return subschool == .creation }
	public var hasFigment : Bool { return subschool == .figment }
	public var hasGlamour : Bool { return subschool == .glamour }
	public var hasHealing : Bool { return subschool == .healing }
	public var hasPattern : Bool { return subschool == .pattern }
	public var hasPhantasm : Bool { return subschool == .phantasm }
	public var hasPolymorph : Bool { return subschool == .polymorph }
	public var hasScrying : Bool { return subschool == .scrying }
	public var hasShadow : Bool { return subschool == .shadow }
	public var hasSummoning : Bool { return subschool == .summoning }
	public var hasTeleportation : Bool { return subschool == .teleportation }
	public var hasNoSubschool : Bool { return subschool == nil }
	
	//----------------------
	// MARK: Source
	
	public var sourceIsCore : Bool { return source == "core" }
	public var sourceIsAPG : Bool { return source == "apg" }
	public var sourceIsACG : Bool { return source == "acg" }
	public var sourceIsARG : Bool { return source == "arg" }
	public var sourceIsUltimate : Bool { return source == "ultimate" }
	public var sourceIsOther : Bool { return
		!(sourceIsCore || sourceIsAPG || sourceIsACG || sourceIsARG || sourceIsUltimate)
	}
	
	//--------------------------------------
	// MARK: Components
	
	public func isComponent(_ comp: SpellComponents) -> Bool {
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
	
	public var isVerbal : Bool { return isComponent(.V) }
	public var isSomatic : Bool { return isComponent(.S) }
	public var isMaterial : Bool { return isComponent(.M) }
	public var isFocus : Bool { return isComponent(.F) }
	public var isDivFocus : Bool { return isComponent(.DF) }
	
	//----------------------
	// MARK: -
	
	public var goldCost : Int { return spellData.cost }
	
	public var isDismissible : Bool { return spellData.dismissible }
	
	public var isShapeable : Bool { return spellData.shapeable }
	
	public var isMythic : Bool { return spellData.mythic }
	
	//---------------------------
	// MARK: Casting Time
	
	public func isCT(_ ct: SpellCastingTime) -> Bool {
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
	
	public var ctStandard : Bool { return isCT(.standard) }
	public var ctSwift : Bool { return isCT(.swift) }
	public var ctImmediate : Bool { return isCT(.immediate) }
	public var ctFree : Bool { return isCT(.free) }
	public var ctFullRound : Bool { return isCT(.fullRound) }
	public var ctMinutes : Bool { return isCT(.minutes) }
	public var ctHours : Bool { return isCT(.hours) }
	public var ctOther : Bool { return isCT(.other) }
	
	//---------------------------
	// MARK: Char Class
	
	/// Returns true if character class has spell in its spell list
	public func isCharClass(_ cc: CharClass) -> Bool {
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
	
	public var isSorcerer : Bool { return isCharClass(.sorcerer) }
	public var isWizard : Bool { return isCharClass(.wizard) }
	public var isCleric : Bool { return isCharClass(.cleric) }
	public var isDruid : Bool { return isCharClass(.druid) }
	public var isRanger : Bool { return isCharClass(.ranger) }
	public var isBard : Bool { return isCharClass(.bard) }
	public var isPaladin : Bool { return isCharClass(.paladin) }
	public var isAlchemist : Bool { return isCharClass(.alchemist) }
	public var isSummoner : Bool { return isCharClass(.summoner) }
	public var isWitch : Bool { return isCharClass(.witch) }
	public var isInquisitor : Bool { return isCharClass(.inquisitor) }
	public var isOracle : Bool { return isCharClass(.oracle) }
	public var isAntipaladin : Bool { return isCharClass(.antipaladin) }
	public var isMagus : Bool { return isCharClass(.magus) }
	public var isAdept : Bool { return isCharClass(.adept) }
	public var isBloodrager : Bool { return isCharClass(.bloodrager) }
	public var isShaman : Bool { return isCharClass(.shaman) }
	public var isPsychic : Bool { return isCharClass(.psychic) }
	public var isMedium : Bool { return isCharClass(.medium) }
	public var isMesmerist : Bool { return isCharClass(.mesmerist) }
	public var isOccultist : Bool { return isCharClass(.occultist) }
	public var isSpiritualist : Bool { return isCharClass(.spiritualist) }
	public var isArcanist : Bool { return isCharClass(.arcanist) }
	// public var isSkald : Bool { return isCharClass(.skald) }
	// public var isWarpriest : Bool { return isCharClass(.warpriest) }
	public var isHunter : Bool { return isCharClass(.hunter) }
	
	//---------------------------
	
	/// Returns true is spells has passed character class and spell level
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
	
	public var descAcid : Bool { return spellData.acid }
	public var descAir : Bool { return spellData.air }
	public var descChaotic : Bool { return spellData.chaotic }
	public var descCold : Bool { return spellData.cold }
	public var descCurse : Bool { return spellData.curse }
	public var descDarkness : Bool { return spellData.darkness }
	public var descDeath : Bool { return spellData.death }
	public var descDisease : Bool { return spellData.disease }
	public var descEarth : Bool { return spellData.earth }
	public var descElectricity : Bool { return spellData.electricity }
	public var descEmotion : Bool { return spellData.emotion }
	public var descEvil : Bool { return spellData.evil }
	public var descFear : Bool { return spellData.fear }
	public var descFire : Bool { return spellData.fire }
	public var descForce : Bool { return spellData.force }
	public var descGood : Bool { return spellData.good }
	public var descLanguageDep : Bool { return spellData.language_dependent }
	public var descLawful : Bool { return spellData.lawful }
	public var descLight : Bool { return spellData.light }
	public var descMindAffecting : Bool { return spellData.mind_affecting }
	public var descPain : Bool { return spellData.pain }
	public var descPoison : Bool { return spellData.poison }
	public var descShadow : Bool { return spellData.shadow }
	public var descSonic : Bool { return spellData.sonic }
	public var descWater : Bool { return spellData.water }
	
	//------------------------------------
	// MARK: SR
	
	public var srYes : Bool { return spellData.sr_yes }
	public var srNo : Bool { return spellData.sr_no }
	public var srObject : Bool { return spellData.sr_object }
	public var srHarmless : Bool { return spellData.sr_harmless }
	
	// MARK: Saves
	
	public var fortNeg : Bool { return spellData.fortNeg }
	public var fortHalf : Bool { return spellData.fortHalf }
	public var fortPart : Bool { return spellData.fortPart }
	public var refNeg : Bool { return spellData.refNeg }
	public var refHalf : Bool { return spellData.refHalf }
	public var refPart : Bool { return spellData.refPart }
	public var willNeg : Bool { return spellData.willNeg }
	public var willHalf : Bool { return spellData.willHalf }
	public var willPart : Bool { return spellData.willPart }
	public var willDis : Bool { return spellData.willDis }
	public var fort : Bool { return fortNeg || fortHalf || fortPart }
	public var reflex : Bool { return refNeg || refHalf || refPart }
	public var will : Bool { return willDis || willNeg || willHalf || willPart }
	
	//--------------------------------
	// MARK: duration
	
	public var durInstantaneous : Bool { return spellData.dur_instan }
	public var durRounds : Bool { return spellData.dur_rds }
	public var durMinutes : Bool { return spellData.dur_mins }
	public var durHours : Bool { return spellData.dur_hours }
	
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
	
	public var rgePersonal : Bool { return isRange(.personal) }
	public var rgeTouch : Bool { return isRange(.touch) }
	public var rgeClose : Bool { return isRange(.close) }
	public var rgeMedium : Bool { return isRange(.medium) }
	public var rgeLong : Bool { return isRange(.long) }
	public var isSetDistance : Bool { return isRange(.feet(0)) }
	
	/// feet comparison only
	public func rangeLT(feet: UInt) -> Bool {
		return spellData.rge_feet < feet
	}
	
	public func rangeLTE(feet: UInt) -> Bool {
		return spellData.rge_feet <= feet
	}
	
	public func rangeGT(feet: UInt) -> Bool {
		return spellData.rge_feet > feet
	}
	
	public func rangeGTE(feet: UInt) -> Bool {
		return spellData.rge_feet >= feet
	}
	
	public func rangeEQ(feet: UInt) -> Bool {
		return spellData.rge_feet == feet
	}
	
	public func rangeNE(feet: UInt) -> Bool {
		return spellData.rge_feet != feet
	}
	
	/// Comparison order: personal, touch, close, medium, long. Feet field is ignored.
	public func rangeLT(feet: UInt, CL: UInt8) -> Bool {
		if rgePersonal { return true }
		if rgeTouch { return true }
		if rgeClose { return 25 + (UInt(CL) / 2) * 5 < feet }
		if rgeMedium { return 100 + UInt(CL) * 10 < feet }
		if rgeLong { return 400 + UInt(CL) * 40 < feet }
		return false
	}
	
	public func rangeLTE(feet: UInt, CL: UInt8) -> Bool {
		if rgePersonal { return true }
		if rgeTouch { return true }
		if rgeClose { return 25 + (UInt(CL) / 2) * 5 <= feet }
		if rgeMedium { return 100 + UInt(CL) * 10 <= feet }
		if rgeLong { return 400 + UInt(CL) * 40 <= feet }
		return false
	}
	
	public func rangeGT(feet: UInt, CL: UInt8) -> Bool {
		if rgePersonal { return false }
		if rgeTouch { return false }
		if rgeClose { return 25 + (UInt(CL) / 2) * 5 > feet }
		if rgeMedium { return 100 + UInt(CL) * 10 > feet }
		if rgeLong { return 400 + UInt(CL) * 40 > feet }
		return false
	}
	
	public func rangeGTE(feet: UInt, CL: UInt8) -> Bool {
		if rgePersonal { return feet == 0 }
		if rgeTouch { return feet == 0 }
		if rgeClose { return 25 + (UInt(CL) / 2) * 5 >= feet }
		if rgeMedium { return 100 + UInt(CL) * 10 >= feet }
		if rgeLong { return 400 + UInt(CL) * 40 >= feet }
		return false
	}
	
	// MARK: -
	
	public var isSingleTarget : Bool { return spellData.sglTarget }
	public var isTargetsPerCL : Bool { return spellData.targetPerCL }
	
	public var isBurst : Bool { return spellData.burst }
	public var isCone : Bool { return spellData.cone }
	public var isSpread : Bool { return spellData.spread }
	public var isLine : Bool { return spellData.line }
	public var isEmanation : Bool { return spellData.emanation }
	public var isCylinder : Bool { return spellData.cylinder }
	
	// MARK: -
	
	public var isDomain : Bool { return !domains.isEmpty }
	public var isBloodline : Bool { return !bloodlines.isEmpty }
	
	public func hasDomain(name: String) -> Bool {
		return domains.contains(name.lowercased())
	}
	
	public func hasBloodline(name: String) -> Bool {
		return bloodlines.contains(name.lowercased())
	}
	
	//-----------------------
	// MARK: metamagic
	
	public var canMMEmpowered : Bool { return spellData.empower }
	public var canMMBrisk : Bool { return spellData.brisk }
	public var canMMIntensified : Bool { return spellData.intensify }
	public var canMMUmbral : Bool { return spellData.umbral }
	public var canMMVast : Bool { return spellData.vast }
	public var canMMWiden : Bool { return spellData.widen }
	public var canMMYaiMimic : Bool { return spellData.yai }
	public var isHPDmg : Bool { return spellData.hp_dmg }
	public var canMMAuthorative : Bool { return isSingleTarget }
	public var canMMBenthic : Bool { return descAcid || descCold || descElectricity || descFire }
	public var canMMBlissful : Bool { return isSingleTarget }
	public var canMMBrackish : Bool { return descWater }
	public var canMMBurning : Bool { return descAcid || descFire }
	public var canMMCentred : Bool { return durInstantaneous && (isBurst || isEmanation || isSpread || isCylinder ) }
	public var canMMConcussive : Bool { return descSonic }
	public var canMMCrypt : Bool { return isHPDmg }
	public var canMMEclipsed : Bool { return descLight || descDarkness }
	public var canMMElemental : Bool { return descFire || descCold || descAcid || descElectricity }
	public var canMMEnlarge : Bool { return rgeClose || rgeMedium || rgeLong }
	public var canMMFearsome : Bool { return isHPDmg }
	public var canMMFlaring : Bool { return descFire || descLight || descElectricity }
	public var canMMFurious : Bool { return isHPDmg }
	public var canMMLatentCurse : Bool { return descCurse }
	public var canMMLingering : Bool { return durInstantaneous }
	public var canMMMaximised : Bool { return spellData.empower }
	public var canMMMerciful : Bool { return isHPDmg }
	public var canMMPersistent : Bool { return fort || reflex || will }
	public var canMMQuicken : Bool { return ctStandard }
	public var canMMReach : Bool { return rgeTouch || rgeClose || rgeMedium }
	public var canMMRime : Bool { return isHPDmg && descCold }
	public var canMMScarring : Bool { return descEmotion || descFear }
	public var canMMScouting : Bool { return schoolCnj && hasSummoning }
	public var canMMSilent : Bool { return isVerbal }
	public var canMMSolar : Bool { return descLight }
	public var canMMStill : Bool { return isSomatic }
	public var canMMSteam : Bool { return descFire }
	public var canMMTenebrous : Bool { return descLight }
	public var canMMThreateningIllusion : Bool { return schoolIll && hasFigment }
	public var canMMThrenodic : Bool { return descMindAffecting }
	public var canMMThundering : Bool { return isHPDmg }
	public var canMMToxic : Bool { return fortNeg && !descPoison }
	public var canMMTraumatic : Bool { return descEmotion && descFear }
	public var canMMTrick : Bool { return schoolEnc && willNeg && isSingleTarget }
}

//------------------------------------------------
// MARK: - Spell Storage

/// Simple storage for Spell obejcts. Use `retrieveSpell()` if has the store check if DB if it does not have it cached.
/// User `getSpell()` to see if the storage has the spell.
public actor SpellStorage {
	public init() throws {
		spellDB = try SpellDBAccess()
	}
	
	public init(dbPath: String) throws {
		spellDB = try SpellDBAccess(dbPath: dbPath)
	}
	
	private let spellDB : SpellDBAccess
	private var spells : [String:Spell] = [:]
	
	/// If spell already exists, it will be returned. If name is empty (after white space is trimmed), nil will be returned.
	/// Will retreive from spell DB otherwise.
	@discardableResult public func retrieveSpell(name: String) async -> Spell? {
		let n = name.trimmingCharacters(in: .whitespacesAndNewlines)
		if n.isEmpty { return nil }
		
		if let s = spells[n] { return s }
		
		guard let data = await spellDB.getSpellObject(spell: name) else {
			return nil
		}
		
		spells[n] = data
		
		return data
	}
	
	/// Retrieve spell object if it exists. Call retrieveSpell() if you want to retrieve its metadata from the database.
	public func getSpell(name: String) -> Spell? {
		let n = name.trimmingCharacters(in: .whitespacesAndNewlines)
		
		return spells[n]
	}
	
	
	/// Memory release.
	public func purgeAllSpells() {
		spells.removeAll()
	}
}
