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
		let words = persian.withoutDiacritics.components(separatedBy: " ")
		for w in words {
			if w == word.persian.withoutDiacritics { return true }
		}
		return false
	}
}

struct Letter: Identifiable {
	var id = UUID()
	var english: String, persian: String, isolated: String, initial: String, medial: String, final: String, ipa: String, transliteration: String
}

// TODO: Implement categories
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
		let letters = persian.withoutDiacritics.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "")
		for letter in letters {
			if letter == "\u{0622}" {
				array.append("\u{0627}")
				continue
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
	
	static func transliterate(persian: String) -> String {
		let input = persian.map{$0}
		var output = ""
		for letter in input {
			let array = Array(letter.unicodeScalars)
			if let l = alphabet.first(where: {$0.isolated == String(array[0])}) {
				output.append(l.transliteration)
				if array.count > 1 {
					switch array[1] {
						case "\u{064E}": // Zabar (ـَ)
							output.append("a")
						case "\u{064F}": // Pesh (ـُ)
							output.append("o")
						case "\u{0650}": // Zer (ـِ)
							output.append("i")
						case "\u{0651}": // Tashdid (ـّ)
							output.append(l.transliteration)
						case "\u{0652}": // Sukun (ـْ)
							continue
						default:
							output.append("X")
					}
				}
			}
			else {
				if letter == "\u{0622}" { // Alef-madde
					output.append("aa")
				}
			}
		}
		return output
	}
	
	static func ==(lhs: Word, rhs: Word) -> Bool {
		if lhs.english == rhs.english && lhs.persian == rhs.persian && lhs.pos == rhs.pos { return true }
		return false
	}
}
