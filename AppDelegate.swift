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
			dictionary.append(Word(persian, english, pos))
		}
	}
	
	//
	// This function prepares an array that contains the persian alphabet
	//
	func loadAlphabet() {
		alphabet.append(Letter("ʾalef", "الف", "ا", "ا", "ـا", "ـا", "", "ɒ", "â"))
		alphabet.append(Letter("be", "به", "ب", "بـ", "ـبـ", "ـب", "", "b", "b"))
		alphabet.append(Letter("pe", "په", "پ", "پـ", "ـپـ", "ـپ", "", "p", "p"))
		alphabet.append(Letter("te", "ته", "ت", "تـ", "ـتـ", "ـت", "", "t", "t"))
		alphabet.append(Letter("s̱e", "ثه", "ث", "ثـ", "ـثـ", "ـث", "", "s", "s̱"))
		alphabet.append(Letter("jim", "جیم", "ج", "جـ", "ـجـ", "ـج", "", "d͡ʒ", "j"))
		alphabet.append(Letter("che", "چه", "چ", "چـ", "ـچـ", "ـچ", "", "t͡ʃ", "č"))
		alphabet.append(Letter("ḥe", "حه", "ح", "حـ", "ـحـ", "ـح", "", "h", "ḥ"))
		alphabet.append(Letter("khe", "خه", "خ", "خـ", "ـخـ", "ـخ", "", "x", "x"))
		alphabet.append(Letter("dâl", "دال", "د", "د", "ـد", "ـد", "", "d", "d"))
		alphabet.append(Letter("ẕâl", "ذال", "ذ", "ذ", "ـذ", "ـذ", "", "z", "ẕ"))
		alphabet.append(Letter("re", "ره", "ر", "ر", "ـر", "ـر", "", "ɾ", "r"))
		alphabet.append(Letter("ze", "زه", "ز", "ز", "ـز", "ـز", "", "z", "z"))
		alphabet.append(Letter("že", "ژه", "ژ", "ژ", "ـژ", "ـژ", "", "ʒ", "ž"))
		alphabet.append(Letter("sin", "سین", "س", "سـ", "ـسـ", "ـس", "", "s", "s"))
		alphabet.append(Letter("šin", "شین", "ش", "شـ", "ـشـ", "ـش", "", "ʃ", "š"))
		alphabet.append(Letter("ṣäd", "صاد", "ص", "صـ", "ـصـ", "ـص", "", "s", "ṣ"))
		alphabet.append(Letter("zâd", "ضاد", "ض", "ضـ", "ـضـ", "ـض", "", "z", "z"))
		alphabet.append(Letter("toy", "طی، طا", "ط", "طـ", "ـطـ", "ـط", "", "t", "t"))
		alphabet.append(Letter("ẓoy", "ظی، ظا", "ظ", "ظـ", "ـظـ", "ـظ", "", "z", "ẓ"))
		alphabet.append(Letter("ʿayn", "عین", "ع", "عـ", "ـعـ", "ـع", "", "ʔ", "ʿ"))
		alphabet.append(Letter("ġayn", "غین", "غ", "غـ", "ـغـ", "ـغ", "", "ɣ", "ġ"))
		alphabet.append(Letter("fe", "فه", "ف", "فـ", "ـفـ", "ـف", "", "f", "f"))
		alphabet.append(Letter("q̈âf", "قاف", "ق", "قـ", "ـقـ", "ـق", "", "ɣ", "q"))
		alphabet.append(Letter("kâf", "کاف", "ک", "کـ", "ـکـ", "ـک", "", "k", "k"))
		alphabet.append(Letter("gâf", "گاف", "گ", "گـ", "ـگـ", "ـگ", "", "ɡ", "g"))
		alphabet.append(Letter("lâm", "لام", "ل", "لـ", "ـلـ", "ـل", "", "l", "l"))
		alphabet.append(Letter("mim", "میم", "م", "مـ", "ـمـ", "ـم", "", "m", "m"))
		alphabet.append(Letter("nun", "نون", "ن", "نـ", "ـنـ", "ـن", "", "n", "n"))
		alphabet.append(Letter("vâv", "واو", "و", "و", "ـو", "ـو", "", "oː", "ō"))
		alphabet.append(Letter("hā-ye do-češm", "هه", "ه", "هـ", "ـهـ", "ـه", "", "h", "h"))
		alphabet.append(Letter("ya", "یه", "ی", "یـ", "ـیـ", "ـی", "", "eː", "ē"))
		alphabet.append(Letter("hamzah", "همزه", "ء", "", "", "", "", "ʔ", "ʾ"))
		alphabet.append(Letter("hamzah alef", "همزه", "أ", "أ", "ـأ", "ـأ", "", "ʔ", "ʾ"))
		alphabet.append(Letter("hamzah", "همزه", "ئ", "ئـ", "ـئـ", "ـئ", "", "ʔ", "ʾ"))
		alphabet.append(Letter("hamzah", "همزه", "ؤ", "ؤ", "ـؤ", "ـؤ", "", "ʔ", "ʾ"))
		alphabet.append(Letter("alef madde", "", "آ", "آ", "", "ـآ", "", "ɒ", "â"))
		alphabet.append(Letter("he ye", "", "ۀ", "", "", "ـۀ", "", "eje", "eye"))
		alphabet.append(Letter("lām alef", "", "لا", "", "", "ـلا", "", "lɒ", "lā"))
	}

}

