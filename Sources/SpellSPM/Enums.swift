//
//  File.swift
//  SpellSPM
//
//  Created by tridiak on 07/05/2025.
//

import Foundation

public enum SpellSchools : String, CaseIterable, Sendable {
	case abj
	case cnj
	case div
	case enc
	case evo
	case ill
	case nec
	case trn
	case unv
	//case user
	
	public static func from(string: String) -> SpellSchools? {
		switch string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased() {
			case "abj", "abjuration": return .abj
			case "cnj", "conjuration": return .cnj
			case "div", "divination": return .div
			case "enc", "enchantment": return .enc
			case "evo", "evocation": return .evo
			case "ill", "illusion": return .ill
			case "nec", "necromantic", "necromancy": return .nec
			case "trn", "transmutation": return .trn
			case "unv", "universal": return .unv
			default: return nil
		}
	}
	
	/// Int value returned from database can be passed here
	public static func from(int: Int) -> SpellSchools? {
		let a = SpellSchools.allCases
		if int < 0 || int >= a.count { return nil }
		return a[Int(int)]
	}
	
	public func longSpelling() -> String {
		switch self {
			case .abj:
				return "abjuration"
			case .cnj:
				return "conjuration"
			case .div:
				return "divination"
			case .enc:
				return "enchantment"
			case .evo:
				return "evocation"
			case .ill:
				return "illusion"
			case .nec:
				return "necromancy"
			case .trn:
				return "transmutation"
			case .unv:
				return "universal"
		}
	}
}

public enum SpellSubschool : String, CaseIterable, Sendable {
	case calling
	case charm
	case compulsion
	case creation
	case figment
	case glamour
	case healing
	case pattern
	case phantasm
	case polymorph
	case scrying
	case shadow
	case summoning
	case teleportation
	
	/// Int value returned from database can be passed here
	public static func from(int: Int?) -> SpellSubschool? {
		guard let int else { return nil }
		switch int {
			case 0: return .calling
			case 1: return .charm
			case 2: return .compulsion
			case 3: return .creation
			case 4: return .figment
			case 5: return .glamour
			case 6: return .healing
				// Historical reasons. Too much effort to refactor everything
			case 7: return nil
			case 8: return .pattern
			case 9: return .phantasm
			case 10: return .polymorph
			case 11: return .scrying
			case 12: return .shadow
			case 13: return .summoning
			case 14: return .teleportation
			default: return nil
		}
	}
	
}

public enum SpellComponents : String {
	case V = "verbal"
	case S = "somatic"
	case M = "material"
	case F = "focus"
	case DF = "divine focus"
}

public enum SpellCastingTime {
	case standard
	case swift
	case immediate
	case free
	case fullRound
	case minutes
	case hours
	case other
}

public enum SpellDescriptors {
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
}

public enum SpellRange {
	case personal
	case touch
	case close
	case medium
	case long
	case feet(UInt)
}
