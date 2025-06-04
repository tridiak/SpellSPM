//
//  File.swift
//  SpellSPM
//
//  Created by tridiak on 08/05/2025.
//

import Foundation

public struct SpellLevel : Hashable {
	let spell : String
	let level : UInt8
}

// Implementation does not need to implement a cache.
protocol DBAccess : Actor {
	
	/// Return every spell name in the database.
	/// - Parameter force: Ignore and clear cache if true. Cache is not required for implementation.
	/// - Throws: `SpellsDBEx` if there is any database error.
	/// - Returns: All spells in the database
	func getAllNames(force: Bool) throws -> [String]
	
	/// Return spell names with passed SQL query
	/// - Parameter query: SQLite query. Assumes WHERE is prefixed. To retrieve all names, pass an empty string.
	/// - Throws: `SpellsDBEx` any database errors
	/// - Returns: Array of spell names
	func getNamesWith(query: String) throws -> [String]
	
	/// Return int value for spell. If the table column is not an int an exception will be thrown.
	/// - Parameters:
	///   - name: Spell name
	///   - field: column name
	/// - Throws: `SpellsDBEx.noSuchSpell` if spell does not exist.
	///				`SpellsDBEx.notAnInt` if column is not an integer column.
	///				`SpellsDBEx.err` for other general DB exceptions.
	/// - Returns: Int value of the spell and column. Note some coluimns are nullable, so nil can be returned.
	func getSpellIntField(name: String, field: String) throws -> Int?
	
	/// Return string value for spell. If the table column is not a string an exception will be thrown.
	/// - Parameters:
	///   - name: Spell name
	///   - field: column name
	/// - Throws: `SpellsDBEx.noSuchSpell` if spell does not exist.
	///				`SpellsDBEx.notAnString` if column is not a string column.
	///				`SpellsDBEx.err` for other general DB exceptions.
	/// - Returns: String value of the spell and column. Note some coluimns are nullable, so nil can be returned.
	func getSpellTextField(name: String, field: String) throws -> String?
	
	
	/// Return all spell names and integer values for passed column.
	/// - Parameter field: column name
	/// - Throws: `SpellsDBEx.notAnInt` if column is not an integer column.
	///				`SpellsDBEx.err` for other general DB exceptions.
	/// - Returns: Array of spell,value tuples
	func getAllIntValues(field: String) throws -> [(spell: String, value: Int?)]
	
	/// Return all spell names and string values for passed column.
	/// - Parameter field: column name
	/// - Throws: `SpellsDBEx.notAnString` if column is not a string column.
	///				`SpellsDBEx.err` for other general DB exceptions.
	/// - Returns: Array of spell,value tuples.
	func getAllTextValues(field: String) throws -> [(spell: String, text: String?)]
	
	
	/// Check if spell exists in database.
	/// - Parameter name: Name of spell
	/// - Returns: false if spell does not exist or if any exception occurred.
	func spellNameExists(name: String) -> Bool
	
	/// Return all columns of spell inside a `SpellField` struct.
	/// - Parameter spell: Name of spell
	/// - Throws: `SpellsDBEx.noSuchSpell` if spell does not exist.
	/// 			'SpellsDBEx.err' for DB exceptions.
	/// - Returns: Spell metadata
	func allFieldsFor(spell: String) throws -> SpellFields
	
	/// Returns all spells for char class for passed spell level
	/// - Parameters:
	///   - charClass: char class
	///   - level: spell level
	/// - Returns: All spells of passed spell level. If empty, then there are no spells for that level. Return nil if there is a database error.
	func allSpellsFor(charClass: CharClass, level: UInt8) -> Set<String>?
	
	
	/// Return all spells (and level) for char class.
	/// - Parameter charClass: char class
	/// - Returns: All spells for that character class. Return nil if there is a database error.
	func allSpellsFor(charClass: CharClass) -> Set<SpellLevel>?
}
