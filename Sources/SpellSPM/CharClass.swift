//
//  CharClass.swift
//  Spell_Editor
//
//  Created by tridiak on 16/01/21.
//

import Foundation

public enum CharClass : String, CaseIterable, Sendable, Comparable {
	case sorcerer = "sorcerer"
	case wizard = "wizard"
	case cleric = "cleric"
	case druid = "druid"
	case ranger = "ranger"
	case bard = "bard"
	case paladin = "paladin"
	case alchemist = "alchemist"
	case summoner = "summoner"
	case witch = "witch"
	case inquisitor = "inquisitor"
	case oracle = "oracle"
	case antipaladin = "antipaladin"
	case magus = "magus"
	case adept = "adept"
	case bloodrager = "bloodrager"
	case shaman = "shaman"
	case psychic = "psychic"
	case medium = "medium"
	case mesmerist = "mesmerist"
	case occultist = "occultist"
	case spiritualist = "spiritualist"
	case arcanist = "arcanist"
	//	case skald = "skald"
	//	case warpriest = "warpriest"
	case hunter = "hunter"
	
	public static func < (lhs: Self, rhs: Self) -> Bool {
		return lhs.rawValue < rhs.rawValue
	}
	
}

extension CharClass {
	
	public static let shortNames = ["sor", "wiz", "clr", "drd", "rgr", "brd", "pal", "alc", "smn", "wit", "inq", "orc", "apl",
		"mag", "adp", "brg", "shm", "psy", "med", "mes", "occ", "spr", "arc", "htr"]
	public static let shortToEnum : [String:CharClass] = [
		"sor" : .sorcerer,		"wiz" : .wizard,		"clr" : .cleric,		"drd" : .druid,
		"rgr" : .ranger,		"brd" : .bard,			"pal" : .paladin,		"alc" : .alchemist,
		"smn" : .summoner,		"wit" : .witch,			"inq" : .inquisitor,	"orc" : .oracle,
		"apl" : .antipaladin,	"mag" : .magus,			"adp" : .adept,			"brg" : .bloodrager,
		"shm" : .shaman,		"psy" : .psychic,		"med" : .medium,		"mes" : .mesmerist,
		"occ" : .occultist,		"spr" : .spiritualist,	"htr" : .hunter,		"arc" : .arcanist
	]
	
	
	/// Return enum from passed string. Can be full name or short name. Convenience function,
	/// - Parameter strg: Uses lowercase comparison
	/// - Returns: enum or nil if no comparison exists
	public static func from(strg: String) -> CharClass? {
		if let V = self.init(rawValue: strg.lowercased()) { return V }
		return shortToEnum[strg.lowercased()]
	}
	
	public static func shortToLong(name: String) -> String {
		if let s = shortToEnum[name.lowercased()] {
			return s.rawValue
		}
		return ""
	}
	
	public func dbName() -> String {
		return self.rawValue
	}
}
