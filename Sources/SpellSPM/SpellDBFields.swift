//
//  SpellDBFields.swift
//  SpellList
//
//  Created by tridiak on 28/04/21.
//

import Foundation

// spells table DB field names
public enum SpellDBFields : String, CaseIterable {
	// String
	case name = "name"
	
	// String
	case school = "school"
	
	// String?
	case subschool = "subschool"
	
	// String
	case source = "source"
	
	// String
	case theme = "theme"
	
	// Bool
	case verbal = "verbal"
	
	// Bool
	case somatic = "somatic"
	
	// Bool
	case material = "material"
	
	// Bool
	case focus = "focus"
	
	// Bool
	case divineFocus = "divine_focus"
	
	// UInt
	case goldCost = "gold_cost"
	
	// Bool
	case dismissible = "dismissible"
	
	// Bool
	case shapeable = "shapeable"
	
	// String
	case castingTime = "casting_time"
	
	// Bool
	case ctStandard = "ct_standard"
	
	// Bool
	case ctSwift = "ct_swift"
	
	// Bool
	case ctImmediate = "ct_immediate"
	
	// Bool
	case ctFree = "ct_free"
	
	// Bool
	case ctFullRound = "ct_full_round"
	
	// Bool
	case ctMinutes = "ct_minutes"
	
	// Bool
	case ctHours = "ct_hours"
	
	// UInt8?
	case sorcerer = "sorcerer"
	
	// UInt8?
	case wizard = "wizard"
	
	// UInt8?
	case cleric = "cleric"
	
	// UInt8?
	case druid = "druid"
	
	// UInt8?
	case ranger = "ranger"
	
	// UInt8?
	case bard = "bard"
	
	// UInt8?
	case paladin = "paladin"
	
	// UInt8?
	case alchemist = "alchemist"
	
	// UInt8?
	case summoner = "summoner"
	
	// UInt8?
	case witch = "witch"
	
	// UInt8?
	case inquisitor = "inquisitor"
	
	// UInt8?
	case oracle = "oracle"
	
	// UInt8?
	case antipaladin = "antipaladin"
	
	// UInt8?
	case magus = "magus"
	
	// UInt8?
	case adept = "adept"
	
	// UInt8?
	case bloodrager = "bloodrager"
	
	// UInt8?
	case shaman = "shaman"
	
	// UInt8?
	case psychic = "psychic"
	
	// UInt8?
	case medium = "medium"
	
	// UInt8?
	case mesmerist = "mesmerist"
	
	// UInt8?
	case occultist = "occultist"
	
	// UInt8?
	case spiritualist = "spiritualist"
	
	// Bool
	case acid = "acid"
	
	// Bool
	case air = "air"
	
	// Bool
	case chaotic = "chaotic"
	
	// Bool
	case cold = "cold"
	
	// Bool
	case curse = "curse"
	
	// Bool
	case darkness = "darkness"
	
	// Bool
	case death = "death"
	
	// Bool
	case disease = "disease"
	
	// Bool
	case earth = "earth"
	
	// Bool
	case electricity = "electricity"
	
	// Bool
	case emotion = "emotion"
	
	// Bool
	case evil = "evil"
	
	// Bool
	case fear = "fear"
	
	// Bool
	case fire = "fire"
	
	// Bool
	case force = "force"
	
	// Bool
	case good = "good"
	
	// Bool
	case languageDependent = "language_dependent"
	
	// Bool
	case lawful = "lawful"
	
	// Bool
	case light = "light"
	
	// Bool
	case mindAffecting = "mind_affecting"
	
	// Bool
	case pain = "pain"
	
	// Bool
	case poison = "poison"
	
	// Bool
	case shadow = "shadow"
	
	// Bool
	case sonic = "sonic"
	
	// Bool
	case water = "water"
	
	// Bool
	case mythic = "mythic"
	
	// String
	case SR = "SR"
	
	// Bool
	case srNo = "sr_no"
	
	// Bool
	case srYes = "sr_yes"
	
	// Bool
	case srHarmless = "sr_harmless"
	
	// Bool
	case srObject = "sr_object"
	
	// Bool
	case srSeeText = "sr_see_TEXT"
	
	// String
	case saves = "saves"
	
	// Bool
	case svFortNegates = "sv_fort_negates"
	
	// Bool
	case svFortPartial = "sv_fort_partial"
	
	// Bool
	case svFortHalf = "sv_fort_half"
	
	// Bool
	case svRefNegates = "sv_ref_negates"
	
	// Bool
	case svRefPartial = "sv_ref_partial"
	
	// Bool
	case svRefHalf = "sv_ref_half"
	
	// Bool
	case svWillNegates = "sv_will_negates"
	
	// Bool
	case svWillPartial = "sv_will_partial"
	
	// Bool
	case svWillHalf = "sv_will_half"
	
	// Bool
	case svWillBelief = "sv_will_belief"
	
	// String
	case duration = "duration"
	
	// Bool
	case instantaneous = "instantaneous"
	
	// Bool
	case rounds = "rounds"
	
	// Bool
	case minutes = "minutes"
	
	// Bool
	case hours = "hours"
	
	// String
	case range = "range"
	
	// Bool
	case rgePersonal = "rge_personal"
	
	// Bool
	case rgeTouch = "rge_touch"
	
	// Bool
	case rgeClose = "rge_close"
	
	// Bool
	case rgeMedium = "rge_medium"
	
	// Bool
	case rgeLong = "rge_long"
	
	// UInt
	case rgeFeet = "rge_feet"
	
	// String
	case target = "target"
	
	// Bool
	case singleTarget = "single_target"
	
	// Bool
	case targetperCL = "targetperCL"
	
	// String
	case effect = "effect"
	
	// Bool
	case emanation = "emanation"
	
	// Bool
	case burst = "burst"
	
	// Bool
	case cone = "cone"
	
	// Bool
	case spread = "spread"
	
	// Bool
	case line = "line"
	
	// Bool
	case cylinder = "cylinder"
	
	// String. Comma separated list. No spaces.
	case bloodlines = "bloodlines"
	
	// String. Comma separated list. No spaces.
	case domains = "domains"
	
	// Bool
	case briskSpell = "brisk_spell"
	
	// Bool
	case empowerSpell = "empower_spell"
	
	// Bool
	case intensifySpell = "intensify_spell"
	
	// Bool
	case umbralSpell = "umbral_spell"
	
	// Bool
	case vastSpell = "vast_spell"
	
	// Bool
	case widenSpell = "widen_spell"
	
	// Bool
	case yaiMimicSpell = "yai_mimic_spell"
	
	// Bool
	case hpDamageSpell = "hp_damage_spell"
	
	// UInt8?
	case hunter = "hunter"
	
	// UInt8?
	case arcanist = "arcanist"
}

// Removed user query support dictionaries.
