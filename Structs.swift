//
//  Structs.swift
//

import Foundation

enum PartOfSpeech: String {
	case adjective = "adjective", adverb = "adverb", conjunction = "conjunction", noun = "noun", preposition = "preposition", verb = "verb", unknown = "unknown";
	
	static func fromString(input: String) -> PartOfSpeech {
		switch input {
			case "adjective": .adjective
			case "adverb": .adverb
			case "conjunction": .conjunction
			case "noun": .noun
			case "preposition": .preposition
			case "verb": .verb
			default: .unknown
		}
	}
}

struct Example: Hashable, Identifiable {
	var id = UUID()
	var english: String, persian: String
	func matches(_ word: Word) -> Bool {
		let words = persian.components(separatedBy: " ")
		for w in words {
			if w == word.persian { return true }
		}
		return false
	}
}

// TODO: Figure out how to use correct sound without accents
struct Letter: Identifiable {
	var id = UUID()
	var english: String, persian: String, isolated: String, initial: String, medial: String, final: String, ipa: String, transliteration: String
}

// TODO: Add support for prefix and suffix
// TODO: Categories?
struct WordJSON: Codable {
	let english: String
	let persian: String
	let pos: String
	var alternate: String? = ""
	var derivative: String? = ""
}

struct Word: Hashable, Identifiable {
	var id = UUID()
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
	init (persian: String, english: String, derivative: String, alternate: String) {
		self.persian = persian
		self.pos = .verb
		self.english = english
		self.derivative = derivative
		self.alternate = alternate
	}
	
	// TODO: Deal with vowels
	static func transliterate(persian: String) -> String {
		var output = ""
		for letter in persian {
			// TODO: Handle 'nil' while unrwapping Optional value
			let l = alphabet.first(where: {$0.isolated == String(letter)})!
			output.append(l.transliteration)
		}
		return output
	}
	
	static func ==(lhs: Word, rhs: Word) -> Bool {
		if lhs.english == rhs.english && lhs.persian == rhs.persian && lhs.pos == rhs.pos { return true }
		return false
	}
}
