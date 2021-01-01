//
//  AppDelegate.swift
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		loadDictionary()
		loadAlphabet()
		return true
	}
	
	func loadDictionary() {
		let url = URL(fileURLWithPath: Bundle.main.path(forResource: "word", ofType: "json")!)
		let data = try! Data(contentsOf: url)
		let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
		let array = json as? [Any]
		for word in array! {
			let dict = word as? [String: Any]
			let persian = dict!["persian"] as! String
			let english = dict!["english"] as! String
			let pos = dict!["pos"] as! String
			dictionary.append(Word(persian, english, pos))
		}
	}
	
	func loadAlphabet() {
		alphabet.append(Letter(english: "ʾalef", persian: "الف", isolated: "ا", initial: "ا", medial: "ـا", final: "ـا", phonetic: "", ipa: "ɒ", din: "â"))
		alphabet.append(Letter(english: "be", persian: "به", isolated: "ب", initial: "بـ", medial: "ـبـ", final: "ـب", phonetic: "", ipa: "b", din: "b"))
		alphabet.append(Letter(english: "pe", persian: "په", isolated: "پ", initial: "پـ", medial: "ـپـ", final: "ـپ", phonetic: "", ipa: "p", din: "p"))
		alphabet.append(Letter(english: "te", persian: "ته", isolated: "ت", initial: "تـ", medial: "ـتـ", final: "ـت", phonetic: "", ipa: "t", din: "t"))
		alphabet.append(Letter(english: "s̱e", persian: "ثه", isolated: "ث", initial: "ثـ", medial: "ـثـ", final: "ـث", phonetic: "", ipa: "s", din: "s̱"))
		alphabet.append(Letter(english: "jim", persian: "جیم", isolated: "ج", initial: "جـ", medial: "ـجـ", final: "ـج", phonetic: "", ipa: "d͡ʒ", din: "j"))
		alphabet.append(Letter(english: "che", persian: "چه", isolated: "چ", initial: "چـ", medial: "ـچـ", final: "ـچ", phonetic: "", ipa: "t͡ʃ", din: "č"))
		alphabet.append(Letter(english: "ḥe", persian: "حه", isolated: "ح", initial: "حـ", medial: "ـحـ", final: "ـح", phonetic: "", ipa: "h", din: "ḥ"))
		alphabet.append(Letter(english: "khe", persian: "خه", isolated: "خ", initial: "خـ", medial: "ـخـ", final: "ـخ", phonetic: "", ipa: "x", din: "x"))
		alphabet.append(Letter(english: "dâl", persian: "دال", isolated: "د", initial: "د", medial: "ـد", final: "ـد", phonetic: "", ipa: "d", din: "d"))
		alphabet.append(Letter(english: "ẕâl", persian: "ذال", isolated: "ذ", initial: "ذ", medial: "ـذ", final: "ـذ", phonetic: "", ipa: "z", din: "ẕ"))
		alphabet.append(Letter(english: "re", persian: "ره", isolated: "ر", initial: "ر", medial: "ـر", final: "ـر", phonetic: "", ipa: "ɾ", din: "r"))
		alphabet.append(Letter(english: "ze", persian: "زه", isolated: "ز", initial: "ز", medial: "ـز", final: "ـز", phonetic: "", ipa: "z", din: "z"))
		alphabet.append(Letter(english: "že", persian: "ژه", isolated: "ژ", initial: "ژ", medial: "ـژ", final: "ـژ", phonetic: "", ipa: "ʒ", din: "ž"))
		alphabet.append(Letter(english: "sin", persian: "سین", isolated: "س", initial: "سـ", medial: "ـسـ", final: "ـس", phonetic: "", ipa: "s", din: "s"))
		alphabet.append(Letter(english: "šin", persian: "شین", isolated: "ش", initial: "شـ", medial: "ـشـ", final: "ـش", phonetic: "", ipa: "ʃ", din: "š"))
		alphabet.append(Letter(english: "ṣäd", persian: "صاد", isolated: "ص", initial: "صـ", medial: "ـصـ", final: "ـص", phonetic: "", ipa: "s", din: "ṣ"))
		alphabet.append(Letter(english: "zâd", persian: "ضاد", isolated: "ض", initial: "ضـ", medial: "ـضـ", final: "ـض", phonetic: "", ipa: "z", din: "z"))
		alphabet.append(Letter(english: "toy", persian: "طی، طا", isolated: "ط", initial: "طـ", medial: "ـطـ", final: "ـط", phonetic: "", ipa: "t", din: "t"))
		alphabet.append(Letter(english: "ẓoy", persian: "ظی، ظا", isolated: "ظ", initial: "ظـ", medial: "ـظـ", final: "ـظ", phonetic: "", ipa: "z", din: "ẓ"))
		alphabet.append(Letter(english: "ʿayn", persian: "عین", isolated: "ع", initial: "عـ", medial: "ـعـ", final: "ـع", phonetic: "", ipa: "ʔ", din: "ʿ"))
		alphabet.append(Letter(english: "ġayn", persian: "غین", isolated: "غ", initial: "غـ", medial: "ـغـ", final: "ـغ", phonetic: "", ipa: "ɣ", din: "ġ"))
		alphabet.append(Letter(english: "fe", persian: "فه", isolated: "ف", initial: "فـ", medial: "ـفـ", final: "ـف", phonetic: "", ipa: "f", din: "f"))
		alphabet.append(Letter(english: "q̈âf", persian: "قاف", isolated: "ق", initial: "قـ", medial: "ـقـ", final: "ـق", phonetic: "", ipa: "ɣ", din: "q"))
		alphabet.append(Letter(english: "kâf", persian: "کاف", isolated: "ک", initial: "کـ", medial: "ـکـ", final: "ـک", phonetic: "", ipa: "k", din: "k"))
		alphabet.append(Letter(english: "gâf", persian: "گاف", isolated: "گ", initial: "گـ", medial: "ـگـ", final: "ـگ", phonetic: "", ipa: "ɡ", din: "g"))
		alphabet.append(Letter(english: "lâm", persian: "لام", isolated: "ل", initial: "لـ", medial: "ـلـ", final: "ـل", phonetic: "", ipa: "l", din: "l"))
		alphabet.append(Letter(english: "mim", persian: "میم", isolated: "م", initial: "مـ", medial: "ـمـ", final: "ـم", phonetic: "", ipa: "m", din: "m"))
		alphabet.append(Letter(english: "nun", persian: "نون", isolated: "ن", initial: "نـ", medial: "ـنـ", final: "ـن", phonetic: "", ipa: "n", din: "n"))
		alphabet.append(Letter(english: "vâv", persian: "واو", isolated: "و", initial: "و", medial: "ـو", final: "ـو", phonetic: "", ipa: "oː", din: "ō"))
		alphabet.append(Letter(english: "hā-ye do-češm", persian: "هه", isolated: "ه", initial: "هـ", medial: "ـهـ", final: "ـه", phonetic: "", ipa: "h", din: "h"))
		alphabet.append(Letter(english: "ya", persian: "یه", isolated: "ی", initial: "یـ", medial: "ـیـ", final: "ـی", phonetic: "", ipa: "eː", din: "ē"))
		alphabet.append(Letter(english: "hamzah", persian: "همزه", isolated: "ء", initial: "", medial: "", final: "", phonetic: "", ipa: "ʔ", din: "ʾ"))
		alphabet.append(Letter(english: "hamzah alef", persian: "همزه", isolated: "أ", initial: "أ", medial: "ـأ", final: "ـأ", phonetic: "", ipa: "ʔ", din: "ʾ"))
		alphabet.append(Letter(english: "hamzah", persian: "همزه", isolated: "ئ", initial: "ئـ", medial: "ـئـ", final: "ـئ", phonetic: "", ipa: "ʔ", din: "ʾ"))
		alphabet.append(Letter(english: "hamzah", persian: "همزه", isolated: "ؤ", initial: "ؤ", medial: "ـؤ", final: "ـؤ", phonetic: "", ipa: "ʔ", din: "ʾ"))
		alphabet.append(Letter(english: "alef madde", persian: "", isolated: "آ", initial: "آ", medial: "", final: "ـآ", phonetic: "", ipa: "ɒ", din: "â"))
		alphabet.append(Letter(english: "he ye", persian: "", isolated: "ۀ", initial: "", medial: "", final: "ـۀ", phonetic: "", ipa: "eje", din: "eye"))
		alphabet.append(Letter(english: "lām alef", persian: "", isolated: "لا", initial: "", medial: "", final: "ـلا", phonetic: "", ipa: "lɒ", din: "lā"))
	}

}

