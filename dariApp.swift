//
//  dariApp.swift
//

import SwiftUI


@main struct dariApp: App {
	init() {
		loadAlphabet()
		let dictionaryLoaded = loadDictionary()
		print(dictionaryLoaded)
		loadExamples()
	}
    var body: some Scene {
        WindowGroup {
            ContentView()
				//.environment(\.layoutDirection, .rightToLeft)
				//.preferredColorScheme(.dark)
        }
    }
}


func loadAlphabet() {
	alphabet.append(Letter(english: "alef", persian: "الف", isolated: "ا", initial: "ا", medial: "ـا", final: "ـا", ipa: "ɒ", transliteration: "a"))
	alphabet.append(Letter(english: "be", persian: "به", isolated: "ب", initial: "بـ", medial: "ـبـ", final: "ـب", ipa: "b", transliteration: "b"))
	alphabet.append(Letter(english: "pe", persian: "په", isolated: "پ", initial: "پـ", medial: "ـپـ", final: "ـپ", ipa: "p", transliteration: "p"))
	alphabet.append(Letter(english: "te", persian: "ته", isolated: "ت", initial: "تـ", medial: "ـتـ", final: "ـت", ipa: "t", transliteration: "t"))
	alphabet.append(Letter(english: "s̱e", persian: "ثه", isolated: "ث", initial: "ثـ", medial: "ـثـ", final: "ـث", ipa: "s", transliteration: "s"))
	alphabet.append(Letter(english: "jim", persian: "جیم", isolated: "ج", initial: "جـ", medial: "ـجـ", final: "ـج", ipa: "d͡ʒ", transliteration: "j"))
	alphabet.append(Letter(english: "che", persian: "چه", isolated: "چ", initial: "چـ", medial: "ـچـ", final: "ـچ", ipa: "t͡ʃ", transliteration: "ch"))
	alphabet.append(Letter(english: "ḥe", persian: "حه", isolated: "ح", initial: "حـ", medial: "ـحـ", final: "ـح", ipa: "h", transliteration: "h"))
	alphabet.append(Letter(english: "khe", persian: "خه", isolated: "خ", initial: "خـ", medial: "ـخـ", final: "ـخ", ipa: "x", transliteration: "kh"))
	alphabet.append(Letter(english: "dâl", persian: "دال", isolated: "د", initial: "د", medial: "ـد", final: "ـد", ipa: "d", transliteration: "d"))
	alphabet.append(Letter(english: "ẕâl", persian: "ذال", isolated: "ذ", initial: "ذ", medial: "ـذ", final: "ـذ", ipa: "z", transliteration: "z"))
	alphabet.append(Letter(english: "re", persian: "ره", isolated: "ر", initial: "ر", medial: "ـر", final: "ـر", ipa: "ɾ", transliteration: "r"))
	alphabet.append(Letter(english: "ze", persian: "زه", isolated: "ز", initial: "ز", medial: "ـز", final: "ـز", ipa: "z", transliteration: "z"))
	alphabet.append(Letter(english: "že", persian: "ژه", isolated: "ژ", initial: "ژ", medial: "ـژ", final: "ـژ", ipa: "ʒ", transliteration: "zh"))
	alphabet.append(Letter(english: "sin", persian: "سین", isolated: "س", initial: "سـ", medial: "ـسـ", final: "ـس", ipa: "s", transliteration: "s"))
	alphabet.append(Letter(english: "šin", persian: "شین", isolated: "ش", initial: "شـ", medial: "ـشـ", final: "ـش", ipa: "ʃ", transliteration: "sh"))
	alphabet.append(Letter(english: "ṣäd", persian: "صاد", isolated: "ص", initial: "صـ", medial: "ـصـ", final: "ـص", ipa: "s", transliteration: "s"))
	alphabet.append(Letter(english: "zâd", persian: "ضاد", isolated: "ض", initial: "ضـ", medial: "ـضـ", final: "ـض", ipa: "z", transliteration: "z"))
	alphabet.append(Letter(english: "toy", persian: "طی، طا", isolated: "ط", initial: "طـ", medial: "ـطـ", final: "ـط", ipa: "t", transliteration: "t"))
	alphabet.append(Letter(english: "ẓoy", persian: "ظی، ظا", isolated: "ظ", initial: "ظـ", medial: "ـظـ", final: "ـظ", ipa: "z", transliteration: "z"))
	alphabet.append(Letter(english: "ayn", persian: "عین", isolated: "ع", initial: "عـ", medial: "ـعـ", final: "ـع", ipa: "æ", transliteration: "a"))
	alphabet.append(Letter(english: "ġayn", persian: "غین", isolated: "غ", initial: "غـ", medial: "ـغـ", final: "ـغ", ipa: "ɣ", transliteration: "gh"))
	alphabet.append(Letter(english: "fe", persian: "فه", isolated: "ف", initial: "فـ", medial: "ـفـ", final: "ـف", ipa: "f", transliteration: "f"))
	alphabet.append(Letter(english: "q̈âf", persian: "قاف", isolated: "ق", initial: "قـ", medial: "ـقـ", final: "ـق", ipa: "ɣ", transliteration: "q"))
	alphabet.append(Letter(english: "kâf", persian: "کاف", isolated: "ک", initial: "کـ", medial: "ـکـ", final: "ـک", ipa: "k", transliteration: "k"))
	alphabet.append(Letter(english: "gâf", persian: "گاف", isolated: "گ", initial: "گـ", medial: "ـگـ", final: "ـگ", ipa: "ɡ", transliteration: "g"))
	alphabet.append(Letter(english: "lâm", persian: "لام", isolated: "ل", initial: "لـ", medial: "ـلـ", final: "ـل", ipa: "l", transliteration: "l"))
	alphabet.append(Letter(english: "mim", persian: "میم", isolated: "م", initial: "مـ", medial: "ـمـ", final: "ـم", ipa: "m", transliteration: "m"))
	alphabet.append(Letter(english: "nun", persian: "نون", isolated: "ن", initial: "نـ", medial: "ـنـ", final: "ـن", ipa: "n", transliteration: "n"))
	alphabet.append(Letter(english: "vâv", persian: "واو", isolated: "و", initial: "و", medial: "ـو", final: "ـو", ipa: "oː", transliteration: "v"))
	alphabet.append(Letter(english: "hā-ye do-češm", persian: "هه", isolated: "ه", initial: "هـ", medial: "ـهـ", final: "ـه", ipa: "h", transliteration: "h"))
	alphabet.append(Letter(english: "ya", persian: "یه", isolated: "ی", initial: "یـ", medial: "ـیـ", final: "ـی", ipa: "eː", transliteration: "y"))
	alphabet.append(Letter(english: "hamzah", persian: "همزه", isolated: "ء", initial: "", medial: "", final: "", ipa: "ʔ", transliteration: "'"))
	//alphabet.append(Letter(english: "hamzah alef", persian: "همزه", isolated: "أ", initial: "أ", medial: "ـأ", final: "ـأ", ipa: "ʔ", transliteration: "a"))
	//alphabet.append(Letter(english: "hamzah", persian: "همزه", isolated: "ئ", initial: "ئـ", medial: "ـئـ", final: "ـئ", ipa: "ʔ", transliteration: ""))
	//alphabet.append(Letter(english: "hamzah", persian: "همزه", isolated: "ؤ", initial: "ؤ", medial: "ـؤ", final: "ـؤ", ipa: "ʔ", transliteration: ""))
	alphabet.append(Letter(english: "alef madde", persian: "", isolated: "آ", initial: "آ", medial: "", final: "ـآ", ipa: "ɒ", transliteration: "a"))
	alphabet.append(Letter(english: "he ye", persian: "", isolated: "ۀ", initial: "", medial: "", final: "ـۀ", ipa: "eje", transliteration: "h"))
	alphabet.append(Letter(english: "lām alef", persian: "", isolated: "لا", initial: "", medial: "", final: "ـلا", ipa: "lɒ", transliteration: "la"))
}


// TODO: Cleanup function
func loadDictionary() -> Bool {
	let filename = "words"
	guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
		print("Failed to locate \(filename).json in the bundle.")
		dictionary.append(Word(persian: "کرد", english: "did", derivative: "کن", alternate: "do"))
		dictionary.append(Word(persian: "خرید", english: "bought", derivative: "خر", alternate: "buy"))
		dictionary.append(Word(persian: "حیوان", pos: .noun, english: "animal"))
		dictionary.append(Word(persian: "علی", pos: .noun, english: "Ali; name of the first Imam"))
		dictionary.append(Word(persian: "قندهار", pos: .noun, english: "Kandahar; city located in southern Afghanistan"))
		dictionary.append(Word(persian: "افغانستان", pos: .noun, english: "Afghanistan; country located in central Asia; officially known as Islamic Emirate of Afghanistan"))
		dictionary = dictionary.sorted(by: {$0.persian < $1.persian})
		return false
	}
	
	do {
		let data = try Data(contentsOf: url)
		let decoder = JSONDecoder()
		let items = try decoder.decode([WordJSON].self, from: data)
		for item in items {
			switch item.pos {
			case "verb":
				dictionary.append(Word(persian: item.persian, english: item.english, derivative: item.derivative ?? "", alternate: item.alternate ?? ""))
			default:
				dictionary.append(Word(persian: item.persian, pos: PartOfSpeech.fromString(input: item.pos), english: item.english))
			}
		}
		dictionary = dictionary.sorted(by: {$0.persian < $1.persian})
		return true
	}
	catch {
		print("Failed to load or decode \(filename).json: \(error)")
		return false
	}
}


func loadExamples() {
	examples.append(Example(english: "Ali is the best", persian: "علی بهترین است"))
	examples.append(Example(english: "Kandahar is the best city", persian: "قندهار بهترین شهر است"))
	examples.append(Example(english: "Kandahar is in Afghanistan", persian: "قندهار در افغانستان است"))
	examples.append(Example(english: "A lion is an animal", persian: "شیر حیوان است"))
	examples.append(Example(english: "Afghanistan is better than Iran", persian: "افغانستان بهتر از ایران است"))
}


extension StringProtocol {
	subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}
}
