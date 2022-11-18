//
//  dariApp.swift
//

import SwiftUI

@main
struct dariApp: App {
	init() {
		loadAlphabet()
		loadDictionary()
		loadExamples()
	}
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

func loadAlphabet() {
	alphabet.append(Letter(english: "alef", persian: "الف", isolated: "ا", initial: "ا", medial: "ـا", final: "ـا", ipa: "ɒ"))
	alphabet.append(Letter(english: "be", persian: "به", isolated: "ب", initial: "بـ", medial: "ـبـ", final: "ـب", ipa: "b"))
	alphabet.append(Letter(english: "pe", persian: "په", isolated: "پ", initial: "پـ", medial: "ـپـ", final: "ـپ", ipa: "p"))
	alphabet.append(Letter(english: "te", persian: "ته", isolated: "ت", initial: "تـ", medial: "ـتـ", final: "ـت", ipa: "t"))
	alphabet.append(Letter(english: "s̱e", persian: "ثه", isolated: "ث", initial: "ثـ", medial: "ـثـ", final: "ـث", ipa: "s"))
	alphabet.append(Letter(english: "jim", persian: "جیم", isolated: "ج", initial: "جـ", medial: "ـجـ", final: "ـج", ipa: "d͡ʒ"))
	alphabet.append(Letter(english: "che", persian: "چه", isolated: "چ", initial: "چـ", medial: "ـچـ", final: "ـچ", ipa: "t͡ʃ"))
	alphabet.append(Letter(english: "ḥe", persian: "حه", isolated: "ح", initial: "حـ", medial: "ـحـ", final: "ـح", ipa: "h"))
	alphabet.append(Letter(english: "khe", persian: "خه", isolated: "خ", initial: "خـ", medial: "ـخـ", final: "ـخ", ipa: "x"))
	alphabet.append(Letter(english: "dâl", persian: "دال", isolated: "د", initial: "د", medial: "ـد", final: "ـد", ipa: "d"))
	alphabet.append(Letter(english: "ẕâl", persian: "ذال", isolated: "ذ", initial: "ذ", medial: "ـذ", final: "ـذ", ipa: "z"))
	alphabet.append(Letter(english: "re", persian: "ره", isolated: "ر", initial: "ر", medial: "ـر", final: "ـر", ipa: "ɾ"))
	alphabet.append(Letter(english: "ze", persian: "زه", isolated: "ز", initial: "ز", medial: "ـز", final: "ـز", ipa: "z"))
	alphabet.append(Letter(english: "že", persian: "ژه", isolated: "ژ", initial: "ژ", medial: "ـژ", final: "ـژ", ipa: "ʒ"))
	alphabet.append(Letter(english: "sin", persian: "سین", isolated: "س", initial: "سـ", medial: "ـسـ", final: "ـس", ipa: "s"))
	alphabet.append(Letter(english: "šin", persian: "شین", isolated: "ش", initial: "شـ", medial: "ـشـ", final: "ـش", ipa: "ʃ"))
	alphabet.append(Letter(english: "ṣäd", persian: "صاد", isolated: "ص", initial: "صـ", medial: "ـصـ", final: "ـص", ipa: "s"))
	alphabet.append(Letter(english: "zâd", persian: "ضاد", isolated: "ض", initial: "ضـ", medial: "ـضـ", final: "ـض", ipa: "z"))
	alphabet.append(Letter(english: "toy", persian: "طی، طا", isolated: "ط", initial: "طـ", medial: "ـطـ", final: "ـط", ipa: "t"))
	alphabet.append(Letter(english: "ẓoy", persian: "ظی، ظا", isolated: "ظ", initial: "ظـ", medial: "ـظـ", final: "ـظ", ipa: "z"))
	alphabet.append(Letter(english: "ayn", persian: "عین", isolated: "ع", initial: "عـ", medial: "ـعـ", final: "ـع", ipa: "æ"))
	alphabet.append(Letter(english: "ġayn", persian: "غین", isolated: "غ", initial: "غـ", medial: "ـغـ", final: "ـغ", ipa: "ɣ"))
	alphabet.append(Letter(english: "fe", persian: "فه", isolated: "ف", initial: "فـ", medial: "ـفـ", final: "ـف", ipa: "f"))
	alphabet.append(Letter(english: "q̈âf", persian: "قاف", isolated: "ق", initial: "قـ", medial: "ـقـ", final: "ـق", ipa: "ɣ"))
	alphabet.append(Letter(english: "kâf", persian: "کاف", isolated: "ک", initial: "کـ", medial: "ـکـ", final: "ـک", ipa: "k"))
	alphabet.append(Letter(english: "gâf", persian: "گاف", isolated: "گ", initial: "گـ", medial: "ـگـ", final: "ـگ", ipa: "ɡ"))
	alphabet.append(Letter(english: "lâm", persian: "لام", isolated: "ل", initial: "لـ", medial: "ـلـ", final: "ـل", ipa: "l"))
	alphabet.append(Letter(english: "mim", persian: "میم", isolated: "م", initial: "مـ", medial: "ـمـ", final: "ـم", ipa: "m"))
	alphabet.append(Letter(english: "nun", persian: "نون", isolated: "ن", initial: "نـ", medial: "ـنـ", final: "ـن", ipa: "n"))
	alphabet.append(Letter(english: "vâv", persian: "واو", isolated: "و", initial: "و", medial: "ـو", final: "ـو", ipa: "oː"))
	alphabet.append(Letter(english: "hā-ye do-češm", persian: "هه", isolated: "ه", initial: "هـ", medial: "ـهـ", final: "ـه", ipa: "h"))
	alphabet.append(Letter(english: "ya", persian: "یه", isolated: "ی", initial: "یـ", medial: "ـیـ", final: "ـی", ipa: "eː"))
	alphabet.append(Letter(english: "hamzah", persian: "همزه", isolated: "ء", initial: "", medial: "", final: "", ipa: "ʔ"))
	alphabet.append(Letter(english: "hamzah alef", persian: "همزه", isolated: "أ", initial: "أ", medial: "ـأ", final: "ـأ", ipa: "ʔ"))
	alphabet.append(Letter(english: "hamzah", persian: "همزه", isolated: "ئ", initial: "ئـ", medial: "ـئـ", final: "ـئ", ipa: "ʔ"))
	alphabet.append(Letter(english: "hamzah", persian: "همزه", isolated: "ؤ", initial: "ؤ", medial: "ـؤ", final: "ـؤ", ipa: "ʔ"))
	alphabet.append(Letter(english: "alef madde", persian: "", isolated: "آ", initial: "آ", medial: "", final: "ـآ", ipa: "ɒ"))
	alphabet.append(Letter(english: "he ye", persian: "", isolated: "ۀ", initial: "", medial: "", final: "ـۀ", ipa: "eje"))
	alphabet.append(Letter(english: "lām alef", persian: "", isolated: "لا", initial: "", medial: "", final: "ـلا", ipa: "lɒ"))
}

func loadDictionary() {
	// TODO: Replace with loading from JSON file
	//dictionary.append(Word(english: "did", persian: "", pos: .noun))
	dictionary.append(Word(persian: "کرد", pos: .verb, english: "did", derivative: "کن", alternate: "do"))
	dictionary.append(Word(persian: "خرید", pos: .verb, english: "bought", derivative: "خر", alternate: "buy"))
	dictionary.append(Word(persian: "حیوان", pos: .noun, english: "animal"))
	dictionary.append(Word(persian: "علی", pos: .noun, english: "ali"))
	dictionary.append(Word(persian: "قندهار", pos: .noun, english: "Kandahar"))
}

func loadExamples() {
	examples.append(Example(english: "ali is the best", persian: "علی بهترین است"))
}

extension StringProtocol {
	subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}
}
