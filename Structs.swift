//
//  Structs.swift
//

import Foundation

struct Word {
	
	var persian: String, english: String, pos: String
	init (_ persian: String, _ english: String, _ pos: String) {
		self.persian = persian
		self.english = english
		self.pos = pos
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
		self.ipa = ipa
		self.din = din
		self.english = english
		self.persian = persian
		self.isolated = isolated
		self.initial = initial
		self.medial = medial
		self.final = final
	}
	
}

struct Example {
	
	var english: String, persian: String
	init (_ english: String, _ persian: String) {
		self.english = english
		self.persian = persian
	}
	
}
