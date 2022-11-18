//
//  Structs.swift
//

enum PartOfSpeech: String {
	case adjective = "adjective", adverb = "adverb", conjunction = "conjunction", noun = "noun", preposition = "preposition", verb = "verb";
}

struct Example {
	var english: String, persian: String
	func matches(_ word: Word) -> Bool {
		let words = persian.components(separatedBy: " ")
		for w in words {
			if w == word.persian { return true }
		}
		return false
	}
}

struct Letter {
	var english: String, persian: String, isolated: String, initial: String, medial: String, final: String, ipa: String
}

// TODO: Add support for prefix and suffix
struct Word {
	var english, persian: String, pos: PartOfSpeech
	// Verb specific
	var derivative: String = "", alternate = ""
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
	
	// Default
	init (persian: String, pos: PartOfSpeech, english: String) {
		self.english = english
		self.persian = persian
		self.pos = pos
	}
	
	// Verb
	init (persian: String, pos: PartOfSpeech, english: String, derivative: String, alternate: String) {
		self.persian = persian
		self.pos = pos
		self.english = english
		self.derivative = derivative
		self.alternate = alternate
	}
}

// Dictionary Layout
// 
//
//
