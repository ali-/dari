//
//  AppDelegate.swift
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	//
	// Application has finished launching
	//
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Load arrays
		loadDictionary()
		loadAlphabet()
		return true
	}
	
	//
	// This function parses the JSON file which contains the dictionary
	//
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
			let phonetic = dict!["phonetic"] as! String
			dictionary.append(Word(persian, english, pos, phonetic))
		}
	}
	
	//
	// This function prepares an array that contains the persian alphabet
	//
	func loadAlphabet() {
		alphabet.append(Script("ɒ", "ʾalef", "الف", "ا", "ا", "ـا", "ـا"))
		alphabet.append(Script("b", "be", "به", "ب", "بـ", "ـبـ", "ـب"))
		alphabet.append(Script("p", "pe", "په", "پ", "پـ", "ـپـ", "ـپ"))
		alphabet.append(Script("t", "te", "ته", "ت", "تـ", "ـتـ", "ـت"))
		alphabet.append(Script("s", "s̱e", "ثه", "ث", "ثـ", "ـثـ", "ـث"))
		alphabet.append(Script("d͡ʒ", "jim", "جیم", "ج", "جـ", "ـجـ", "ـج"))
		alphabet.append(Script("t͡ʃ", "che", "چه", "چ", "چـ", "ـچـ", "ـچ"))
		alphabet.append(Script("h", "ḥe", "حه", "ح", "حـ", "ـحـ", "ـح"))
		alphabet.append(Script("x", "khe", "خه", "خ", "خـ", "ـخـ", "ـخ"))
		alphabet.append(Script("d", "dâl", "دال", "د", "د", "ـد", "ـد"))
		alphabet.append(Script("z", "ẕâl", "ذال", "ذ", "ذ", "ـذ", "ـذ"))
		alphabet.append(Script("ɾ", "re", "ره", "ر", "ر", "ـر", "ـر"))
		alphabet.append(Script("z", "ze", "زه", "ز", "ز", "ـز", "ـز"))
		alphabet.append(Script("ʒ", "že", "ژه", "ژ", "ژ", "ـژ", "ـژ"))
		alphabet.append(Script("s", "sin", "سین", "س", "سـ", "ـسـ", "ـس"))
		alphabet.append(Script("ʃ", "šin", "شین", "ش", "شـ", "ـشـ", "ـش"))
		alphabet.append(Script("s", "ṣäd", "صاد", "ص", "صـ", "ـصـ", "ـص"))
		alphabet.append(Script("z", "zâd", "ضاد", "ض", "ضـ", "ـضـ", "ـض"))
		alphabet.append(Script("t", "toy", "طی، طا", "ط", "طـ", "ـطـ", "ـط"))
		alphabet.append(Script("z", "ẓoy", "ظی، ظا", "ظ", "ظـ", "ـظـ", "ـظ"))
		alphabet.append(Script("ʔ", "ʿayn", "عین", "ع", "عـ", "ـعـ", "ـع"))
		alphabet.append(Script("ɣ", "ġayn", "غین", "غ", "غـ", "ـغـ", "ـغ"))
		alphabet.append(Script("f", "fe", "فه", "ف", "فـ", "ـفـ", "ـف"))
		alphabet.append(Script("ɣ", "q̈âf", "قاف", "ق", "قـ", "ـقـ", "ـق"))
		alphabet.append(Script("k", "kâf", "کاف", "ک", "کـ", "ـکـ", "ـک"))
		alphabet.append(Script("ɡ", "gâf", "گاف", "گ", "گـ", "ـگـ", "ـگ"))
		alphabet.append(Script("l", "lâm", "لام", "ل", "لـ", "ـلـ", "ـل"))
		alphabet.append(Script("m", "mim", "میم", "م", "مـ", "ـمـ", "ـم"))
		alphabet.append(Script("n", "nun", "نون", "ن", "نـ", "ـنـ", "ـن"))
		alphabet.append(Script("oː", "vâv", "واو", "و", "و", "ـو", "ـو"))
		alphabet.append(Script("h", "hā-ye do-češm", "هه", "ه", "هـ", "ـهـ", "ـه"))
		alphabet.append(Script("eː", "ya", "یه", "ی", "یـ", "ـیـ", "ـی"))
		alphabet.append(Script("ʔ", "hamzah", "همزه", "ء", "", "", ""))
		alphabet.append(Script("ʔ", "hamzah alef", "همزه", "أ", "أ", "ـأ", "ـأ"))
		alphabet.append(Script("ʔ", "hamzah", "همزه", "ئ", "ئـ", "ـئـ", "ـئ"))
		alphabet.append(Script("ʔ", "hamzah", "همزه", "ؤ", "ؤ", "ـؤ", "ـؤ"))
		alphabet.append(Script("ɒ", "alef madde", "", "آ", "آ", "", "ـآ"))
		alphabet.append(Script("eje", "he ye", "", "ۀ", "", "", "ـۀ"))
		alphabet.append(Script("lɒ", "lām alef", "", "لا", "", "", "ـلا"))
	}

}

