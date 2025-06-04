//
//  SpellsTableStruct.swift
//  SpellList
//
//  Created by tridiak on 5/07/21.
//

import Foundation

public struct SpellFields : Sendable {
	public var name : String = ""
	public var school : Int = 0
	public var subschool : Int? = nil
	public var source: String? = nil
	public var theme : String? = nil // NYI
	public var verbal : Bool = false
	public var somatic : Bool = false
	public var material : Bool = false
	public var focus : Bool = false
	public var divFocus : Bool = false
	public var cost : Int = 0
	public var dismissible : Bool = false
	public var shapeable : Bool = false
	public var ct : String? = nil
	public var ct_std : Bool = false
	public var ct_swf : Bool = false
	public var ct_immed : Bool = false
	public var ct_free : Bool = false
	public var ct_fullRd : Bool = false
	public var ct_min : Bool = false
	public var ct_hours : Bool = false
	public var sor : UInt8? = nil
	public var wiz : UInt8? = nil
	public var clr : UInt8? = nil
	public var drd : UInt8? = nil
	public var rgr : UInt8? = nil
	public var brd : UInt8? = nil
	public var pal : UInt8? = nil
	public var alc : UInt8? = nil
	public var smn : UInt8? = nil
	public var wit : UInt8? = nil
	public var inq : UInt8? = nil
	public var ora : UInt8? = nil
	public var apal : UInt8? = nil
	public var mag : UInt8? = nil
	public var adp : UInt8? = nil
	public var brg : UInt8? = nil
	public var shm : UInt8? = nil
	public var psy : UInt8? = nil
	public var med : UInt8? = nil
	public var mes : UInt8? = nil
	public var occ : UInt8? = nil
	public var spi : UInt8? = nil
	public var acid : Bool = false
	public var air : Bool = false
	public var chaotic : Bool = false
	public var cold : Bool = false
	public var curse : Bool = false
	public var darkness : Bool = false
	public var death : Bool = false
	public var disease : Bool = false
	public var earth : Bool = false
	public var electricity : Bool = false
	public var emotion : Bool = false
	public var evil : Bool = false
	public var fear : Bool = false
	public var fire : Bool = false
	public var force : Bool = false
	public var good : Bool = false
	public var language_dependent : Bool = false
	public var lawful : Bool = false
	public var light : Bool = false
	public var mind_affecting : Bool = false
	public var pain : Bool = false
	public var poison : Bool = false
	public var shadow : Bool = false
	public var sonic : Bool = false
	public var water : Bool = false
	public var mythic : Bool = false
	public var SR : String? = nil
	public var sr_no : Bool = false
	public var sr_yes : Bool = false
	public var sr_harmless : Bool = false
	public var sr_object : Bool = false
	public var sr_text : Bool = false
	public var saves : String? = nil
	public var fortNeg : Bool = false
	public var fortPart : Bool = false
	public var fortHalf : Bool = false
	public var refNeg : Bool = false
	public var refPart : Bool = false
	public var refHalf : Bool = false
	public var willNeg : Bool = false
	public var willPart : Bool = false
	public var willHalf : Bool = false
	public var willDis : Bool = false
	public var duration : String? = nil
	public var dur_instan : Bool = false
	public var dur_rds : Bool = false
	public var dur_mins : Bool = false
	public var dur_hours : Bool = false
	public var range : String? = nil
	public var rge_self : Bool = false
	public var rge_tch : Bool = false
	public var rge_close : Bool = false
	public var rge_med : Bool = false
	public var rge_long : Bool = false
	public var rge_feet : Int = 0
	public var target : String? = nil
	public var sglTarget : Bool = false
	public var targetPerCL : Bool = false
	public var effect : String? = nil
	public var emanation : Bool = false
	public var burst : Bool = false
	public var cone : Bool = false
	public var spread : Bool = false
	public var line : Bool = false
	public var cylinder : Bool = false
	public var bloodlines : String? = nil
	public var domains : String? = nil
	public var brisk : Bool = false
	public var empower : Bool = false
	public var intensify : Bool = false
	public var umbral : Bool = false
	public var vast : Bool = false
	public var widen : Bool = false
	public var yai : Bool = false
	public var hp_dmg : Bool = false
	
	static let classIndex = 21
	static let descIndex = 43
	
	/// String properties ct, SR, duration, range are ignored
	public static func == (lhs: SpellFields, rhs: SpellFields) -> Bool {
		return lhs.name == rhs.name &&
			lhs.school == rhs.school &&
			lhs.subschool == rhs.subschool &&
			lhs.source == rhs.source &&
			lhs.theme == rhs.theme &&
			lhs.verbal == rhs.verbal &&
			lhs.somatic == rhs.somatic &&
			lhs.material == rhs.material &&
			lhs.focus == rhs.focus &&
			lhs.divFocus == rhs.divFocus &&
			lhs.cost == rhs.cost &&
			lhs.dismissible == rhs.dismissible &&
			lhs.shapeable == rhs.shapeable &&
			//lhs.ct == rhs.ct &&
			lhs.ct_std == rhs.ct_std &&
			lhs.ct_swf == rhs.ct_swf &&
			lhs.ct_immed == rhs.ct_immed &&
			lhs.ct_free == rhs.ct_free &&
			lhs.ct_fullRd == rhs.ct_fullRd &&
			lhs.ct_min == rhs.ct_min &&
			lhs.ct_hours == rhs.ct_hours &&
			lhs.sor == rhs.sor &&
			lhs.wiz == rhs.wiz &&
			lhs.clr == rhs.clr &&
			lhs.drd == rhs.drd &&
			lhs.rgr == rhs.rgr &&
			lhs.brd == rhs.brd &&
			lhs.pal == rhs.pal &&
			lhs.alc == rhs.alc &&
			lhs.smn == rhs.smn &&
			lhs.wit == rhs.wit &&
			lhs.inq == rhs.inq &&
			lhs.ora == rhs.ora &&
			lhs.apal == rhs.apal &&
			lhs.mag == rhs.mag &&
			lhs.adp == rhs.adp &&
			lhs.brg == rhs.brg &&
			lhs.shm == rhs.shm &&
			lhs.psy == rhs.psy &&
			lhs.med == rhs.med &&
			lhs.mes == rhs.mes &&
			lhs.occ == rhs.occ &&
			lhs.spi == rhs.spi &&
			lhs.acid == rhs.acid &&
			lhs.air == rhs.air &&
			lhs.chaotic == rhs.chaotic &&
			lhs.cold == rhs.cold &&
			lhs.curse == rhs.curse &&
			lhs.darkness == rhs.darkness &&
			lhs.death == rhs.death &&
			lhs.disease == rhs.disease &&
			lhs.earth == rhs.earth &&
			lhs.electricity == rhs.electricity &&
			lhs.emotion == rhs.emotion &&
			lhs.evil == rhs.evil &&
			lhs.fear == rhs.fear &&
			lhs.fire == rhs.fire &&
			lhs.force == rhs.force &&
			lhs.good == rhs.good &&
			lhs.language_dependent == rhs.language_dependent &&
			lhs.lawful == rhs.lawful &&
			lhs.light == rhs.light &&
			lhs.mind_affecting == rhs.mind_affecting &&
			lhs.pain == rhs.pain &&
			lhs.poison == rhs.poison &&
			lhs.shadow == rhs.shadow &&
			lhs.sonic == rhs.sonic &&
			lhs.water == rhs.water &&
			lhs.mythic == rhs.mythic &&
			//lhs.SR == rhs.SR &&
			lhs.sr_no == rhs.sr_no &&
			lhs.sr_yes == rhs.sr_yes &&
			lhs.sr_harmless == rhs.sr_harmless &&
			lhs.sr_object == rhs.sr_object &&
			lhs.sr_text == rhs.sr_text &&
			//lhs.saves == rhs.saves &&
			lhs.fortNeg == rhs.fortNeg &&
			lhs.fortPart == rhs.fortPart &&
			lhs.fortHalf == rhs.fortHalf &&
			lhs.refNeg == rhs.refNeg &&
			lhs.refPart == rhs.refPart &&
			lhs.refHalf == rhs.refHalf &&
			lhs.willNeg == rhs.willNeg &&
			lhs.willPart == rhs.willPart &&
			lhs.willHalf == rhs.willHalf &&
			lhs.willDis == rhs.willDis &&
			//lhs.duration == rhs.duration &&
			lhs.dur_instan == rhs.dur_instan &&
			lhs.dur_rds == rhs.dur_rds &&
			lhs.dur_mins == rhs.dur_mins &&
			lhs.dur_hours == rhs.dur_hours &&
			//lhs.range == rhs.range &&
			lhs.rge_self == rhs.rge_self &&
			lhs.rge_tch == rhs.rge_tch &&
			lhs.rge_close == rhs.rge_close &&
			lhs.rge_med == rhs.rge_med &&
			lhs.rge_long == rhs.rge_long &&
			lhs.rge_feet == rhs.rge_feet &&
			lhs.target == rhs.target &&
			lhs.sglTarget == rhs.sglTarget &&
			lhs.targetPerCL == rhs.targetPerCL &&
			lhs.effect == rhs.effect &&
			lhs.emanation == rhs.emanation &&
			lhs.burst == rhs.burst &&
			lhs.cone == rhs.cone &&
			lhs.spread == rhs.spread &&
			lhs.line == rhs.line &&
			lhs.cylinder == rhs.cylinder &&
			lhs.bloodlines == rhs.bloodlines &&
			lhs.domains == rhs.domains &&
			lhs.brisk == rhs.brisk &&
			lhs.empower == rhs.empower &&
			lhs.intensify == rhs.intensify &&
			lhs.umbral == rhs.umbral &&
			lhs.vast == rhs.vast &&
			lhs.widen == rhs.widen &&
			lhs.yai == rhs.yai &&
			lhs.hp_dmg == rhs.hp_dmg
	}
	
	public subscript(idx: Int) -> Any? {
		get {
			switch idx {
				case  0: return name
				case  1: return school
				case  2: return subschool
				case  3: return source
				case  4: return theme
				case  5: return verbal
				case  6: return somatic
				case  7: return material
				case  8: return focus
				case  9: return divFocus
				case  10: return cost
				case  11: return dismissible
				case  12: return shapeable
				case  13: return ct
				case  14: return ct_std
				case  15: return ct_swf
				case  16: return ct_immed
				case  17: return ct_free
				case  18: return ct_fullRd
				case  19: return ct_min
				case  20: return ct_hours
				case  21: return sor
				case  22: return wiz
				case  23: return clr
				case  24: return drd
				case  25: return rgr
				case  26: return brd
				case  27: return pal
				case  28: return alc
				case  29: return smn
				case  30: return wit
				case  31: return inq
				case  32: return ora
				case  33: return apal
				case  34: return mag
				case  35: return adp
				case  36: return brg
				case  37: return shm
				case  38: return psy
				case  39: return med
				case  40: return mes
				case  41: return occ
				case  42: return spi
				case  43: return acid
				case  44: return air
				case  45: return chaotic
				case  46: return cold
				case  47: return curse
				case  48: return darkness
				case  49: return death
				case  50: return disease
				case  51: return earth
				case  52: return electricity
				case  53: return emotion
				case  54: return evil
				case  55: return fear
				case  56: return fire
				case  57: return force
				case  58: return good
				case  59: return language_dependent
				case  60: return lawful
				case  61: return light
				case  62: return mind_affecting
				case  63: return pain
				case  64: return poison
				case  65: return shadow
				case  66: return sonic
				case  67: return water
				case  68: return mythic
				case  69: return SR
				case  70: return sr_no
				case  71: return sr_yes
				case  72: return sr_harmless
				case  73: return sr_object
				case  74: return sr_text
				case  75: return saves
				case  76: return fortNeg
				case  77: return fortPart
				case  78: return fortHalf
				case  79: return refNeg
				case  80: return refPart
				case  81: return refHalf
				case  82: return willNeg
				case  83: return willPart
				case  84: return willHalf
				case  85: return willDis
				case  86: return duration
				case  87: return dur_instan
				case  88: return dur_rds
				case  89: return dur_mins
				case  90: return dur_hours
				case  91: return range
				case  92: return rge_self
				case  93: return rge_tch
				case  94: return rge_close
				case  95: return rge_med
				case  96: return rge_long
				case  97: return rge_feet
				case  98: return target
				case  99: return sglTarget
				case  100: return targetPerCL
				case  101: return effect
				case  102: return emanation
				case  103: return burst
				case  104: return cone
				case  105: return spread
				case  106: return line
				case  107: return cylinder
				case  108: return bloodlines
				case  109: return domains
				case  110: return brisk
				case  111: return empower
				case  112: return intensify
				case  113: return umbral
				case  114: return vast
				case  115: return widen
				case  116: return yai
				case  117: return hp_dmg
				default: return nil
			}
		
		}
		set(V) {
			switch idx {
				case 0: name = V as! String
				case 1: school = V as! Int
				case 2: subschool = V as? Int
				case 3: source = V as? String
				case 4: theme = V as? String
				case 5: verbal = (V as! Int) == 1
				case 6: somatic = (V as! Int) == 1
				case 7: material = (V as! Int) == 1
				case 8: focus = (V as! Int) == 1
				case 9: divFocus = (V as! Int) == 1
				case 10: cost = V as! Int
				case 11: dismissible = (V as! Int) == 1
				case 12: shapeable = (V as! Int) == 1
				case 13: ct = V as! String?
				case 14: ct_std = (V as! Int) == 1
				case 15: ct_swf = (V as! Int) == 1
				case 16: ct_immed = (V as! Int) == 1
				case 17: ct_free = (V as! Int) == 1
				case 18: ct_fullRd = (V as! Int) == 1
				case 19: ct_min = (V as! Int) == 1
				case 20: ct_hours = (V as! Int) == 1
				case 21: sor = V == nil ? nil : UInt8(V as! Int)
				case 22: wiz = V == nil ? nil : UInt8(V as! Int)
				case 23: clr = V == nil ? nil : UInt8(V as! Int)
				case 24: drd = V == nil ? nil : UInt8(V as! Int)
				case 25: rgr = V == nil ? nil : UInt8(V as! Int)
				case 26: brd = V == nil ? nil : UInt8(V as! Int)
				case 27: pal = V == nil ? nil : UInt8(V as! Int)
				case 28: alc = V == nil ? nil : UInt8(V as! Int)
				case 29: smn = V == nil ? nil : UInt8(V as! Int)
				case 30: wit = V == nil ? nil : UInt8(V as! Int)
				case 31: inq = V == nil ? nil : UInt8(V as! Int)
				case 32: ora = V == nil ? nil : UInt8(V as! Int)
				case 33: apal = V == nil ? nil : UInt8(V as! Int)
				case 34: mag = V == nil ? nil : UInt8(V as! Int)
				case 35: adp = V == nil ? nil : UInt8(V as! Int)
				case 36: brg = V == nil ? nil : UInt8(V as! Int)
				case 37: shm = V == nil ? nil : UInt8(V as! Int)
				case 38: psy = V == nil ? nil : UInt8(V as! Int)
				case 39: med = V == nil ? nil : UInt8(V as! Int)
				case 40: mes = V == nil ? nil : UInt8(V as! Int)
				case 41: occ = V == nil ? nil : UInt8(V as! Int)
				case 42: spi = V == nil ? nil : UInt8(V as! Int)
				case 43: acid = (V as! Int) == 1
				case 44: air = (V as! Int) == 1
				case 45: chaotic = (V as! Int) == 1
				case 46: cold = (V as! Int) == 1
				case 47: curse = (V as! Int) == 1
				case 48: darkness = (V as! Int) == 1
				case 49: death = (V as! Int) == 1
				case 50: disease = (V as! Int) == 1
				case 51: earth = (V as! Int) == 1
				case 52: electricity = (V as! Int) == 1
				case 53: emotion = (V as! Int) == 1
				case 54: evil = (V as! Int) == 1
				case 55: fear = (V as! Int) == 1
				case 56: fire = (V as! Int) == 1
				case 57: force = (V as! Int) == 1
				case 58: good = (V as! Int) == 1
				case 59: language_dependent = (V as! Int) == 1
				case 60: lawful = (V as! Int) == 1
				case 61: light = (V as! Int) == 1
				case 62: mind_affecting = (V as! Int) == 1
				case 63: pain = (V as! Int) == 1
				case 64: poison = (V as! Int) == 1
				case 65: shadow = (V as! Int) == 1
				case 66: sonic = (V as! Int) == 1
				case 67: water = (V as! Int) == 1
				case 68: mythic = (V as! Int) == 1
				case 69: SR = V as! String?
				case 70: sr_no = (V as! Int) == 1
				case 71: sr_yes = (V as! Int) == 1
				case 72: sr_harmless = (V as! Int) == 1
				case 73: sr_object = (V as! Int) == 1
				case 74: sr_text = (V as! Int) == 1
				case 75: saves = V as! String?
				case 76: fortNeg = (V as! Int) == 1
				case 77: fortPart = (V as! Int) == 1
				case 78: fortHalf = (V as! Int) == 1
				case 79: refNeg = (V as! Int) == 1
				case 80: refPart = (V as! Int) == 1
				case 81: refHalf = (V as! Int) == 1
				case 82: willNeg = (V as! Int) == 1
				case 83: willPart = (V as! Int) == 1
				case 84: willHalf = (V as! Int) == 1
				case 85: willDis = (V as! Int) == 1
				case 86: duration = V as? String
				case 87: dur_instan = (V as! Int) == 1
				case 88: dur_rds = (V as! Int) == 1
				case 89: dur_mins = (V as! Int) == 1
				case 90: dur_hours = (V as! Int) == 1
				case 91: range = V as? String
				case 92: rge_self = (V as! Int) == 1
				case 93: rge_tch = (V as! Int) == 1
				case 94: rge_close = (V as! Int) == 1
				case 95: rge_med = (V as! Int) == 1
				case 96: rge_long = (V as! Int) == 1
				case 97: rge_feet = V as! Int
				case 98: target = V as? String
				case 99: sglTarget = (V as! Int) == 1
				case 100: targetPerCL = (V as! Int) == 1
				case 101: effect = V as! String?
				case 102: emanation = (V as! Int) == 1
				case 103: burst = (V as! Int) == 1
				case 104: cone = (V as! Int) == 1
				case 105: spread = (V as! Int) == 1
				case 106: line = (V as! Int) == 1
				case 107: cylinder = (V as! Int) == 1
				case 108: bloodlines = V as? String
				case 109: domains = V as! String?
				case 110: brisk = (V as! Int) == 1
				case 111: empower = (V as! Int) == 1
				case 112: intensify = (V as! Int) == 1
				case 113: umbral = (V as! Int) == 1
				case 114: vast = (V as! Int) == 1
				case 115: widen = (V as! Int) == 1
				case 116: yai = (V as! Int) == 1
				case 117: hp_dmg = (V as! Int) == 1
				default: break
			}
		}
	}
	
	public subscript(field: SpellDBFields) -> Any? {
		get {
			return switch field {
				case .name:
					name
				case .school:
					school
				case .subschool:
					subschool
				case .source:
					source
				case .theme:
					theme
				case .verbal:
					verbal
				case .somatic:
					somatic
				case .material:
					material
				case .focus:
					focus
				case .divineFocus:
					divFocus
				case .goldCost:
					cost
				case .dismissible:
					dismissible
				case .shapeable:
					shapeable
				case .castingTime:
					ct
				case .ctStandard:
					ct_std
				case .ctSwift:
					ct_swf
				case .ctImmediate:
					ct_immed
				case .ctFree:
					ct_free
				case .ctFullRound:
					ct_fullRd
				case .ctMinutes:
					ct_min
				case .ctHours:
					ct_hours
				case .sorcerer:
					sor
				case .wizard:
					wiz
				case .cleric:
					clr
				case .druid:
					drd
				case .ranger:
					rgr
				case .bard:
					brd
				case .paladin:
					pal
				case .alchemist:
					alc
				case .summoner:
					smn
				case .witch:
					wit
				case .inquisitor:
					inq
				case .oracle:
					ora
				case .antipaladin:
					apal
				case .magus:
					mag
				case .adept:
					adp
				case .bloodrager:
					brg
				case .shaman:
					shm
				case .psychic:
					psy
				case .medium:
					med
				case .mesmerist:
					mes
				case .occultist:
					occ
				case .spiritualist:
					spi
				case .acid:
					acid
				case .air:
					air
				case .chaotic:
					chaotic
				case .cold:
					cold
				case .curse:
					curse
				case .darkness:
					darkness
				case .death:
					death
				case .disease:
					disease
				case .earth:
					earth
				case .electricity:
					electricity
				case .emotion:
					emotion
				case .evil:
					evil
				case .fear:
					fear
				case .fire:
					fire
				case .force:
					force
				case .good:
					good
				case .languageDependent:
					language_dependent
				case .lawful:
					lawful
				case .light:
					light
				case .mindAffecting:
					mind_affecting
				case .pain:
					pain
				case .poison:
					poison
				case .shadow:
					shadow
				case .sonic:
					sonic
				case .water:
					water
				case .mythic:
					mythic
				case .SR:
					SR
				case .srNo:
					sr_no
				case .srYes:
					sr_yes
				case .srHarmless:
					sr_harmless
				case .srObject:
					sr_object
				case .srSeeText:
					sr_text
				case .saves:
					saves
				case .svFortNegates:
					fortNeg
				case .svFortPartial:
					fortPart
				case .svFortHalf:
					fortHalf
				case .svRefNegates:
					refNeg
				case .svRefPartial:
					refPart
				case .svRefHalf:
					refHalf
				case .svWillNegates:
					willNeg
				case .svWillPartial:
					willPart
				case .svWillHalf:
					willHalf
				case .svWillBelief:
					willDis
				case .duration:
					duration
				case .instantaneous:
					dur_instan
				case .rounds:
					dur_rds
				case .minutes:
					dur_mins
				case .hours:
					dur_hours
				case .range:
					range
				case .rgePersonal:
					rge_self
				case .rgeTouch:
					rge_tch
				case .rgeClose:
					rge_close
				case .rgeMedium:
					rge_med
				case .rgeLong:
					rge_long
				case .rgeFeet:
					rge_feet
				case .target:
					target
				case .singleTarget:
					sglTarget
				case .targetperCL:
					targetPerCL
				case .effect:
					effect
				case .emanation:
					emanation
				case .burst:
					burst
				case .cone:
					cone
				case .spread:
					spread
				case .line:
					line
				case .cylinder:
					cylinder
				case .bloodlines:
					bloodlines
				case .domains:
					domains
				case .briskSpell:
					brisk
				case .empowerSpell:
					empower
				case .intensifySpell:
					intensify
				case .umbralSpell:
					umbral
				case .vastSpell:
					vast
				case .widenSpell:
					widen
				case .yaiMimicSpell:
					yai
				case .hpDamageSpell:
					hp_dmg
				case .hunter:
					nil
				case .arcanist:
					nil
			}
		}
	}
} // 118


extension SpellFields {
	public var sorcerer : UInt8? { return sor }
	public var wizard : UInt8? { return wiz }
	public var cleric : UInt8? { return clr }
	public var druid : UInt8? { return drd }
	public var ranger : UInt8? { return rgr }
	public var bard : UInt8? { return brd }
	public var paladin : UInt8? { return pal }
	public var alchemist : UInt8? { return alc }
	public var summoner : UInt8? { return smn }
	public var witch : UInt8? { return wit }
	public var inquisitor : UInt8? { return inq }
	public var oracle : UInt8? { return ora }
	public var antiPaladin : UInt8? { return apal }
	public var magus : UInt8? { return mag }
	public var adept : UInt8? { return adp }
	public var bloodrager : UInt8? { return brg }
	public var shaman : UInt8? { return shm }
	public var psychic : UInt8? { return psy }
	public var medium : UInt8? { return med }
	public var mesmerist : UInt8? { return mes }
	public var occultist : UInt8? { return occ }
	public var spiritualist : UInt8? { return spi }
}
