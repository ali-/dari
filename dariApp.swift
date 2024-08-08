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
	@Published var isShowingSettings: Bool = false
	
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
	alphabet.append(Letter(english: "vâv", persian: "واو", isolated: "و", initial: "و", medial: "ـو", final: "ـو", ipa: "oː", transliteration: "w"))
	alphabet.append(Letter(english: "hā-ye do-češm", persian: "هه", isolated: "ه", initial: "هـ", medial: "ـهـ", final: "ـه", ipa: "h", transliteration: "h"))
	alphabet.append(Letter(english: "ya", persian: "یه", isolated: "ی", initial: "یـ", medial: "ـیـ", final: "ـی", ipa: "eː", transliteration: "y"))
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
		//dictionary = dictionary.sorted(by: {$0.persian < $1.persian})
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
