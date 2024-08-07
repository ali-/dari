//
//  ContentView.swift
//

import SwiftUI

var alphabet = [Letter]()
var dictionary = [Int: Word]()
var examples = [Example]()


struct ContentView: View {
	@EnvironmentObject var globalState: GlobalState
	@State private var selectedTab: Int = 0
	
	var body: some View {
		TabView(selection: $selectedTab) {
			SettingsView()
				.tabItem {
					Image(systemName: "gear")
					Text("Settings")
				}.tag(3)
			AlphabetView()
				.tabItem {
					Image(systemName: "abc")
					Text("Alphabet")
				}.tag(2)
			ExamplesView()
				.tabItem {
					Image(systemName: "list.bullet")
					Text("Examples")
				}.tag(1)
			DictionaryView()
				.tabItem {
					Image(systemName: "book.fill")
					Text("Dictionary")
				}.tag(0)
		}
		.accentColor(.green)
	}
}



//------------------------------------------------------------------------------------------------//
//--[ ALPHABET ]----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


struct AlphabetView: View {
	var body: some View {
		NavigationView {
			List(alphabet) { letter in
				LetterRow(letter: letter)
			}
			.listStyle(.plain)
			.navigationBarTitle(Text("Alphabet"), displayMode: .inline)
		}
		.accentColor(.green)
	}
}



//------------------------------------------------------------------------------------------------//
//--[ EXAMPLES ]----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


struct ExamplesView: View {
	@State private var searchQuery = ""
	
	var searchResults: [Example] {
		if searchQuery.isEmpty {
			return examples
		}
		else {
			var results = examples.filter{$0.english.lowercased().contains(searchQuery.lowercased())}
			results = results.isEmpty ? examples.filter{$0.persian.contains(searchQuery)} : results
			return results
		}
	}
	
	var body: some View {
		NavigationView {
			List(searchResults) { example in
				ExampleRow(example: example)
					.swipeActions(edge: .leading) {
						Button("Favorite") {
							print("Favorited!")
						}
						.tint(.green)
					}
			}
			.listStyle(.plain)
			.navigationBarTitle(Text("Examples"), displayMode: .inline)
		}
		.accentColor(.green)
		.searchable(text: $searchQuery, placement: .toolbar)
	}
}

struct ExampleRow: View {
	@EnvironmentObject var globalState: GlobalState
	var example: Example
	
	var body: some View {
		NavigationLink(destination: ExampleView(example: example)) {
			let words = Array(example.persian.split(separator: " ").reversed())
			let wordsWithDiacriticals = Array(example.persian.withoutDiacritics.split(separator: " ").reversed())
			VStack {
				HStack {
					ForEach(0...(words.count-1), id: \.self) { index in
						// TODO: The parent HStack needs to support multiple lines of text
						VStack {
							Text(Word.transliterate(persian: String(words[index])))
								.font(.system(size: 15.0))
								.foregroundColor(.gray)
								.frame(alignment: .trailing)
							Text(globalState.showDiacriticals ? words[index] : wordsWithDiacriticals[index])
								.frame(alignment: .trailing)
						}
					}
				}
				.frame(maxWidth: .infinity, alignment: .trailing)
				Divider()
				Text("\(example.english)")
					.foregroundColor(.gray)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.bottom, 5)
					.padding(.top, 5)
			}
			.padding(.top, 5)
		}
	}
}

struct ExampleView: View {
	@EnvironmentObject var globalState: GlobalState
	var example: Example
	
	var body: some View {
		let words = Array(example.persian.split(separator: " ").reversed())
		let wordsWithDiacriticals = Array(example.persian.withoutDiacritics.split(separator: " ").reversed())
		HStack {
			ForEach(0...(words.count-1), id: \.self) { index in
				// TODO: The parent HStack needs to support multiple lines of text
				VStack {
					Text(Word.transliterate(persian: String(words[index])))
						.font(.system(size: 15.0))
						.foregroundColor(.gray)
						.frame(alignment: .trailing)
					Text(globalState.showDiacriticals ? words[index] : wordsWithDiacriticals[index])
						.frame(alignment: .trailing)
				}
			}
		}
		Text(example.english)
	}
}



//------------------------------------------------------------------------------------------------//
//--[ DICTIONARY ]--------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


struct DictionaryView: View {
	// TODO: Update search to use non-diacritical matches
	@State private var searchQuery = ""
	@State private var isSearchBarVisible: Bool = false
	
	var searchResults: [Int: Word] {
		if searchQuery.isEmpty {
			return dictionary
		}
		else {
			let englishFiltered = dictionary.filter { $0.value.english.lowercased().contains(searchQuery.lowercased()) }
			let finalFiltered = englishFiltered.isEmpty
				? dictionary.filter { $0.value.persian.contains(searchQuery) }
				: englishFiltered
			return finalFiltered
		}
	}
	
	var body: some View {
		NavigationView {
			List(searchResults.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
				WordRow(id: key)
					.swipeActions(edge: .leading) {
						Button("Favorite") {
							print("Favorited!")
						}
						.tint(.green)
					}
			}
			.listStyle(.plain)
			.navigationBarTitle(Text("Dictionary"), displayMode: .inline)
		}
		.accentColor(.green)
		.searchable(text: $searchQuery, placement: .toolbar)
	}
}

struct LetterRow: View {
	var letter: Letter

	var body: some View {
		NavigationLink(destination: LetterView(letter: letter)) {
			HStack {
				Text("\(letter.transliteration)")
					.italic()
					.foregroundColor(.gray)
					.frame(width: 30, alignment: .leading)
				Text("\(letter.english)")
					.foregroundColor(.gray)
					.frame(maxWidth: .infinity, alignment: .trailing)
				Text("\(letter.isolated)")
					.frame(width: 30, alignment: .trailing)
			}
		}
	}
}

struct LetterView: View {
	var letter: Letter
	
	var body: some View {
		List {
			Section(footer: Text("Pronunciation is transliterated from Persian to English")) {
				VStack {
					Text("\(letter.isolated)")
						.font(.system(size: 40.0))
						.frame(maxWidth: .infinity, alignment: .center)
						.padding(.bottom, 5)
						.padding(.top, 15)
					Text("\(letter.transliteration)")
						.italic()
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .center)
				}
				.padding(.bottom, 10)
			}
			Section(header: Text("Name")) {
				HStack {
					Text("English")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(letter.english)")
						.frame(width: 150, alignment: .trailing)
				}
				HStack {
					Text("Persian")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(letter.persian)")
						.frame(width: 150, alignment: .trailing)
				}
			}
			Section(header: Text("Contextual Forms")) {
				HStack {
					Text("Isolated")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(letter.isolated)")
						.frame(width: 75, alignment: .trailing)
				}
				if letter.initial != "" {
					HStack {
						Text("Initial")
							.foregroundColor(.gray)
							.frame(maxWidth: .infinity, alignment: .leading)
						Text("\(letter.initial)")
							.frame(width: 75, alignment: .trailing)
					}
				}
				if letter.medial != "" {
					HStack {
						Text("Medial")
							.foregroundColor(.gray)
							.frame(maxWidth: .infinity, alignment: .leading)
						Text("\(letter.medial)")
							.frame(width: 75, alignment: .trailing)
					}
				}
				if letter.final != "" {
					HStack {
						Text("Final")
							.foregroundColor(.gray)
							.frame(maxWidth: .infinity, alignment: .leading)
						Text("\(letter.final)")
							.frame(width: 75, alignment: .trailing)
					}
				}
			}
			if letter.isolated == "\u{0627}" {
				Section(header: Text("Special Forms"), footer: Text("")) {
					HStack {
						Text("Madde")
							.foregroundColor(.gray)
							.frame(maxWidth: .infinity, alignment: .leading)
						Text("\u{0622}")
							.frame(width: 75, alignment: .trailing)
					}
				}
			}
		}
		.listStyle(.grouped)
	}
}

struct WordFormRow: View {
	var english: String
	var persian: String
	
	private var e: String {
		let parts = english.split(separator: ";")
		return parts.first.map(String.init) ?? english
	}
	
	var body: some View {
		HStack {
			Text(e)
				.foregroundColor(.gray)
				.frame(maxWidth: .infinity, alignment: .leading)
			Text(persian)
				.frame(width: 150, alignment: .trailing)
				.textSelection(.enabled)
		}
	}
}

struct WordRow: View {
	@EnvironmentObject var globalState: GlobalState
	var id: Int
	
	var body: some View {
		if let word = dictionary[id] {
			NavigationLink(destination: WordView(id: id)) {
				VStack {
					Text("\(globalState.showDiacriticals ? word.persian : word.persian.withoutDiacritics)")
						.fontWeight(.bold)
						.frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
					Text("\(word.english.replacingOccurrences(of: ";", with: ","))")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .leading)
						.truncationMode(.tail)
				}
				.environment(\.layoutDirection, .rightToLeft)
				.padding(.bottom, 10)
				.padding(.top, 5)
			}
		}
	}
}

struct WordView: View {
	@EnvironmentObject var globalState: GlobalState
	private var exampleList: [Example] = []
	var word: Word

	init(id: Int) {
		self.word = dictionary[id]!
		for example in examples {
			if example.matches(word) {
				exampleList.append(example)
			}
		}
	}
	
	private var partOfSpeech: some View {
		Text("\(word.pos.rawValue)")
			.font(.system(size: 14.0, weight: .bold))
			.foregroundColor(.gray)
			.textCase(.uppercase)
	}
	
	var body: some View {
		List {
			Section() {
				VStack {
					Text(globalState.showDiacriticals ? word.persian : word.persian.withoutDiacritics)
						.font(.system(size: 40.0, weight: .light))
						.frame(maxWidth: .infinity, alignment: .center)
						.padding(.bottom, 5)
						.padding(.top, 10)
						.textSelection(.enabled)
						.onTapGesture { globalState.showDiacriticals.toggle() }
					Text("\(Word.transliterate(persian: word.persian))")
						.italic()
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .center)
				}
				.padding(.bottom, 10)
			}
			Section(header: Text("Definition")) {
				if word.pos == .noun {
					NavigationLink(destination: NounView(word: word)) { partOfSpeech }
				}
				else if word.pos == .verb && word.derivative.isEmpty == false {
					NavigationLink(destination: VerbView(word: word)) { partOfSpeech }
				}
				else { partOfSpeech }
				Text("\(word.english.replacingOccurrences(of: ";", with: ","))")
					.lineSpacing(5)
					.padding(.bottom, 5)
					.padding(.top, 5)
					.frame(maxWidth: .infinity, alignment: .leading)
			}
			Section(header: Text("Related")) {
				if word.related.count > 0 {
					ForEach(0..<word.related.count, id: \.self) { index in
						let relatedID = word.related[index]
						if let relatedWord = dictionary[relatedID] {
							NavigationLink(destination: WordView(id: relatedID)) {
								HStack {
									Text(relatedWord.english.split(separator: ";").first!)
										.foregroundColor(.gray)
										.frame(maxWidth: .infinity, alignment: .leading)
									Text(globalState.showDiacriticals ? relatedWord.persian : relatedWord.persian.withoutDiacritics)
										.frame(width: 120, alignment: .trailing)
								}
							}
						}
					}
				}
			}
			Section(header: Text("Script Decomposition")) {
				ForEach(Array(word.split.enumerated()), id: \.offset) { (index, l) in
					if let letter = alphabet.first(where: {$0.isolated == l}) {
						LetterRow(letter: letter)
					}
				}
			}
			if !exampleList.isEmpty {
				Section(header: Text("Examples"), footer: Text("Examples and transliteration are read from right to left")) {
					ForEach(exampleList, id: \.self) { example in
						ExampleRow(example: example)
					}
				}
			}
		}
		.listStyle(.grouped)
	}
}



//------------------------------------------------------------------------------------------------//
//--[ PARTS OF SPEECH ]---------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


struct NounView: View {
	var word: Word
	var body: some View {
		let onah = "\u{0622}\u{0646}\u{0647}"
		let mah = "\u{0645}\u{062D}"
		let shomah = "\u{0634}\u{0645}\u{0627}"
		
		let az = "\u{0627}\u{0632}"
		let ast = "\u{0627}\u{0633}\u{062A}"
		let ki = "\u{06A9}\u{06CC}"
		let q = "\u{061F}"
		
		// TODO: Review this list
		List {
			Section(header: Text("Formal")) {
				WordFormRow(english: "my \(word.english)", persian: (word.persian+" "+mah))
				WordFormRow(english: "your \(word.english)", persian: (word.persian+" "+shomah))
				WordFormRow(english: "their \(word.english)", persian: (word.persian+" "+onah))
			}
			Section(header: Text("Informal")) {
				WordFormRow(english: "my \(word.english)", persian: (word.persian+"\u{0645}"))						// em
				WordFormRow(english: "your \(word.english)", persian: (word.persian+"\u{062A}"))					// et
				WordFormRow(english: "his/her \(word.english)", persian: (word.persian+"\u{0634}"))					// esh
				WordFormRow(english: "their \(word.english)", persian: (word.persian+"\u{0634}\u{0627}\u{0646}"))	// esh
			}
			Section(header: Text("Question")) {
				WordFormRow(english: "is it my \(word.english)?", persian: "\(word.persian) \(az) \(mah) \(ast)\(q)")
				WordFormRow(english: "is it your \(word.english)?", persian: "\(word.persian) \(az) \(shomah) \(ast)\(q)")
				WordFormRow(english: "is it their \(word.english)?", persian: "\(word.persian) \(az) \(onah) \(ast)\(q)")
				WordFormRow(english: "who's \(word.english) is it?", persian: "\(word.persian) \(az) \(ki) \(ast)\(q)")
			}
		}
		.listStyle(.grouped)
	}
}


struct VerbView: View {
	var word: Word
	
	private var gerundRoot: String {
		let vowels = "aeiou"
		
		if word.alternate.hasSuffix("e") {
			if word.alternate.hasSuffix("ie") {
				return String(word.alternate.dropLast(2)) + "y"
			}
			return String(word.alternate.dropLast())
		}
		
		if word.alternate.hasSuffix("y") {
			return word.alternate
		}
		
		if !vowels.contains(word.alternate.last!) {
			let secondToLastIndex = word.alternate.index(word.alternate.endIndex, offsetBy: -2)
			if vowels.contains(word.alternate[secondToLastIndex]) {
				if let lastLetter = word.alternate.last {
					return word.alternate + String(lastLetter)
				}
			}
		}
		
		return word.alternate
	}
	
	var body: some View {
		let b = "\u{0628}"
		let em = "\u{06CC}\u{0645}"
		let me = "\u{0645}\u{06CC}"
		let m = "\u{0645}"
		let n = "\u{0646}"
		let name = "\u{0646}\u{0645}\u{06CC}"
		let q = "\u{061F}"
		List {
			Section(header: Text("Present/Future")) {																			// kard / kon (derivative / root)
				WordFormRow(english: "I am \(gerundRoot)ing / will \(word.alternate)", persian: (me+word.derivative+m))			// mekonom
				WordFormRow(english: "I won't \(word.alternate)", persian: (name+word.derivative+m))							// namekonom
				WordFormRow(english: "we are \(gerundRoot)ing / will \(word.alternate)", persian: (me+word.derivative+em))		// mekonem
				WordFormRow(english: "we won't \(word.alternate)", persian: (name+word.derivative+em))							// namekonem
				WordFormRow(english: "they are \(gerundRoot)ing / will \(word.alternate)", persian: (me+word.derivative+n))		// mekonan
				WordFormRow(english: "they won't \(word.alternate)", persian: (name+word.derivative+n))							// namekonan
			}
			Section(header: Text("Past")) {
				WordFormRow(english: "I \(word.english)", persian: (word.persian+m))											// kardom
				WordFormRow(english: "I did not \(word.alternate)", persian: (n+word.persian+m))								// nakardom
				WordFormRow(english: "we \(word.english)", persian: (me+word.persian+em))										// mekardem
				WordFormRow(english: "we did not \(word.alternate)", persian: (name+word.persian+em))							// namekardem
				WordFormRow(english: "they \(word.english)", persian: (me+word.persian+n))										// mekardan
				WordFormRow(english: "they did not \(word.alternate)", persian: (name+word.persian+n))							// namekardan
			}
			Section(header: Text("Command")) {
				WordFormRow(english: word.alternate, persian: (b+word.derivative+n))											// bokonen
				WordFormRow(english: "don't \(word.alternate)", persian: (n+word.derivative+n))									// nakonen
			}
			Section(header: Text("Question")) {
				WordFormRow(english: "will you \(word.alternate)?", persian: (me+word.derivative+n+q))							// mekonen?
				WordFormRow(english: "did you \(word.alternate)?", persian: (word.persian+n+q))									// karden?
				WordFormRow(english: "you didn't \(word.alternate)?", persian: (n+word.persian+n+q))							// nakarden?
				WordFormRow(english: "were you going to \(word.alternate)?", persian: (me+word.persian+n+q))					// mekarden?
			}
		}
		.listStyle(.grouped)
	}
}



//------------------------------------------------------------------------------------------------//
//--[ SETTINGS ]----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


struct SettingsView: View {
	@EnvironmentObject var globalState: GlobalState
	
	var body: some View {
		NavigationView {
			List() {
				Section(header: Text("Diacriticals"), footer: Text("")) {
					HStack {
						Text("Show diacritical marks")
						Spacer()
						Toggle(isOn: $globalState.showDiacriticals) {
							EmptyView() // No label for the Toggle, it's handled by the alignment
						}
						.labelsHidden() // Hide the default label of the Toggle
					}
				}
			}
			.listStyle(.grouped)
			.navigationBarTitle(Text("Settings"), displayMode: .inline)
		}
		.accentColor(.green)
	}
}
