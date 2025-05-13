//
//  SpellListEx.swift
//  SpellList
//
//  Created by tridiak on 25/06/21.
//

import Foundation

// This is specific to DB queries.
enum SpellsDBEx : Error, Equatable {
	case invalidResourcesFile
	case databaseMissing
	
	case err(Int, String)
	case noSuchSpell(String)
	case notAnInt
	case notAString
}
