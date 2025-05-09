//
//  SpellListEx.swift
//  SpellList
//
//  Created by tridiak on 25/06/21.
//

import Foundation

enum SpellsEx : Error {
	// Bad error occurred but not fatal. App can still run.
	case unexpectedError(String)
	// Class QueryParser.ConvertToWHERE() is being excuted already
	case queryBeingExecuted
	
	// Will probably ditch this. If we cannot access the BL/Dmn in the DB, something else is wrong.
	// If true, BLs could not be loaded and all BL queries will be false.
	// If false, further attempts may work.
	case noBloodlinesEx(Bool)
	// If true, Domains could not be loaded and all Dmn queries will be false.
	// If false, further attempts may work.
	case noDomainsEx(Bool)
	
	case noSuchBloodline(String)
	case noSuchDomain(String)
	
	case missingResourceFiles
	case invalidResourcesFile
	case badFeatFile(String)
	
	case badSpellVolume(URL)
	case noVolumeLocation
	/// List of volume names.
	case volumeSaveFail([String])
	case volumeLoadFail([String])
	
	case databaseMissing
}
