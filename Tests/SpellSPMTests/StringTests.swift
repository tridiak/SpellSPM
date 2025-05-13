//
//  Test.swift
//  SpellSPM
//
//  Created by tridiak on 13/05/2025.
//

import Testing
@testable import SpellSPM
import Foundation

struct Test {

    @Test func StringStuff() async throws {
		let lower = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
		
		let s = "Quick brown fox jumps over the lazy dog. 1234"
		let s2 = "Quick brown fox jumps over the lazy dog. "
		let s3 = "Q       . 1234"
		let s4 = "uickbrownfoxjumpsoverthelazydog"
		let s5 = "1234"
		let s6 = "Quick brown fox jumps over the lazy dog. XXXX"
		#expect(s.removingCharacters(in: CharacterSet.decimalDigits) == s2)
		#expect(s.removingCharacters(in: lower) == s3)
		#expect(s.keepThoseIn(set: CharacterSet.decimalDigits) == s5)
		#expect(s.keepThoseIn(set: lower) == s4)
		#expect(!s.containsOnlyCharacters(in: lower))
		#expect(s4.containsOnlyCharacters(in: lower))
		#expect(s6.replaceAll(chars: CharacterSet.decimalDigits, with: "X") == s6)
		#expect(s.countOf(char: "u") == 2)
		#expect(s.stringAfterLast(char: ".") == " 1234")
		#expect(s.stringBeforeLast(char: ".") == "Quick brown fox jumps over the lazy dog")
		
		let n = "1111222233345456777798999"
		let nred = "123454567989"
		let nred2 = "1222233345456777798999"
		
		#expect(n.reduceConsecutiveChars() == nred)
		#expect(n.reduceConsecutiveCharsOf(char: "1") == nred2)
		
		let eq = "111222333444"
		let ary = eq.equalSplit(charCount: 3)
		#expect(ary != nil)
		if let ary {
			#expect(ary.count == 4)
			#expect(ary == ["111", "222", "333", "444"])
		}
		
		let neq = "11122233344"
		#expect(neq.equalSplit(charCount: 3) == nil)
		
		let sls = "A,B,C,[D,E,F,G],H"
		let slsAry = ["A", "B", "C", "D,E,F,G", "H"]
		let sls2 = "A,B,C,[D,E,F,G,H"
		let sls3 = "A,B,C,[D,E,F,G]],H"
		
		let slsRes = sls.sameLevelSplit(separator: ",", upMarker: "[", downMarker: "]")
		#expect(slsRes != nil)
		if let slsRes {
			#expect(slsRes == slsAry)
		}
		
		#expect(sls2.sameLevelSplit(separator: ",", upMarker: "[", downMarker: "]") == nil)
		#expect(sls3.sameLevelSplit(separator: ",", upMarker: "[", downMarker: "]") == nil)
		
		#expect(sls.getChar(N: 3) == "B")
		#expect(sls.getChar(N: 1000) == nil)
		#expect(sls[sls.getNthIndex(3)!] == "B")
		#expect(sls.getNthIndex(1000) == nil)
		var slsm = sls
		slsm.removeIfLast(char: "H")
		#expect(slsm == "A,B,C,[D,E,F,G],")
		slsm = sls
		slsm.removeIfLast(char: ",")
		#expect(slsm == "A,B,C,[D,E,F,G],H")
		
		#expect(sls.firstPartIs("A,B"))
		#expect(!sls.firstPartIs("A,C"))
		#expect(!sls.firstPartIs(""))
		#expect(sls.lastPartIs("],H"))
		#expect(!sls.lastPartIs("G,H"))
		#expect(!sls.lastPartIs(""))
		
		let ary2 = ["A,", "B,", ",C"]
		#expect(sls.firstPartIsOne(of: ary2) == (true, "A,"))
		let ary3 = ["G,", "B,", ",C"]
		#expect(!sls.firstPartIsOne(of: ary3).B)
		
		let r1 : String? = nil
		let r2 : String? = nil
		let r3 : String? = "A"
		let r4 : String? = "B"
		
		#expect(String.compareNil(r1, r2))
		#expect(!String.compareNil(r1, r3))
		#expect(String.compareNil(r3, r3))
		#expect(!String.compareNil(r3, r4))
		
		let ext = "hello.txt"
		let ext2 = "hello"
		let ext3 = ".txt"
		
		var exRes = ext.getExtension()
		#expect(exRes != nil)
		if let exRes {
			#expect(exRes.ext == "txt")
			#expect(exRes.rem == "hello")
		}
		
		exRes = ext2.getExtension()
		#expect(exRes == nil)
		
		exRes = ext3.getExtension()
		#expect(exRes != nil)
		if let exRes {
			#expect(exRes.ext == "txt")
			#expect(exRes.rem == "")
		}
		
		#expect(ext.changeExtension(to: "bob") == "hello.bob")
		#expect(ext2.changeExtension(to: "bob") == "hello")
		#expect(ext3.changeExtension(to: "bob") == ".bob")
		
		#expect(ext.dropExtension() == "hello")
		#expect(ext2.dropExtension() == "hello")
		#expect(ext3.dropExtension().isEmpty)
		
		// let sls = "A,B,C,[D,E,F,G],H"
		var ib = sls.inbetween(charA: "[", charB: "]")
		#expect(ib != nil)
		if let ib {
			#expect(ib == "D,E,F,G")
		}
		
		ib = sls.inbetween(charA: "B", charB: ",")
		#expect(ib != nil)
		if let ib {
			#expect(ib.isEmpty)
		}
		
		ib = sls.inbetween(charA: "]", charB: "[")
		#expect(ib == nil)
    }

}
