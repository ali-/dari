//
//  dariApp.swift
//

import SwiftUI


@main struct dariApp: App {
	@StateObject private var globalState = GlobalStateSingleton.shared
	
	init() {
		loadAlphabet()
		loadDictionary()
		loadExamples()
	}
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(globalState)
				//.environment(\.layoutDirection, .rightToLeft)
				//.preferredColorScheme(.dark)
        }
    }
}


class GlobalState: ObservableObject {
	@Published var showSettings: Bool = false
	
	@Published var showDiacriticals: Bool {
		didSet {
			UserDefaults.standard.set(showDiacriticals, forKey: "showDiacriticals")
		}
	}
	
	init() {
		self.showDiacriticals = UserDefaults.standard.bool(forKey: "showDiacriticals")
	}
}
final class GlobalStateSingleton {
	static let shared = GlobalState()
	private init() {}
}


extension String {
	var withoutDiacritics: String {
		return applyingTransform(.stripDiacritics, reverse: false) ?? self
	}
}


//------------------------------------------------------------------------------------------------//
//--[ DATA LOADING ]------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


func loadAlphabet() {
	alphabet.append(Letter(english: "alef", persian: "الف", isolated: "ا", initial: "ا", medial: "ـا", final: "ـا", transliteration: "a"))
	alphabet.append(Letter(english: "beh", persian: "به", isolated: "ب", initial: "بـ", medial: "ـبـ", final: "ـب", transliteration: "b"))
	alphabet.append(Letter(english: "peh", persian: "په", isolated: "پ", initial: "پـ", medial: "ـپـ", final: "ـپ", transliteration: "p"))
	alphabet.append(Letter(english: "teh", persian: "ته", isolated: "ت", initial: "تـ", medial: "ـتـ", final: "ـت", transliteration: "t"))
	alphabet.append(Letter(english: "seh", persian: "ثه", isolated: "ث", initial: "ثـ", medial: "ـثـ", final: "ـث", transliteration: "s"))
	alphabet.append(Letter(english: "jeem", persian: "جیم", isolated: "ج", initial: "جـ", medial: "ـجـ", final: "ـج", transliteration: "j"))
	alphabet.append(Letter(english: "che", persian: "چه", isolated: "چ", initial: "چـ", medial: "ـچـ", final: "ـچ", transliteration: "ch"))
	alphabet.append(Letter(english: "he", persian: "حه", isolated: "ح", initial: "حـ", medial: "ـحـ", final: "ـح", transliteration: "h"))
	alphabet.append(Letter(english: "khe", persian: "خه", isolated: "خ", initial: "خـ", medial: "ـخـ", final: "ـخ", transliteration: "kh"))
	alphabet.append(Letter(english: "dal", persian: "دال", isolated: "د", initial: "د", medial: "ـد", final: "ـد", transliteration: "d"))
	alphabet.append(Letter(english: "zal", persian: "ذال", isolated: "ذ", initial: "ذ", medial: "ـذ", final: "ـذ", transliteration: "z"))
	alphabet.append(Letter(english: "re", persian: "ره", isolated: "ر", initial: "ر", medial: "ـر", final: "ـر", transliteration: "r"))
	alphabet.append(Letter(english: "ze", persian: "زه", isolated: "ز", initial: "ز", medial: "ـز", final: "ـز", transliteration: "z"))
	alphabet.append(Letter(english: "zhe", persian: "ژه", isolated: "ژ", initial: "ژ", medial: "ـژ", final: "ـژ", transliteration: "zh"))
	alphabet.append(Letter(english: "seen", persian: "سین", isolated: "س", initial: "سـ", medial: "ـسـ", final: "ـس", transliteration: "s"))
	alphabet.append(Letter(english: "sheen", persian: "شین", isolated: "ش", initial: "شـ", medial: "ـشـ", final: "ـش", transliteration: "sh"))
	alphabet.append(Letter(english: "swad", persian: "صاد", isolated: "ص", initial: "صـ", medial: "ـصـ", final: "ـص", transliteration: "s"))
	alphabet.append(Letter(english: "zwad", persian: "ضاد", isolated: "ض", initial: "ضـ", medial: "ـضـ", final: "ـض", transliteration: "z"))
	alphabet.append(Letter(english: "toi", persian: "طی، طا", isolated: "ط", initial: "طـ", medial: "ـطـ", final: "ـط", transliteration: "t"))
	alphabet.append(Letter(english: "zoi", persian: "ظی، ظا", isolated: "ظ", initial: "ظـ", medial: "ـظـ", final: "ـظ", transliteration: "z"))
	alphabet.append(Letter(english: "ayn", persian: "عین", isolated: "ع", initial: "عـ", medial: "ـعـ", final: "ـع", transliteration: "a"))
	alphabet.append(Letter(english: "ghayn", persian: "غین", isolated: "غ", initial: "غـ", medial: "ـغـ", final: "ـغ", transliteration: "gh"))
	alphabet.append(Letter(english: "fe", persian: "فه", isolated: "ف", initial: "فـ", medial: "ـفـ", final: "ـف", transliteration: "f"))
	alphabet.append(Letter(english: "qaf", persian: "قاف", isolated: "ق", initial: "قـ", medial: "ـقـ", final: "ـق", transliteration: "q"))
	alphabet.append(Letter(english: "kaf", persian: "کاف", isolated: "ک", initial: "کـ", medial: "ـکـ", final: "ـک", transliteration: "k"))
	alphabet.append(Letter(english: "gaf", persian: "گاف", isolated: "گ", initial: "گـ", medial: "ـگـ", final: "ـگ", transliteration: "g"))
	alphabet.append(Letter(english: "lam", persian: "لام", isolated: "ل", initial: "لـ", medial: "ـلـ", final: "ـل", transliteration: "l"))
	alphabet.append(Letter(english: "mim", persian: "میم", isolated: "م", initial: "مـ", medial: "ـمـ", final: "ـم", transliteration: "m"))
	alphabet.append(Letter(english: "nun", persian: "نون", isolated: "ن", initial: "نـ", medial: "ـنـ", final: "ـن", transliteration: "n"))
	alphabet.append(Letter(english: "waw", persian: "واو", isolated: "و", initial: "و", medial: "ـو", final: "ـو", transliteration: "w"))
	alphabet.append(Letter(english: "hey du-cesm", persian: "هه", isolated: "ه", initial: "هـ", medial: "ـهـ", final: "ـه", transliteration: "h"))
	alphabet.append(Letter(english: "ya", persian: "یه", isolated: "ی", initial: "یـ", medial: "ـیـ", final: "ـی", transliteration: "y"))

}


func loadDictionary() {
	// TODO: Cleanup
	let filename = "words"
	guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
		print("Failed to locate \(filename).json in the bundle.")
		//dictionary.append(Word(persian: "کَرد", english: "did", derivative: "کُن", alternate: "do"))
		//dictionary.append(Word(persian: "اَفغانِستان", pos: .noun, english: "Afghanistan; officially known as the Islamic Emirate of Afghanistan, is a country located in central Asia"))
		//dictionary = dictionary.sorted(by: {$0.persian < $1.persian})
		return
	}
	do {
		let data = try Data(contentsOf: url)
		let decoder = JSONDecoder()
		let items = try decoder.decode([WordJSON].self, from: data)
		for item in items {
			switch item.pos {
				case "verb":
					dictionary[item.id] = Word(
						persian: item.persian,
						english: item.english,
						derivative: item.derivative ?? "",
						related: item.related ?? [],
						alternate: item.alternate ?? ""
					)
				default:
					dictionary[item.id] = Word(
						persian: item.persian,
						pos: PartOfSpeech.fromString(input: item.pos),
						english: item.english,
						related: item.related ?? []
					)
			}
		}
	}
	catch {
		print("Failed to load or decode \(filename).json: \(error)")
	}
}


func loadExamples() {
	// TODO: Load from a JSON file
	examples.append(Example(english: "Ali is the best", persian: "علی بَهْتَرِین است"))
	examples.append(Example(english: "Kandahar is the best city", persian: "قَندَهَار بَهْتَرِین شَهْر اِسْت"))
	examples.append(Example(english: "Kandahar is in Afghanistan", persian: "قَندَهَار دَر اَفغانِستان اِسْت"))
}


extension StringProtocol {
	subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}
}
