//
//  CharClass.swift
//  Spell_Editor
//
//  Created by tridiak on 16/01/21.
//

import Foundation

enum CharClass : String, CaseIterable {
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
	case arcanist
//	case skald
//	case warpriest
	case hunter
	
	var isSorCaster : Bool {
		switch self {
			case .sorcerer:
				return true
			case .bard:
				return true
			case .summoner:
				return true
			case .inquisitor:
				return true
			case .oracle:
				return true
			case .bloodrager:
				return true
			case .psychic:
				return true
			case .medium:
				return true
			case .spiritualist:
				return true
			case .hunter:
				return true
			case .arcanist:
				return true
			default: return false
		}
	}
	
	static let shortNames = ["sor", "wiz", "clr", "drd", "rgr", "brd", "pal", "alc", "smn", "wit", "inq", "orc", "apl",
		"mag", "adp", "brg", "shm", "psy", "med", "mes", "occ", "spr", "arc", "htr"]
	static let shortToEnum : [String:CharClass] = [
		"sor" : .sorcerer,		"wiz" : .wizard,		"clr" : .cleric,		"drd" : .druid,
		"rgr" : .ranger,		"brd" : .bard,			"pal" : .paladin,		"alc" : .alchemist,
		"smn" : .summoner,		"wit" : .witch,			"inq" : .inquisitor,	"orc" : .oracle,
		"apl" : .antipaladin,	"mag" : .magus,			"adp" : .adept,			"brg" : .bloodrager,
		"shm" : .shaman,		"psy" : .psychic,		"med" : .medium,		"mes" : .mesmerist,
		"occ" : .occultist,		"spr" : .spiritualist,	"htr" : .hunter,		"arc" : .arcanist
	]
	
	static func from(strg: String) -> CharClass? {
		if let V = self.init(rawValue: strg.lowercased()) { return V }
		return shortToEnum[strg.lowercased()]
	}
	
	static func shortToLong(name: String) -> String {
		if let s = shortToEnum[name.lowercased()] {
			return s.rawValue
		}
		return ""
	}
	
	func DBName() -> String {
		return self.rawValue
	}
}

/*
// 1st index is level 0
// 0 implies possible spells if primary stat is high enough
bard [
nil	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,3  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,3  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,4  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,4  	,3  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,4  	,3  	,1  	,nil	,nil	,nil	,nil	,nil	,nil
nil	,4  	,4  	,2  	,nil	,nil	,nil	,nil	,nil	,nil
nil	,5  	,4  	,3  	,nil	,nil	,nil	,nil	,nil	,nil
nil	,5  	,4  	,3  	,1  	,nil	,nil	,nil	,nil	,nil
nil	,5  	,4  	,4  	,2  	,nil	,nil	,nil	,nil	,nil
nil	,5  	,5  	,4  	,3  	,nil	,nil	,nil	,nil	,nil
nil	,5  	,5  	,4  	,3  	,1  	,nil	,nil	,nil	,nil
nil	,5  	,5  	,4  	,4  	,2  	,nil	,nil	,nil	,nil
nil	,5  	,5  	,4  	,4  	,3  	,nil	,nil	,nil	,nil
nil	,5  	,5  	,5  	,4  	,3  	,1  	,nil	,nil	,nil
nil	,5  	,5  	,5  	,4  	,4  	,2  	,nil	,nil	,nil
nil	,5  	,5  	,5  	,5  	,4  	,3  	,nil	,nil	,nil
nil	,5  	,5  	,5  	,5  	,5  	,4  	,nil	,nil	,nil
nil	,5  	,5  	,5  	,5  	,5  	,5  	,nil	,nil	,nil
]

bardKnown [
4  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
4  	,3  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
6  	,4  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
6  	,4  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
6  	,4  	,3  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
6  	,5  	,4  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
6  	,5  	,4  	,2  	,nil	,nil	,nil	,nil	,nil	,nil
6  	,5  	,4  	,3  	,nil	,nil	,nil	,nil	,nil	,nil
6  	,5  	,5  	,4  	,nil	,nil	,nil	,nil	,nil	,nil
6  	,5  	,5  	,4  	,2  	,nil	,nil	,nil	,nil	,nil
6  	,6  	,5  	,4  	,3  	,nil	,nil	,nil	,nil	,nil
6  	,6  	,5  	,5  	,4  	,nil	,nil	,nil	,nil	,nil
6  	,6  	,6  	,5  	,4  	,2  	,nil	,nil	,nil	,nil
6  	,6  	,6  	,5  	,4  	,3  	,nil	,nil	,nil	,nil
6  	,6  	,6  	,5  	,4  	,4  	,nil	,nil	,nil	,nil
6  	,6  	,6  	,6  	,5  	,4  	,2  	,nil	,nil	,nil
6  	,6  	,6  	,6  	,5  	,4  	,3  	,nil	,nil	,nil
6  	,6  	,6  	,6  	,5  	,5  	,4  	,nil	,nil	,nil
6  	,6  	,6  	,6  	,5  	,5  	,4  	,nil	,nil	,nil
6  	,6  	,6  	,6  	,6  	,5  	,5  	,nil	,nil	,nil
]

cleric [
3  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
4  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
4  	,2  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
4  	,3  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
4  	,3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil	,nil
4  	,3  	,3  	,2  	,nil	,nil	,nil	,nil	,nil	,nil
4  	,4  	,3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil
4  	,4  	,3  	,3  	,2  	,nil	,nil	,nil	,nil	,nil
4  	,4  	,4  	,3  	,2  	,1  	,nil	,nil	,nil	,nil
4  	,4  	,4  	,3  	,3  	,2  	,nil	,nil	,nil	,nil
4  	,4  	,4  	,4  	,3  	,2  	,1  	,nil	,nil	,nil
4  	,4  	,4  	,4  	,3  	,3  	,2  	,nil	,nil	,nil
4  	,4  	,4  	,4  	,4  	,3  	,2  	,1  	,nil	,nil
4  	,4  	,4  	,4  	,4  	,3  	,3  	,2  	,nil	,nil
4  	,4  	,4  	,4  	,4  	,4  	,3  	,2  	,1  	,nil
4  	,4  	,4  	,4  	,4  	,4  	,3  	,3  	,2  	,nil
4  	,4  	,4  	,4  	,4  	,4  	,4  	,3  	,2  	,1
4  	,4  	,4  	,4  	,4  	,4  	,4  	,3  	,3  	,2
4  	,4  	,4  	,4  	,4  	,4  	,4  	,4  	,3  	,3
4  	,4  	,4  	,4  	,4  	,4  	,4  	,4  	,4  	,4
]

druid = cleric

paladin [
nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,0  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,1  	,0  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,1  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,2  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,2  	,1  	,0  	,nil	,nil	,nil	,nil	,nil	,nil
nil	,2  	,1  	,1  	,nil	,nil	,nil	,nil	,nil	,nil
nil	,2  	,1  	,1  	,nil	,nil	,nil	,nil	,nil	,nil
nil	,3  	,2  	,1  	,0  	,nil	,nil	,nil	,nil	,nil
nil	,3  	,2  	,1  	,1  	,nil	,nil	,nil	,nil	,nil
nil	,3  	,2  	,2  	,1  	,nil	,nil	,nil	,nil	,nil
nil	,3  	,3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil
nil	,4  	,3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil
nil	,4  	,3  	,2  	,2  	,nil	,nil	,nil	,nil	,nil
nil	,4  	,3  	,3  	,2  	,nil	,nil	,nil	,nil	,nil
nil	,4  	,4  	,3  	,3  	,nil	,nil	,nil	,nil	,nil
]

ranger = paladin

sorcerer [
nil	,3  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,4  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,5  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,6  	,3  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,6  	,4  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
nil	,6  	,5  	,3  	,nil	,nil	,nil	,nil	,nil	,nil
nil	,6  	,6  	,4  	,nil	,nil	,nil	,nil	,nil	,nil
nil	,6  	,6  	,5  	,3  	,nil	,nil	,nil	,nil	,nil
nil	,6  	,6  	,6  	,4  	,nil	,nil	,nil	,nil	,nil
nil	,6  	,6  	,6  	,5  	,3  	,nil	,nil	,nil	,nil
nil	,6  	,6  	,6  	,6  	,4  	,nil	,nil	,nil	,nil
nil	,6  	,6  	,6  	,6  	,5  	,3  	,nil	,nil	,nil
nil	,6  	,6  	,6  	,6  	,6  	,4  	,nil	,nil	,nil
nil	,6  	,6  	,6  	,6  	,6  	,6  	,3  	,nil	,nil
nil	,6  	,6  	,6  	,6  	,6  	,6  	,4  	,nil	,nil
nil	,6  	,6  	,6  	,6  	,6  	,6  	,5  	,3  	,nil
nil	,6  	,6  	,6  	,6  	,6  	,6  	,6  	,4  	,nil
nil	,6  	,6  	,6  	,6  	,6  	,6  	,6  	,5  	,3
nil	,6  	,6  	,6  	,6  	,6  	,6  	,6  	,6  	,4
nil	,6  	,6  	,6  	,6  	,6  	,6  	,6  	,6  	,6
]

sorcererKnown [
4  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
5  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
5  	,3  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
6  	,3  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
6  	,4  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
7  	,4  	,2  	,1  	,nil	,nil	,nil	,nil	,nil	,nil
8  	,5  	,3  	,2  	,nil	,nil	,nil	,nil	,nil	,nil
8  	,5  	,3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil
9  	,5  	,4  	,3  	,2  	,nil	,nil	,nil	,nil	,nil
9  	,5  	,4  	,3  	,2  	,1  	,nil	,nil	,nil	,nil
9  	,5  	,5  	,4  	,3  	,2  	,nil	,nil	,nil	,nil
9  	,5  	,5  	,4  	,3  	,2  	,1  	,nil	,nil	,nil
9  	,5  	,5  	,4  	,4  	,3  	,2  	,nil	,nil	,nil
9  	,5  	,5  	,4  	,4  	,3  	,2  	,1  	,nil	,nil
9  	,5  	,5  	,4  	,4  	,4  	,3  	,2  	,nil	,nil
9  	,5  	,5  	,4  	,4  	,4  	,3  	,2  	,1  	,nil
9  	,5  	,5  	,4  	,4  	,4  	,3  	,3  	,2  	,nil
9  	,5  	,5  	,4  	,4  	,4  	,3  	,3  	,2  	,1
9  	,5  	,5  	,4  	,4  	,4  	,3  	,3  	,3  	,2
9  	,5  	,5  	,4  	,4  	,4  	,3  	,3  	,3  	,3
]

wizard = cleric

adept [
3  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
3  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
3  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil	,nil
3  	,2  	,0  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
3  	,3  	,2  	,nil	,nil	,nil	,nil	,nil	,nil	,nil
3  	,3  	,2  	,0  	,nil	,nil	,nil	,nil	,nil	,nil
3  	,3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil	,nil
3  	,3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil	,nil
3  	,3  	,3  	,2  	,nil	,nil	,nil	,nil	,nil	,nil
3  	,3  	,3  	,2  	,0  	,nil	,nil	,nil	,nil	,nil
3  	,3  	,3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil
3  	,3  	,3  	,2  	,1  	,nil	,nil	,nil	,nil	,nil
3  	,3  	,3  	,3  	,2  	,nil	,nil	,nil	,nil	,nil
3  	,3  	,3  	,3  	,2  	,0  	,nil	,nil	,nil	,nil
3  	,3  	,3  	,3  	,2  	,1  	,nil	,nil	,nil	,nil
3  	,3  	,3  	,3  	,2  	,1  	,nil	,nil	,nil	,nil
3  	,3  	,3  	,3  	,3  	,2  	,nil	,nil	,nil	,nil
3  	,3  	,3  	,3  	,3  	,2  	,nil	,nil	,nil	,nil
]



*/
