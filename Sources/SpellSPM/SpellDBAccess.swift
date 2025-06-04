//
//  SpellDBAccess.swift
//  SpellList
//
//  Created by tridiak on 30/04/21.
//

import Foundation
import SQLite3

public actor SpellDBAccess : DBAccess {
	
	static let spellDBTableName = "spells"
	
	/// Pass if you want to use a different SQLite DB than the built-in one. Must contain same table name and columns.
	/// Will throw SpellsEx if the file does not exist. Does not check if a valid DB file.
	public init(dbPath: String) throws {
		self.dbPath = dbPath
		
		var dir : ObjCBool = false
		if !FileManager.default.fileExists(atPath: dbPath, isDirectory: &dir) {
			throw SpellsDBEx.databaseMissing
		}
		if !dir.boolValue {
			throw SpellsDBEx.invalidResourcesFile
		}
	}
	
	/// Use built-in DB.
	public init() throws {
		guard let url = Bundle.module.url(forResource: "spellDBv3", withExtension: "db") else {
			throw SpellsDBEx.databaseMissing
		}
		dbPath = url.path()
	}
	
	fileprivate var dbPath : String
	
	
	
	fileprivate func openSpellDB(_ write: Bool = false) throws -> OpaquePointer {
		var sqPtr : OpaquePointer? = nil
		let res = sqlite3_open_v2(dbPath, &sqPtr, write ? SQLITE_OPEN_READWRITE : SQLITE_OPEN_READONLY, nil)
		if res != SQLITE_OK {
			throw SpellsDBEx.err(Int(res), String(cString: sqlite3_errstr(res)) )
		}
		
		return sqPtr!
	}
	
	
	fileprivate func prepStatement(sqPtr : OpaquePointer, stmt: String) throws -> OpaquePointer {
		var prepStmt : OpaquePointer? = nil
		// CHECK count
		let res = sqlite3_prepare_v2(sqPtr, stmt, Int32(stmt.utf8CString.count), &prepStmt, nil)
		
		if res != SQLITE_OK {
			try closeAndThrow(prepStmt: nil, sqPtr: sqPtr, res: res)
		}
		
		return prepStmt!
	}
	
	fileprivate func sqlErrorString(err: Int32) -> String {
		let s = sqlite3_errstr(err)
		return s != nil ? String(cString: s!) : String(err)
	}
	
	/// Function always throws.
	fileprivate func closeAndThrow(prepStmt: OpaquePointer?, sqPtr: OpaquePointer, res: Int32) throws {
		let s = sqlite3_errstr(res)
		sqlite3_finalize(prepStmt)
		sqlite3_close_v2(sqPtr)
		throw SpellsDBEx.err(Int(res), s != nil ? String(cString: s!) : String(res))
	}
	
	fileprivate var allSpellNames : [String] = []
	
	/// Returns a list of all spell names.
	/// - Parameter force: clear cache and force reload from database.
	/// - Throws: `SQLiteEx` any database errors
	/// - Returns: Returns list of spell names. Can throw SQLiteEx execption.
	public func getAllNames(force: Bool) throws -> [String] {
		if !allSpellNames.isEmpty && !force { return allSpellNames }
		
		allSpellNames.removeAll()
		var prepStmt : OpaquePointer!
		var sqPtr : OpaquePointer!
		do {
			sqPtr = try openSpellDB()
			
			let stmt = "SELECT name FROM spells;"
			var res : Int32 = SQLITE_OK
			prepStmt = try prepStatement(sqPtr: sqPtr, stmt: stmt)
			
			res = sqlite3_step(prepStmt)
			while res == SQLITE_ROW {
				
				guard let n = sqlite3_column_text(prepStmt, 0) else {
					res = sqlite3_errcode(sqPtr)
					break
				}
				let s = String(cString: n)
				allSpellNames.append(s)
				
				res = sqlite3_step(prepStmt)
			}
			
			if res != SQLITE_DONE {
				let s = sqlite3_errstr(res)
				
				throw SpellsDBEx.err(Int(res), s != nil ? String(cString: s!) : String(res))
			}
			
			sqlite3_finalize(prepStmt)
			sqlite3_close_v2(sqPtr)
			return allSpellNames
		}
		catch let E {
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
			
			throw E
		}
	}
	
	/// Return spell names with passed SQL query
	/// - Parameter query: SQLite query. Assumes WHERE is prefixed. To retrieve all names, pass an empty string.
	/// - Throws: `SQLiteEx` any database errors
	/// - Returns: Array of spell names
	public func getNamesWith(query: String) throws -> [String] {
		
		var prepStmt : OpaquePointer!
		var sqPtr : OpaquePointer!
		
		do {
			sqPtr = try openSpellDB()
			
			let stmt = "SELECT name FROM spells " + query
			var res : Int32 = SQLITE_OK
			prepStmt = try prepStatement(sqPtr: sqPtr, stmt: stmt)
			
			var names : [String] = []
			
			res = sqlite3_step(prepStmt)
			while res == SQLITE_ROW {
				
				guard let n = sqlite3_column_text(prepStmt, 0) else {
					res = sqlite3_errcode(sqPtr)
					break
				}
				let s = String(cString: n)
				names.append(s)
				
				res = sqlite3_step(prepStmt)
			}
			
			if res != SQLITE_DONE {
				throw SpellsDBEx.err(Int(res), sqlErrorString(err: res))
			}
			
			sqlite3_finalize(prepStmt)
			sqlite3_close_v2(sqPtr)
			return names
		}
		catch let E {
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
			
			throw E
		}
	}
	
	public func getAllIntValues(field: String) throws -> [(spell: String, value: Int?)] {
		let sqPtr : OpaquePointer! = try openSpellDB()
		
		let stmt = "SELECT name, \(field) FROM spells;"
		
		let prepStmt : OpaquePointer! = try prepStatement(sqPtr: sqPtr, stmt: stmt)
		
		defer {
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
		}
		
		var res = sqlite3_step(prepStmt)
		var ary : [(spell: String, value: Int?)] = []
		
		var i : Int? = nil
		
		while res == SQLITE_ROW {
			let typ = sqlite3_column_type(prepStmt, 1)
			if typ == SQLITE_NULL {
				i = nil
			}
			else if typ == SQLITE_INTEGER {
				i = Int(sqlite3_column_int(prepStmt, 1))
			}
			else {
				throw SpellsDBEx.notAnInt
			}
			
			if let n = sqlite3_column_text(prepStmt, 0) {
				let s = String(cString: n)
				ary.append((spell: s, value: i))
			}
			else {
				let e = sqlite3_errcode(sqPtr)
				throw SpellsDBEx.err(Int(e), sqlErrorString(err: e))
			}
			
			res = sqlite3_step(prepStmt)
		}
		
		if res != SQLITE_DONE {
			throw SpellsDBEx.err(Int(res), sqlErrorString(err: res))
		}
		
		return ary
	}
	
	public func getAllTextValues(field: String) throws -> [(spell: String, text: String?)] {
		let sqPtr : OpaquePointer! = try openSpellDB()
		
		let stmt = "SELECT name, \(field) FROM spells;"
		
		let prepStmt : OpaquePointer! = try prepStatement(sqPtr: sqPtr, stmt: stmt)
		
		defer {
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
		}
		
		var res = sqlite3_step(prepStmt)
		var ary : [(spell: String, text: String?)] = []
		
		var i : String? = nil
		
		while res == SQLITE_ROW {
			let typ = sqlite3_column_type(prepStmt, 1)
			if typ == SQLITE_NULL {
				i = nil
			}
			else if typ == SQLITE_TEXT {
				i = String(cString: sqlite3_column_text(prepStmt, 0)!)
			}
			else {
				throw SpellsDBEx.notAString
			}
			
			if let n = sqlite3_column_text(prepStmt, 0) {
				let s = String(cString: n)
				ary.append((spell: s, text: i))
			}
			else {
				let e = sqlite3_errcode(sqPtr)
				throw SpellsDBEx.err(Int(e), sqlErrorString(err: e))
			}
			
			res = sqlite3_step(prepStmt)
		}
		
		if res != SQLITE_DONE {
			throw SpellsDBEx.err(Int(res), sqlErrorString(err: res))
		}
		
		return ary
	}
	
	// Spells DB spell table columns types are either int or string. Some can be null.
	public func getSpellIntField(name: String, field: String) throws -> Int? {
		
		let sqPtr : OpaquePointer = try openSpellDB()
		// name is case-sensitive
		let stmt = "SELECT \(field) FROM spells WHERE name='\(name.escapeSingleQuote())';"
		
		let prepStmt : OpaquePointer = try prepStatement(sqPtr: sqPtr, stmt: stmt)
		
		let res = sqlite3_step(prepStmt)
		if res != SQLITE_ROW {
			try closeAndThrow(prepStmt: prepStmt, sqPtr: sqPtr, res: res)
		}
		
		var i : Int? = nil
		
		if sqlite3_column_type(prepStmt, 0) == SQLITE_INTEGER {
			i = Int(sqlite3_column_int(prepStmt, 0))
		}
		
		sqlite3_finalize(prepStmt)
		sqlite3_close_v2(sqPtr)
		
		return i
	}
	
	/// Return text value of a SQL table column.
	public func getSpellTextField(name: String, field: String) throws -> String? {
		
		let sqPtr : OpaquePointer = try openSpellDB()
		// name is case-sensitive
		let stmt = "SELECT \(field) FROM spells WHERE name='\(name.escapeSingleQuote())';"
		
		let prepStmt : OpaquePointer = try prepStatement(sqPtr: sqPtr, stmt: stmt)
		
		let res = sqlite3_step(prepStmt)
		if res != SQLITE_ROW {
			try closeAndThrow(prepStmt: prepStmt, sqPtr: sqPtr, res: res)
		}
		
		var i : String? = nil
		
		if sqlite3_column_type(prepStmt, 0) == SQLITE_TEXT {
			i = String(cString:sqlite3_column_text(prepStmt, 0))
		}
		
		sqlite3_finalize(prepStmt)
		sqlite3_close_v2(sqPtr)
		
		return i
	}
	
	public func spellNameExists(name: String) -> Bool {
		//if allSpellNames.contains(name) { return true }
		
		let sqPtr : OpaquePointer! = try? openSpellDB()
		if sqPtr == nil { return false }
		// name is case-sensitive
		let stmt = "SELECT name FROM spells WHERE name='\(name.escapeSingleQuote())';"
		
		let prepStmt : OpaquePointer! = try? prepStatement(sqPtr: sqPtr, stmt: stmt)
		if prepStmt == nil {
			sqlite3_close_v2(sqPtr)
			return false
		}
		
		let res = sqlite3_step(prepStmt)
		
		sqlite3_finalize(prepStmt)
		sqlite3_close_v2(sqPtr)
		
		if res == SQLITE_ROW {
			allSpellNames.append(name)
			return true
		}
		return false
	}
	
	//--------------------------------------
	// MARK: - non-protocol
	
	fileprivate var bloodLines : Set<String>? = nil
	
	public func getAllBloodlines() throws -> Set<String> {
		if bloodLines != nil { return bloodLines! }
		
		let d = try getAllTextValues(field: "bloodlines")
		bloodLines = Set(d.map { (spell: String, text: String?) in
			return text ?? ""
		}.filter { S in
			return !S.isEmpty
		})
		
		return bloodLines!
	}
	
	//--------------------------------------
	// MARK: - non-protocol
	
	fileprivate var domains : Set<String>? = nil
	
	public func getAllDomains() throws -> Set<String> {
		if domains != nil { return domains! }
		
		let d = try getAllTextValues(field: "domains")
		domains = Set( d.map({ (spell: String, text: String?) in
			return text ?? ""
		}).filter({ S in
			return !S.isEmpty
		})  )
		
		return domains!
	}
	
	//--------------------------------------
	// MARK: -
	
	fileprivate var spellFields : [String:SpellFields] = [:]
	
	public func allFieldsFor(spell: String) throws -> SpellFields {
		if let s = spellFields[spell] { return s }
		
		var sf = SpellFields()
		var sqPtr : OpaquePointer! = nil
		var prepStmt : OpaquePointer! = nil
		
		do {
			sqPtr = try openSpellDB()
			// name is case-sensitive
			let spl = spell.escapeSingleQuote()
			let stmt = "SELECT * FROM spells WHERE name LIKE '\(spl)';"
			
			prepStmt = try prepStatement(sqPtr: sqPtr, stmt: stmt)
			//
			
			let res = sqlite3_step(prepStmt)
			
			if res == SQLITE_ROW {
				for i in 0...117 {
					if sqlite3_column_type(prepStmt, Int32(i)) == SQLITE_TEXT {
						let s = String(cString:sqlite3_column_text(prepStmt, Int32(i)))
						sf[i] = s
					}
					else if sqlite3_column_type(prepStmt, Int32(i)) == SQLITE_INTEGER {
						let v = Int(sqlite3_column_int(prepStmt, Int32(i)))
						sf[i] = v
					}
					else if sqlite3_column_type(prepStmt, Int32(i)) == SQLITE_NULL {
						sf[i] = nil
					}
					else {
						print("Warning! Unexpected column type at \(i) - \(sqlite3_column_type(prepStmt, Int32(i)))")
					}
				}
			}
			else {
				throw SpellsDBEx.noSuchSpell(spell)
			}
			
			//
			sqlite3_finalize(prepStmt)
			sqlite3_close_v2(sqPtr)
			
			spellFields[spell] = sf
			return sf
		}
		catch  let E {
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
			throw E
		}
		
	}
	
	public func getSpellObject(spell: String) -> Spell? {
		guard let data = try? allFieldsFor(spell: spell) else {
			return nil
		}
		
		return Spell(name: spell, data: data)
	}
	
	
	//--------------------------------------
	// MARK: - non-protocol
	
	fileprivate var spellsForLevel : [UInt8:Set<String>] = [:]
	
	public func allSpellsFor(level: UInt8) -> Set<String>? {
		if let s = spellsForLevel[level] { return s }
		
		var sqPtr : OpaquePointer! = nil
		var prepStmt : OpaquePointer! = nil
		
		do {
			var names = Set<String>()
			sqPtr = try openSpellDB()
			// name is case-sensitive
			let stmt = "SELECT name FROM spells WHERE (sorcerer = \(level) OR wizard = \(level) OR cleric = \(level) OR druid = \(level) OR ranger = \(level) OR bard = \(level) OR paladin = \(level) OR alchemist = \(level) OR summoner = \(level) OR witch = \(level) OR inquisitor = \(level) OR oracle = \(level) OR antipaladin = \(level) OR magus = \(level) OR adept = \(level) OR bloodrager = \(level) OR shaman = \(level) OR psychic = \(level) OR medium = \(level) OR mesmerist = \(level) OR occultist = \(level) OR spiritualist = \(level));"
			
			prepStmt = try prepStatement(sqPtr: sqPtr, stmt: stmt)
			//
			
			var res = sqlite3_step(prepStmt)
			
			while res == SQLITE_ROW {
				
				guard let n = sqlite3_column_text(prepStmt, 0) else {
					res = sqlite3_errcode(sqPtr)
					break
				}
				
				let s = String(cString: n)
				names.insert(s)
				
				res = sqlite3_step(prepStmt)
			}
			
			//
			sqlite3_finalize(prepStmt)
			sqlite3_close_v2(sqPtr)
			
			spellsForLevel[level] = names
			return names
		}
		catch  let E {
			print(E)
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
			return nil
		}
	}
	
	//--------------------------------------
	// MARK: - non-protocol
	static let names = [SpellDBFields.sorcerer.rawValue,
						SpellDBFields.wizard.rawValue,
						SpellDBFields.cleric.rawValue,
						SpellDBFields.druid.rawValue,
						SpellDBFields.ranger.rawValue,
						SpellDBFields.bard.rawValue,
						SpellDBFields.paladin.rawValue,
						SpellDBFields.alchemist.rawValue,
						SpellDBFields.summoner.rawValue,
						SpellDBFields.witch.rawValue,
						SpellDBFields.inquisitor.rawValue,
						SpellDBFields.oracle.rawValue,
						SpellDBFields.antipaladin.rawValue,
						SpellDBFields.magus.rawValue,
						SpellDBFields.adept.rawValue,
						SpellDBFields.bloodrager.rawValue,
						SpellDBFields.shaman.rawValue,
						SpellDBFields.psychic.rawValue,
						SpellDBFields.medium.rawValue,
						SpellDBFields.mesmerist.rawValue,
						SpellDBFields.occultist.rawValue,
						SpellDBFields.spiritualist.rawValue
		   ]
	fileprivate var levelForSpellCache : [String:UInt8] = [:]
	
	/// Returns spell level of spell determined by a specific class order. SpLike ability rules.
	public func levelForSpell(spell: String) -> UInt8? {
		var sqPtr : OpaquePointer! = nil
		var prepStmt : OpaquePointer! = nil
		if let l = levelForSpellCache[spell] { return l }
		do {
			
			var idx = 0
			var lvl : UInt8? = nil
			while idx < SpellDBAccess.names.count {
				
				sqPtr = try openSpellDB()
				// name is case-sensitive
				let stmt = "SELECT \(SpellDBAccess.names[idx]) FROM spells WHERE name = '\(spell.escapeSingleQuote())';"
				
				prepStmt = try prepStatement(sqPtr: sqPtr, stmt: stmt)
				//
				
				let res = sqlite3_step(prepStmt)
				
				if res == SQLITE_ROW {
					if sqlite3_column_type(prepStmt, 0) == SQLITE_INTEGER {
						lvl = UInt8(sqlite3_column_int(prepStmt, 0))
						break
					}
				}
				
				sqlite3_reset(prepStmt)
				idx += 1
			}
			
			//
			sqlite3_finalize(prepStmt)
			sqlite3_close_v2(sqPtr)
			
			levelForSpellCache[spell] = lvl
			return lvl
		}
		catch  let E {
			print(E)
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
			return nil
		}
	}
	
	// non-protocol
	// Key is class name + spell name
	fileprivate var levelForSpellClass : [String:UInt8] = [:]
	
	/// Returns spell level of spell for a specific class order. exists indicate if the spell itself exists.
	public func levelForSpell(spell: String, forClass: CharClass) -> (lvl: UInt8?, exists: Bool) {
		let clsLevel = forClass.rawValue + " " + spell
		var sqPtr : OpaquePointer! = nil
		var prepStmt : OpaquePointer! = nil
		if let l = levelForSpellClass[clsLevel] { return (l, true) }
		do {
			let names = [forClass.rawValue]
			var idx = 0
			var lvl : UInt8? = nil
			while idx < names.count {
				
				sqPtr = try openSpellDB()
				// name is case-sensitive
				let stmt = "SELECT \(names[idx]) FROM spells WHERE name = '\(spell.escapeSingleQuote())';"
				
				prepStmt = try prepStatement(sqPtr: sqPtr, stmt: stmt)
				//
				
				let res = sqlite3_step(prepStmt)
				
				if res == SQLITE_ROW {
					if sqlite3_column_type(prepStmt, 0) == SQLITE_INTEGER {
						lvl = UInt8(sqlite3_column_int(prepStmt, 0))
						break
					}
				}
				else {
					return (nil, false)
				}
				
				sqlite3_reset(prepStmt)
				idx += 1
			}
			
			//
			sqlite3_finalize(prepStmt)
			sqlite3_close_v2(sqPtr)
			
			levelForSpellClass[clsLevel] = lvl
			return (lvl, true)
		}
		catch  let E {
			print(E)
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
			return (nil, false)
		}
	}
	
	//--------------------------------------
	// MARK: -
	fileprivate struct CCLevel : Hashable {
		let cc : CharClass
		let lvl : UInt8
	}
	fileprivate var spellsForCC : [CCLevel : Set<String>] = [:]
	
	public func allSpellsFor(charClass: CharClass, level: UInt8) -> Set<String>? {
		if let s = spellsForCC[CCLevel(cc: charClass, lvl: level)] { return s }
		
		var sqPtr : OpaquePointer! = nil
		var prepStmt : OpaquePointer! = nil
		
		do {
			var names = Set<String>()
			sqPtr = try openSpellDB()
			// name is case-sensitive
			let stmt = "SELECT name FROM spells WHERE \(charClass.dbName()) = \(level);"
			
			prepStmt = try prepStatement(sqPtr: sqPtr, stmt: stmt)
			//
			
			var res = sqlite3_step(prepStmt)
			
			while res == SQLITE_ROW {
				
				guard let n = sqlite3_column_text(prepStmt, 0) else {
					res = sqlite3_errcode(sqPtr)
					break
				}
				
				let s = String(cString: n)
				names.insert(s)
				
				res = sqlite3_step(prepStmt)
			}
			
			//
			sqlite3_finalize(prepStmt)
			sqlite3_close_v2(sqPtr)
			
			spellsForCC[CCLevel(cc: charClass, lvl: level)] = names
			return names
		}
		catch  let E {
			print(E)
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
			return nil
		}
	}
	
	private var charClassSpells : [CharClass : Set<SpellLevel>] = [:]
	
	public func allSpellsFor(charClass: CharClass) -> Set<SpellLevel>? {
		if let sl = charClassSpells[charClass] { return sl }
		var sqPtr : OpaquePointer! = nil
		var prepStmt : OpaquePointer! = nil
		
		do {
			var names = Set<SpellLevel>()
			sqPtr = try openSpellDB()
			// name is case-sensitive
			let stmt = "SELECT name, \(charClass.dbName()) FROM spells WHERE \(charClass.dbName()) IS NOT NULL;"
			
			prepStmt = try prepStatement(sqPtr: sqPtr, stmt: stmt)
			//
			
			var res = sqlite3_step(prepStmt)
			
			while res == SQLITE_ROW {
				
				guard let n = sqlite3_column_text(prepStmt, 1) else {
					res = sqlite3_errcode(sqPtr)
					break
				}
				let lvl = sqlite3_column_int(prepStmt, 0)
				let s = String(cString: n)
				let sl = SpellLevel(spell: s, level: UInt8(lvl))
				names.insert(sl)
				
				res = sqlite3_step(prepStmt)
			}
			
			//
			sqlite3_finalize(prepStmt)
			sqlite3_close_v2(sqPtr)
			
			return names
		}
		catch  let E {
			print(E)
			if prepStmt != nil { sqlite3_finalize(prepStmt) }
			if sqPtr != nil { sqlite3_close_v2(sqPtr) }
			return nil
		}
	}
	
	//--------------------------------------
	// MARK: - non-protocol
	
	public func clearCaches() {
		spellsForCC.removeAll()
		levelForSpellCache.removeAll()
		spellsForLevel.removeAll()
		spellFields.removeAll()
		domains?.removeAll()
		bloodLines?.removeAll()
		levelForSpellClass.removeAll()
		//spellsForCCLevel.removeAll()
		charClassSpells.removeAll()
	}
}
