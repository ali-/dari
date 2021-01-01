//
//  Structs.swift
//

import Foundation

struct Word {
	
	var persian: String, english: String, pos: String
	init (_ persian: String, _ english: String, _ pos: String) {
		self.persian = persian			// Word in persian
		self.english = english			// Word in english
		self.pos = pos					// Part of speech
	}
	
	var din: String {
		let w: [String] = split
		var s: String = ""
		for l in w {
			if let a = alphabet.firstIndex(where: {$0.isolated == l}) {
				s += alphabet[a].din
			}
		}
		return s
	}
	
	var ipa: String {
		let w: [String] = split
		var s: String = ""
		for l in w {
			if let a = alphabet.firstIndex(where: {$0.isolated == l}) {
				s += alphabet[a].ipa
			}
		}
		return s
	}
	
	var split: [String] {
		var array = [String]()
		let letters = persian.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "")
		let word = letters.map{String($0)}
		for (i, letter) in letters.enumerated() {
			// Special exception for lam-alef-la
			if letter == "ل" {
				if word.count-1 > i {
					if word[i+1] == "ا" {
						array.append("لا")
						continue
					}
				}
			}
			else if letter == "ا" {
				if i != 0 {
					if word[i-1] == "ل" { continue }
				}
			}
			array.append(String(letter))
		}
		return array
	}
	
}

struct Letter {
	
	var ipa: String, english: String, persian: String, isolated: String, initial: String, medial: String, final: String, din: String
	
	init (english: String, persian: String, isolated: String, initial: String, medial: String, final: String, phonetic: String, ipa: String, din: String) {
		self.ipa = ipa					// Phonetic (IPA)
		self.din = din					// DIN 31635
		self.english = english			// Name in english
		self.persian = persian			// Name in persian
		self.isolated = isolated		// Letter isolated
		self.initial = initial			// Letter at beginning of word
		self.medial = medial			// Letter inside of word
		self.final = final				// Letter at end of word
	}
	
}

struct Example {
	
	var english: String, persian: String
	init (_ english: String, _ persian: String) {
		self.english = english			// Example in english
		self.persian = persian			// Example in persian
	}
	
}
