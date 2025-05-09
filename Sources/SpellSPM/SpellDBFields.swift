//
//  SpellDBFields.swift
//  SpellList
//
//  Created by tridiak on 28/04/21.
//

import Foundation

// spells table DB field names
enum SpellDBFields : String, CaseIterable {
	case name
	case school
	case subschool
	case source
	case theme
	case verbal
	case somatic
	case material
	case focus
	case divine_focus
	case gold_cost
	case dismissible
	case shapeable
	case casting_time
	case ct_standard
	case ct_swift
	case ct_immediate
	case ct_free
	case ct_full_round
	case ct_minutes
	case ct_hours
	case sorcerer
	case wizard
	case cleric
	case druid
	case ranger
	case bard
	case paladin
	case alchemist
	case summoner
	case witch
	case inquisitor
	case oracle
	case antipaladin
	case magus
	case adept
	case bloodrager
	case shaman
	case psychic
	case medium
	case mesmerist
	case occultist
	case spiritualist
	case acid
	case air
	case chaotic
	case cold
	case curse
	case darkness
	case death
	case disease
	case earth
	case electricity
	case emotion
	case evil
	case fear
	case fire
	case force
	case good
	case language_dependent
	case lawful
	case light
	case mind_affecting
	case pain
	case poison
	case shadow
	case sonic
	case water
	case mythic
	case SR
	case sr_no
	case sr_yes
	case sr_harmless
	case sr_object
	case sr_see_TEXT
	case saves
	case sv_fort_negates
	case sv_fort_partial
	case sv_fort_half
	case sv_ref_negates
	case sv_ref_partial
	case sv_ref_half
	case sv_will_negates
	case sv_will_partial
	case sv_will_half
	case sv_will_belief
	case duration
	case instantaneous
	case rounds
	case minutes
	case hours
	case range
	case rge_personal
	case rge_touch
	case rge_close
	case rge_medium
	case rge_long
	case rge_feet
	case target
	case single_target
	case targetperCL
	case effect
	case emanation
	case burst
	case cone
	case spread
	case line
	case cylinder
	case bloodlines
	case domains
	case brisk_spell
	case empower_spell
	case intensify_spell
	case umbral_spell
	case vast_spell
	case widen_spell
	case yai_mimic_spell
	case hp_damage_spell
}

/*
Alternate spelling special cases
--------------------------------
save has fort = (is sv_fort_negates OR is sv_fort_partial OR is sv_fort_half)
save has reflex = (is sv_ref_negates OR is sv_ref_partial OR is sv_ref_half)
save has will = (is sv_will_negates OR is sv_will_partial OR is sv_will_half OR is sv_will_belief)

These require the related field for context
	minutes,mins,minute,min = ct_minutes (casting time) OR minutes (duration)
	hours, hour, hrs, hr = ct_hours (CT) OR hours (duration)
*/

let altSpellings : [String:SpellDBFields] = [
	"mat" : .material,
	"gold cost" : SpellDBFields.gold_cost,
	"gp" : .gold_cost,
	"casting time" : .casting_time,
	"ct" : .casting_time,
	"standard action" : .ct_standard,
	"standard_action" : .ct_standard,
	"std act" : .ct_standard,
	"swift" : .ct_swift,
	"swift action" : .ct_swift,
	"swift_action" : .ct_swift,
	"immed" : .ct_immediate,
	"immediate" : .ct_immediate,
	"immediate action" : .ct_immediate,
	"free" : .ct_free,
	"free action" : .ct_free,
	"full round" : .ct_full_round,
	"full rd" : .ct_full_round,
	//**************
	// Special case
	"ct minutes" : .ct_minutes,
	"ct minute" : .ct_minutes,
	"ct min" : .ct_minutes,
	"ct mins" : .ct_minutes,
	"ct hours" : .ct_hours,
	"ct hour" : .ct_hours,
	"ct hrs" : .ct_hours,
	"ct hr" : .ct_hours,
	
	"sor" : .sorcerer,
	"wiz" : .wizard,
	"clr" : .cleric,
	"drd" : .druid,
	"rgr" : .ranger,
	"brd" : .bard,
	"pal" : .paladin,
	"alc" : .alchemist,
	"smn" : .summoner,
	"wit" : .witch,
	"inquisitor" : .inquisitor,
	"ora" : .oracle,
	"anti-p" : .antipaladin,
	"anti-paladin" : .antipaladin,
	"anti-pal" : .antipaladin,
	"antipal" : .antipaladin,
	"mag" : .magus,
	"brg" : .bloodrager,
	"rager" : .bloodrager,
	"shm" : .shaman,
	"med" : .medium,
	"mes" : .mesmerist,
	"occ" : .occultist,
	
	"elec" : .electricity,
	"language dependent" : .language_dependent,
	"language" : .language_dependent,
	"lang" : .language_dependent,
	"mind" : .mind_affecting,
	"mind affecting" : .mind_affecting,
	
	"spell resistance" : .SR,
	"sr" : .SR,
	"no sr" : .sr_no,
	"sr no" : .sr_no,
	"yes sr" : .sr_yes,
	"sr yes" : .sr_yes,
	"harmless sr" : .sr_harmless,
	"harmless" : .sr_harmless,
	"sr see text" : .sr_see_TEXT,
	
	"fort partial" : .sv_fort_partial,
	"fort part" : .sv_fort_partial,
	"fort neg" : .sv_fort_negates,
	"fort negates" : .sv_fort_negates,
	"fort half" : .sv_fort_half,
	"reflex negates" : .sv_ref_negates,
	"ref negates" : .sv_ref_negates,
	"reflex neg" : .sv_ref_negates,
	"ref neg" : .sv_ref_negates,
	"reflex parital" : .sv_ref_partial,
	"ref partial" : .sv_ref_partial,
	"reflex part" : .sv_ref_partial,
	"ref part" : .sv_ref_partial,
	"reflex half" : .sv_ref_half,
	"ref half" : .sv_ref_half,
	"will partial" : .sv_will_partial,
	"will part" : .sv_will_partial,
	"will half" : .sv_will_half,
	"will negates" : .sv_will_negates,
	"will neg" : .sv_will_negates,
	"will disbelief" : .sv_will_belief,
	
	"instan" : .instantaneous,
	"rounds" : .rounds,
	"rds" : .rounds,
	//**************
	// Special case
	"duration minutes" : .minutes,
	"duration mins" : .minutes,
	"duration minute" : .minutes,
	"duration min": .minutes,
	
	"self" : .rge_personal,
	"personal" : .rge_personal,
	"touch" : .rge_touch,
	"close" : .rge_close,
	"medium" : .rge_medium,
	"long" : .rge_long,
	"range in feet" : .rge_feet,
	"single target" : .single_target,
	"single" : .single_target,
	"target per CL" : .targetperCL,
	"target/CL" : .targetperCL,
	
	"brisk spell" : .brisk_spell,
	"empowered spell" : .empower_spell,
	"empower spell" : .empower_spell,
	"intensified spell" : .intensify_spell,
	"intensify spell" : .intensify_spell,
	"umbral spell" : .umbral_spell,
	"vast spell" : .vast_spell,
	"widened spell" : .widen_spell,
	"widen spell" : .widen_spell,
	"yai mimic spell" : .yai_mimic_spell,
	"yai-mimic spell" : .yai_mimic_spell,
	"damage dealing spell" : .hp_damage_spell,
	"hp damage spell" : .hp_damage_spell,
	"damaging spell" : .hp_damage_spell,
]

// First option: init with rawValue
// Second option: try alternate spellings conversion
// return nil otherwise
func spellDBField_StringToEnum(_ s: String) -> SpellDBFields? {
	if let db = SpellDBFields(rawValue: s) { return db }
	
	return altSpellings[s]
}

/// Returns true if the field uses 'contains'/'does not contain' prefix
func isContainsField(field: SpellDBFields) -> Bool {
	return [SpellDBFields.name, .casting_time, .SR, .saves, .duration, .range, .target, .effect].contains(field)
}

/// Returns true if the field uses 'is'/'is not' prefix. Do not confuse with 'has'/'does not have'
func isIsField(field: SpellDBFields) -> Bool {
	return [SpellDBFields.school,
		.source,			.dismissible,		.shapeable,			.ct_standard,	.ct_swift,
		.ct_immediate,		.ct_free,			.ct_full_round,		.ct_minutes,	.ct_hours,
		.sorcerer,			.wizard,			.cleric,			.druid,			.ranger,		.bard,
		.paladin,			.alchemist,			.summoner,			.witch,			.inquisitor,	.oracle,
		.antipaladin,		.magus,				.adept,				.bloodrager,	.shaman,		.psychic,
		.medium,			.mesmerist,			.occultist,			.spiritualist,	.acid,
		.air,				.chaotic,			.cold,				.curse,			.darkness,		.death,
		.disease,			.earth,				.electricity,		.emotion,		.evil,			.fear,
		.fire,				.force,				.good,				.language_dependent,			.lawful,
		.mind_affecting,	.pain,				.poison,			.shadow,		.sonic,			.water,
		.mythic,			.sv_fort_negates,	.sv_fort_partial,	.sv_fort_half,					.light,
		.sv_ref_negates,	.sv_ref_partial,	.sv_ref_half,		.sv_will_negates,
		.sv_will_partial,	.sv_will_half,		.sv_will_belief,	.instantaneous,
		.rounds,			.minutes,			.hours,				.rge_personal,	.rge_touch,
		.rge_close,			.rge_medium,		.rge_long,			.single_target,	.targetperCL,
		.emanation,			.burst,				.cone,				.spread,		.line,			.cylinder,
		.bloodlines,		.domains,			.brisk_spell,		.empower_spell,	.intensify_spell,
		.umbral_spell,		.vast_spell,		.widen_spell,		.yai_mimic_spell,		.hp_damage_spell
		].contains(field)
}

/// Returns true if the field uses 'has'/'does not have' prefix.
func isHasField(field: SpellDBFields) -> Bool {
	return [SpellDBFields.subschool,	.verbal,			.somatic,		.material,			.focus,
			.divine_focus,				.gold_cost,			.sr_no,			.sr_yes,			.sr_harmless,
			.sr_object,					.sr_see_TEXT,		.targetperCL,	.bloodlines,		.domains
		].contains(field)
}

/// Returns true if field uses the integer comparators.
func isComparatorField(field: SpellDBFields) -> Bool {
	return [SpellDBFields.gold_cost,
		.sorcerer,		.wizard,			.cleric,			.druid,			.ranger,
		.bard,			.paladin,			.alchemist,			.summoner,		.witch,
		.inquisitor,	.oracle,			.antipaladin,		.magus,			.adept,
		.bloodrager,	.shaman,			.psychic,			.medium,		.mesmerist,
		.occultist,		.spiritualist,		.rge_feet
		].contains(field)
}
