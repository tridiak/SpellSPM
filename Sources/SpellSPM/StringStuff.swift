//
//  StringStuff.swift
//  Swift-Utilities
//
//  Created by tridiak on 8/12/18.
//  Copyright © 2018 tridiak. All rights reserved.
//

import Foundation

extension String {
	static let CompareOptsNone = String.CompareOptions.init(rawValue: 0)
	
	/// Checks if a character contains any Unicode scalar in the given CharacterSet
		static func charInSet(_ char: Character, set: CharacterSet) -> Bool {
			return char.unicodeScalars.contains(where: set.contains)
		}

		/// Returns a new string with characters removed if they are in the given CharacterSet
		func removingCharacters(in set: CharacterSet) -> String {
			return self.filter { !String.charInSet($0, set: set) }
		}
	
	/// Mutates the string by removing characters in set.
	/// - Parameter set: Characters to remove.
	mutating func removeFromM(set: CharacterSet) {
		self = removingCharacters(in: set)
	}
	
	
	/// Remove all characters in set from string and returning a new string.
	/// Calls through to RemoveFrom(set:CharacterSet)
	/// - Parameter set: string contains characters to remove.
	/// - Returns: resultant string
	func removeFrom(set: String) -> String {
		let S = CharacterSet.init(charactersIn: set)
		
		return removingCharacters(in: S)
	}
	
	/// Mutates the string by removing characters in set.
	/// - Parameter set: string contains characters to remove.
	mutating func removeFromM(set: String) {
		self = removeFrom(set: set)
	}
	
	/// Keep all characters in set from string and returning a new string.
	/// - Parameter set: Characters to remove.
	/// - Returns: resultant string
	func keepThoseIn(set: CharacterSet) -> String {
		return self.filter { String.charInSet($0, set: set) }
	}
	
	/// Mutates the string by keeping the characters in set.
	/// - Parameter set: Characters to remove.
	mutating func KeepThoseInM(set: CharacterSet) {
		self = keepThoseIn(set: set)
	}
	
	/// Keep all characters in set from string and returning a new string.
	/// Calls through to KeepThoseIn(set:CharacterSet)
	/// - Parameter set: string contains characters to keep.
	/// - Returns: resultant string
	func keepThoseIn(set: String) -> String {
		let S = CharacterSet.init(charactersIn: set)
		
		return keepThoseIn(set: S)
	}
	
	/// Mutates the string by keeping the characters in set.
	/// - Parameter set: Characters to remove.
	mutating func KeepThoseInM(set: String) {
		self = keepThoseIn(set: set)
	}
	
	//--------------------------------
	
	func containsOnlyCharacters(in characterSet: CharacterSet) -> Bool {
		// Check if all characters in the string are contained in the characterSet
		self.unicodeScalars.allSatisfy { characterSet.contains($0) }
	}
	
	//----------------------------------
	
	/// Return a string where all characters in 'chars' are replace with 'with'.
	func replaceAll(chars: CharacterSet, with: Character) -> String {
		return String(self.map { C in
			if String.charInSet(C, set: chars) {
				return with
			}
			else {
				return C
			}
		})
	}
	
	/// Replace all characters in 'chars' with character 'with'.
	mutating func replaceAllM(chars: CharacterSet, with: Character) {
		self = replaceAll(chars: chars, with: with)
	}
	
	/// Return a string where all characters in 'chars' are replace with 'with'.
	func replaceAll(chars: String, with: Character) -> String {
		let S = CharacterSet.init(charactersIn: chars)
		
		return replaceAll(chars: S, with: with)
	}
	
	/// Replace all characters in 'chars' with character 'with'.
	mutating func ReplaceAllM(chars: String, with: Character) {
		self =  replaceAll(chars: chars, with: with)
	}
	
	//------------------------------------
	/// Count of character
	func countOf(char: Character) -> UInt {
		return UInt(self.count { C in
			return C == char
		})
	}
	
	/// Return string after last character 'char'.
	/// If character does not exist, nil will be returned.
	func stringAfterLast(char: Character) -> String? {
		guard let idx = self.range(of: String(char), options: String.CompareOptions.backwards, range: nil, locale: nil)
			else { return nil }
		
		if idx.upperBound == self.endIndex { return "" }
		
		return String( self[idx.upperBound...] )
	}
	
	/// Return string before LAST character 'char'.
	/// If character does not exist, nil will be returned.
	func stringBeforeLast(char: Character) -> String? {
		guard let idx = self.range(of: String(char), options: String.CompareOptions.backwards, range: nil, locale: nil)
			else { return nil }
		
		if idx.upperBound == self.startIndex { return "" }
		
		return String( self[..<idx.lowerBound] )
	}
	
	//----------------------------------------
	
	/// Returns a string where consecutive characters are reduced to a single character.
	/// 'AAABBCDDDEE' -> 'ABCDE'
	func reduceConsecutiveChars() -> String {
		var s : String = ""
		var lastC : Character = "\0"
		
		for c in self {
			if c != lastC {
				s.append(c)
				lastC = c
			}
		}
		
		return s
	}
	
	/// Eliminates consecutive characters.
	mutating func reduceConsecutiveCharsM() {
		self = reduceConsecutiveChars()
	}
	
	/// Returns a string where consecutive occurrences of 'char' are reduce to a single character.
	/// 'AABBCCCDDDEEEEE' char = 'D' -> 'AABBCCDEEEE'
	func reduceConsecutiveCharsOf(char: Character) -> String {
		
		var s : String = ""
		var currC : Character = "\0"
		
		for c in self {
			if c == currC && c == char { }
			else {
				s.append(c)
				currC = c
			}
		}
		
		return s
	}
	
	/// Reduce consecutive occurrences of 'char' to a single character.
	mutating func reduceConsecutiveCharsOfM(char: Character) {
		self = reduceConsecutiveCharsOf(char: char)
	}
	
	//------------------------------------
	
	/// String to ULL with magnitude suffix. Recognised suffixes: byte/KiB/MiB/GiB/TiB/PiB/KB/MB/GB/TB/PB.
	func convertSuffixedToUInt() -> UInt? {
		let line = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		if line.isEmpty { return nil }
		
		if line.countOf(char: ".") > 1  { return nil }
		
		// does not contain any suffix
		if let d = Double(line) {
			return UInt.init(exactly: d)
		}
		
		let numSet = CharacterSet.init(charactersIn: "0123456789.")
		// find last integer/DP
		guard let idx = line.rangeOfCharacter(from: numSet, options: String.CompareOptions.backwards, range: nil)
			else {
			return nil
		}
		
		let numPart = line[...idx.lowerBound]
		let sfxPart = line[idx.upperBound...].trimmingCharacters(in: CharacterSet.whitespaces)
		guard var val = Double(numPart) else { return nil }
		
		switch sfxPart {
			case "byte", "bytes": break
			case "pib": val *= 1125899906842624
			case "pb":	val *= 1000000000000000
			case "tib":	val *= 1099511627776
			case "tb":	val *= 1000000000000
			case "gib":	val *= 1073741824
			case "gb":	val *= 1000000000
			case "mib":	val *= 1048576
			case "mb":	val *= 1000000
			case "kib":	val *= 1024
			case "kb":	val *= 1000
			default: return nil
		}
		
		if val > Double(UInt.max) { return nil }
		// UInt(exactlty:) does not round
		return UInt(val)
	}
	
	/// Split string into equal count of charCount.
	/// If string count is not a multiple of charCount, nil will be returned.
	func equalSplit(charCount: UInt) -> [String]? {
		if charCount == 0 || (UInt(self.count) % charCount) != 0 { return nil }
		
		var ary : [String] = []
		var ct : UInt = 0
		var s : String = ""
		for c in self {
			s.append(c)
			ct += 1
			if ct == charCount {
				ary.append(s)
				s = ""
				ct = 0
			}
		}
		
		return ary
	}
	
	/// Returns String array of components separated by 'seperator'. But if the seperator in in-between
	/// the upMarker & downMarker, it is ignored.
	/// S = "A,B,C,[D,E,F,G],H".
	///	S.SameLevelSplit(",", "[", "]") will return ["A", "B", "C", "D,E,F,G", "H"].
	///
	/// - Parameters:
	///   - sep: Divider
	///   - up: Up or open character.
	///   - down: Down or close character.
	/// - Returns: Will return nil if up = down, up = sep, down = sep, count(up) != count(down) or "level" drops below 0.
	///	Otherwise it will return an array of components.
	func sameLevelSplit(separator sep: Character, upMarker up: Character, downMarker down: Character) -> [String]? {
		if up == down || sep == up || sep == down { return nil }
		if self.countOf(char: up) != self.countOf(char: down) { return nil }
		if self.countOf(char: up) == 0  { return self.split(separator: sep).toStringArray() }
		
		var s : String = ""
		var ary : [String] = []
		var level = 0
		for c in self {
			if c == up { level += 1 }
			else if c == down { level -= 1}
			else if c == sep && level == 0 { ary.append(s); s = "" }
			else {
				s.append(c)
			}
			
			if level < 0 { return nil }
		}
		if !s.isEmpty { ary.append(s) }
		return ary
	}
	
	/// Return two substrings before and after first occurrence of 'separator'.
	/// If marker is not found, result.before will return self and result.after will return nil.
	func beforeAndAfter(marker: String) -> (before:String,after:String?) {
		guard let idx = self.range(of: marker) else { return (self, nil) }
		
		let B = String( self[..<idx.lowerBound] )
		let A = String( self[idx.upperBound...] )
		
		return (B,A)
	}
	
	static let hexToValue : [Character:UInt] = ["0":0, "1":1, "2":2, "3":3, "4":4, "5":5, "6":6, "7":7, "8":8,
										 "9":9, "A":10, "a":10, "B":11, "b":11, "C":12, "c":12, "D":13,
										 "d":13, "E":14, "e":14, "F":15, "f":15]
	
	/// Convert hex to UInt
	func hexToUInt() -> UInt? {
		if isEmpty { return nil }
		if self.count > 16 { return nil }
		
		var V : UInt = 0
		for c in self {
			guard let v = String.hexToValue[c] else { return nil }
			V = V << 4
			V += v
		}
		
		return V
	}
	
	/// Get Nth character of string.
	func getChar(N: Int) -> Character? {
		if N < 0 || self.isEmpty { return nil }
		if N >= self.count { return nil }
		if N == 0 { return self.first! }
		
		let idx = index(startIndex, offsetBy: N - 1)
		return self[idx]
	}
	
	/// Get Nth character index.
	func getNthIndex(_ N: Int) -> String.Index? {
		if N < 0 || self.isEmpty { return nil }
		if N >= self.count { return nil }
		if N == 0 { return startIndex }
		
		return index(startIndex, offsetBy: N - 1)
	}
	
	/// Append string if self is not empty
	mutating func appendIfNotEmpty(_ S: String) {
		if !isEmpty { self.append(S) }
	}
	
	/// Passed character is removed if it is the last character in the string.
	@discardableResult mutating func removeIfLast(char: Character) -> String {
		if let C = self.last, C == char  { self.removeLast() }
		return self
	}
	
	/// Returns true if string starts with passed string
	func firstPartIs(_ S: String, options: String.CompareOptions = CompareOptsNone) -> Bool {
		return self.range(of: S, options: options, range: nil, locale: nil)?.lowerBound == self.startIndex
	}
	
	/// Returns true if string ends with passed string
	func lastPartIs(_ S: String, options: String.CompareOptions = CompareOptsNone) -> Bool {
		return self.range(of: S, options: options.union(CompareOptions.backwards), range: nil, locale: nil)?.upperBound == self.endIndex
	}
	
	/// Returns true and the element if any element in the passed String sequence is the first part of the String
	func firstPartIsOne<T: Sequence>(of S: T, options: String.CompareOptions = CompareOptsNone) -> (B:Bool, S:String?) where T.Element == String {
		for s in S {
			if firstPartIs(s, options: options) { return (true, s) }
		}
		return (false, nil)
	}
	
	/// Returns true and the element if any element in the passed String sequence is the last part of the String
	func lastPartIsOne<T: Sequence>(of S: T, options: String.CompareOptions = CompareOptsNone) -> (B:Bool, S:String?) where T.Element == String {
		for s in S {
			if lastPartIs(s, options: options) { return (true, s) }
		}
		return (false, nil)
	}
	
	/// Compares two optional strings. If both are nil, true is returned.
	/// If one is nil, false is returned. Otherwise standard string comparison.
	static func compareNil(_ s1 : String?, _ s2 : String?) -> Bool {
		if s1 == nil && s2 == nil { return true }
		if s1 == nil || s2 == nil { return false }
		return s1! == s2!
	}
	
	/// Returns first N characters of string. If self is empty, nil will be returned.
	/// If count requested is 0, an empty string will be returned.
	/// Not the most efficient method so keep the count small.
	@available(*, deprecated, message: "Use [...GetNthIndex()] instead")
	func firstNChars(count ct: UInt) -> String? {
		if count == 0 { return nil }
		if ct == 0 { return "" }
		var s = ""
		var i = UInt(0)
		for c in self {
			s.append(c)
			i += 1
			if i == ct { break }
		}
		
		return s
	}
	
	/// Return substring after '.'
	///
	/// - Returns: nil if extension(.) does not exist, otherwise (extension, everything before '.')
	func getExtension() -> (ext:String, rem:String)? {
		guard let idx = self.range(of: ".", options: String.CompareOptions.backwards, range: nil, locale: nil) else {
			return nil
		}
		
		if idx.lowerBound == self.endIndex {return ("", self)}
		let s = self[self.index(after: idx.lowerBound)...]
		return (String(s), String(self[..<idx.lowerBound]) )
	}
	
	/// Change the extension of the passed string.
	///
	/// - Parameter to: new extension. Can be empty.
	/// - Returns: String with new extension or original string if there is no extension.
	func changeExtension(to:String) -> String {
		guard let idx = self.range(of: ".", options: String.CompareOptions.backwards, range: nil, locale: nil) else {
			return self
		}
		
		let newString = self[..<idx.lowerBound] + "." + to
		return newString
	}
	
	/// Remove extension and the '.'. Searches from end of string.
	///
	/// - Returns: orignal string if no extension otherwise all characters before extension
	func dropExtension() -> String {
		guard let idx = self.range(of: ".", options: String.CompareOptions.backwards, range: nil, locale: nil) else {
			return self
		}
		
		return String(self[..<idx.lowerBound])
	}
	
	/// Escape ' (single quote) for SQL statements
	func escapeSingleQuote() -> String {
		if self.isEmpty || !self.contains("'") { return self }
		var s = ""
		for c in self {
			if c == "'" { s.append("'") }
			s.append(c)
		}
		
		return s
	}
	
	/// Find all between charA & charB. Will return nil if niether character is present. Will return an empty string if characters are adjacent.
	func inbetween(charA: Character, charB: Character) -> String? {
		guard var idx = self.firstIndex(of: charA) else { return nil }
		idx = self.index(after: idx)
		if idx >= self.endIndex { return nil }
		let ss = self[idx...]
		guard let edx = ss.firstIndex(of: charB) else { return nil }
		return String(ss[..<edx])
	}
	
	func inbetween(charA: Character, charB: Character, range: Range<String.Index>) -> String? {
		let r = self[range]
		guard var idx = r.firstIndex(of: charA) else { return nil }
		idx = self.index(after: idx)
		if idx >= self.endIndex { return nil }
		let ss = self[idx...]
		guard let edx = ss.firstIndex(of: charB) else { return nil }
		return String(ss[..<edx])
	}
	
	var isNotEmpty : Bool { return !self.isEmpty }
}



//------------------------------------------------
// MARK:- Array

extension Array where Element : StringProtocol {
	/// Returns first index and length of longest string in array.
	/// Will return nil if array is empty.
	func longestString() -> (index: UInt, length: UInt)? {
		if isEmpty { return nil }
		
		var len : UInt = 0
		var pos : UInt = 0
		
		for (idx,s) in self.enumerated() {
			if s.count > len {
				pos = UInt(idx)
				len = UInt(s.count)
			}
		}
		
		return (pos,len)
	}
	
	/// Return lowercase version of string array.
	func lowerCaseAll() -> [String] {
		return self.map({ (S) -> String in
			return S.lowercased()
		})
	}
	
	/// Return uppercase version of string array.
	func upperCaseAll() -> [String] {
		return self.map({ (S) -> String in
			return S.uppercased()
		})
	}
	
	/// Used for converting [Substring] to [String]
	func toStringArray() -> [String] {
		var ary : [String] = []
		for s in self {
			ary.append(String(s))
		}
		
		return ary
	}
	
	/// Case insensitive check.
	///
	/// - Parameter S: String to check
	/// - Returns: true if is does
	func containsCI(_ S: String) -> Bool {
		for s in self {
			if s.lowercased() == S.lowercased() { return true }
		}
		return false
	}
	
	mutating func removeIfEmpty() {
		self = self.filter { SP in
			return !SP.isEmpty
		}
	}
}


//-------------------------------------------------
// MARK:- Number

let suffix1024 = ["byte", "KiB", "MiB", "GiB", "TiB", "PiB"]
let suffix1000 = ["byte", "KB", "MB", "GB", "TB", "PB"]

extension UInt {
	
	func byteString1024() -> String {
		if self < 1024 {
			return "\(self) byte"
		}
		var v : Double = Double(self)
		var idx = 0
		
		while (v > 1024) {
			idx += 1
			v = v / 1024
			
			if idx == suffix1024.count - 1 { break }
		}
		
		return String(format: "%.2f %@", v, suffix1024[idx])
	}
	
	func byteString1000() -> String {
		if self < 1000 {
			return "\(self) byte"
		}
		var v : Double = Double(self)
		var idx = 0
		
		while (v > 1000) {
			idx += 1
			v = v / 1000
			
			if idx == suffix1000.count - 1 { break }
		}
		
		return String(format: "%.2f %@", v, suffix1000[idx])
	}
}

func AN<T: BinaryInteger>(_ v: T) -> String {
	if v >= T(0) { return "+\(v)" }
	return "\(v)"
}

func SNS<T: FixedWidthInteger>(_ num: T) -> String {
	if num > 0 { return "+\(num)"}
	return "\(num)"
}
