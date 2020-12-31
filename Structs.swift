//
//  Structs.swift
//

import Foundation

struct Word {
	var persian: String, english: String, pos: String, phonetic: String
	init (_ persian: String, _ english: String, _ pos: String, _ phonetic: String) {
		self.persian = persian			// Word in persian
		self.english = english			// Word in english
		self.pos = pos					// Part of speech
		self.phonetic = phonetic		// Roman phoneticization
	}
}

struct Script {
	var phonetic: String, english: String, persian: String, isolated: String, initial: String, medial: String, final: String
	init (_ phonetic: String, _ english: String, _ persian: String, _ isolated: String, _ initial: String, _ medial: String, _ final: String) {
		self.phonetic = phonetic		// Phonetic (IPA)
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
