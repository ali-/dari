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
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button(action: { globalState.showSettings.toggle() }) {
					Image(systemName: "gear")
				}
			}
		}
		.sheet(isPresented: $globalState.showSettings) {
			SettingsView()
		}
	}
}



//------------------------------------------------------------------------------------------------//
//--[ ALPHABET ]----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


struct AlphabetView: View {
	@EnvironmentObject var globalState: GlobalState
	
	var body: some View {
		NavigationView {
			List(alphabet) { letter in
				LetterRow(letter: letter)
			}
			.listStyle(.plain)
			.navigationBarTitle(Text("Alphabet"), displayMode: .inline)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button(action: { globalState.showSettings.toggle() }) {
						Image(systemName: "gear")
					}
				}
			}
			Text("Select a letter")
		}
	}
}



//------------------------------------------------------------------------------------------------//
//--[ EXAMPLES ]----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


struct ExampleRow: View {
	@EnvironmentObject var globalState: GlobalState
	var example: Example
	
	var body: some View {
		VStack(alignment: .leading) {
			ForEach(wrappedLines, id: \.self) { line in
				HStack(spacing: 10) {
					ForEach(line, id: \.self) { word in
						VStack {
							Text(Word.transliterate(persian: word))
								.font(.system(size: 12.0))
								.foregroundColor(.gray)
							Text(globalState.showDiacriticals ? word : word.withoutDiacritics)
						}
					}
					Spacer()
				}
				.padding(.bottom, 10)
				.environment(\.layoutDirection, .rightToLeft)
			}
			Divider()
			Text("\(example.english)")
				.foregroundColor(.gray)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.bottom, 5)
				.padding(.top, 5)
		}
		.frame(maxWidth: .infinity, alignment: .trailing)
	}
	
	private var wrappedLines: [[String]] {
		var lines: [[String]] = []
		var currentLine: [String] = []
		var currentLength = 0
		let words = example.persian.split(separator: " ").map(String.init)
		
		for word in words {
			let wordLength = word.count
			
			if currentLength + wordLength > maxCharactersPerLine {
				lines.append(currentLine)
				currentLine = [word]
				currentLength = wordLength
			}
			else {
				currentLine.append(word)
				currentLength += wordLength + 1
			}
		}
		
		if !currentLine.isEmpty {
			lines.append(currentLine)
		}
		
		return lines
	}
	
	var maxCharactersPerLine: Int {
		let screenSize = UIScreen.main.bounds.size
		let scale = UIScreen.main.scale
		let widthInPixels = Int(screenSize.width * scale)
		return widthInPixels/30
	}
}

struct ExamplesView: View {
	@EnvironmentObject var globalState: GlobalState
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
						.tint(.purple)
					}
			}
			.listStyle(.plain)
			.navigationBarTitle(Text("Examples"), displayMode: .inline)
			.searchable(text: $searchQuery, placement: .toolbar)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button(action: { globalState.showSettings.toggle() }) {
						Image(systemName: "gear")
					}
				}
			}
			Text("Select an example")
		}
	}
}



//------------------------------------------------------------------------------------------------//
//--[ DICTIONARY ]--------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


struct DictionaryView: View {
	// TODO: Update search to use non-diacritical matches
	@EnvironmentObject var globalState: GlobalState
	@State private var isSearchBarVisible = false
	@State private var searchQuery = ""
	
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
						.tint(.purple)
					}
			}
			.listStyle(.plain)
			.navigationBarTitle(Text("Dictionary"), displayMode: .inline)
			.searchable(text: $searchQuery, placement: .toolbar)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button(action: { globalState.showSettings.toggle() }) {
						Image(systemName: "gear")
					}
				}
			}
			Text("Select a word")
		}
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
				Spacer()
				Text("\(letter.english)")
					.foregroundColor(.gray)
				Text("\(letter.isolated)")
					.frame(width: 31, alignment: .center)
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
					Spacer()
					Text("\(letter.english)")
				}
				HStack {
					Text("Persian")
						.foregroundColor(.gray)
					Spacer()
					Text("\(letter.persian)")
				}
			}
			Section(header: Text("Contextual Forms")) {
				HStack {
					Text("Isolated")
						.foregroundColor(.gray)
					Spacer()
					Text("\(letter.isolated)")
				}
				if letter.initial != "" {
					HStack {
						Text("Initial")
							.foregroundColor(.gray)
						Spacer()
						Text("\(letter.initial)")
					}
				}
				if letter.medial != "" {
					HStack {
						Text("Medial")
							.foregroundColor(.gray)
						Spacer()
						Text("\(letter.medial)")
					}
				}
				if letter.final != "" {
					HStack {
						Text("Final")
							.foregroundColor(.gray)
						Spacer()
						Text("\(letter.final)")
					}
				}
			}
			if letter.isolated == "\u{0627}" {
				Section(header: Text("Special Forms"), footer: Text("")) {
					HStack {
						Text("Madde")
							.foregroundColor(.gray)
						Spacer()
						Text("\u{0622}")
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
	
	var body: some View {
		HStack {
			Text(english.split(separator: ";").first!)
				.foregroundColor(.gray)
			Spacer()
			VStack(spacing: 5) {
				HStack {
					Spacer()
					Text(Word.transliterate(persian: persian))
						.font(.system(size: 12, design: .monospaced))
						.foregroundColor(.gray)
				}
				HStack {
					Spacer()
					Text(persian.withoutDiacritics)
						.textSelection(.enabled)
				}
			}
		}
		.padding(.bottom, 5)
		.padding(.top, 5)
	}
}

struct WordRow: View {
	@EnvironmentObject var globalState: GlobalState
	var id: Int
	
	var body: some View {
		if let word = dictionary[id] {
			NavigationLink(destination: WordView(id: id)) {
				VStack {
					HStack {
						Text("\(globalState.showDiacriticals ? word.persian : word.persian.withoutDiacritics)")
							.font(.system(size: 19.0))
						Text("[\(Word.transliterate(persian: word.persian))]")
							.font(.system(size: 12.0, design: .monospaced))
							.foregroundColor(.blue)
						Spacer()
					}
					Text("\(word.english.replacingOccurrences(of: ";", with: ","))")
						.font(.system(size: 15.0))
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
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
				else if word.pos == .preposition {
					NavigationLink(destination: PrepositionView(word: word)) { partOfSpeech }
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
			if word.related.count > 0 {
				Section(header: Text("Related")) {
					ForEach(0..<word.related.count, id: \.self) { index in
						let relatedID = word.related[index]
						if let relatedWord = dictionary[relatedID] {
							NavigationLink(destination: WordView(id: relatedID)) {
								HStack {
									Text(relatedWord.english.split(separator: ";").first!)
										.foregroundColor(.gray)
									Spacer()
									Text(globalState.showDiacriticals ? relatedWord.persian : relatedWord.persian.withoutDiacritics)
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
				Section(header: Text("Examples"), footer: Text("Examples are read from right to left. Transliteration above each word is read from left to right.")) {
					ForEach(exampleList, id: \.self) { example in
						ExampleRow(example: example)
					}
				}
			}
		}
		.listStyle(.grouped)
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button(action: { globalState.showDiacriticals.toggle() }) {
					Image(systemName: "character.textbox")
				}
			}
		}
	}
}



//------------------------------------------------------------------------------------------------//
//--[ PARTS OF SPEECH ]---------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------//


struct NounView: View {
	var word: Word
	
	var body: some View {
		let az = "\u{0627}\u{0632}"
		let ast = "\u{0627}\u{0633}\u{062A}"
		let im = "\u{0645}"
		let ish = "\u{0634}"
		let it = "\u{062A}"
		let ki = "\u{06A9}\u{0650}\u{06CC}"
		let onah = "\u{0622}\u{0646}\u{064E}\u{0647}"
		let mah = "\u{0645}\u{064E}\u{062D}"
		let q = "\u{061F}"
		let shan = "\u{0634}\u{0627}\u{0646}"
		let shomah = "\u{0634}\u{064F}\u{0645}\u{064E}\u{0627}"
		
		List {
			Section(header: Text("Formal")) {
				WordFormRow(english: "my \(word.english)", persian: (word.persian+" "+mah))
				WordFormRow(english: "your \(word.english)", persian: (word.persian+" "+shomah))
				WordFormRow(english: "their \(word.english)", persian: (word.persian+" "+onah))
			}
			Section(header: Text("Informal")) {
				WordFormRow(english: "my \(word.english)", persian: (word.persian+im))
				WordFormRow(english: "your \(word.english)", persian: (word.persian+it))
				WordFormRow(english: "their \(word.english)", persian: (word.persian+shan))
				WordFormRow(english: "his/her \(word.english)", persian: (word.persian+ish))
			}
			Section(header: Text("Question")) {
				ExampleRow(example: Example(english: "is it my \(word.english)?", persian: "\(word.persian) \(az) \(mah) \(ast)\(q)"))
				ExampleRow(example: Example(english: "is it your \(word.english)?", persian: "\(word.persian) \(az) \(shomah) \(ast)\(q)"))
				ExampleRow(example: Example(english: "is it their \(word.english)?", persian: "\(word.persian) \(az) \(onah) \(ast)\(q)"))
				ExampleRow(example: Example(english: "who's \(word.english) is it?", persian: "\(word.persian) \(az) \(ki) \(ast)\(q)"))
			}
		}
		.listStyle(.grouped)
	}
}


// TODO: Finish this
struct PrepositionView: View {
	var word: Word
	
	var body: some View {
		
		let ast = "\u{0627}\u{0633}\u{062A}"
		let im = "\u{0650}\u{0645}"
		let ish = "\u{0634}"
		let it = "\u{0650}\u{062A}"
		let ki = "\u{06A9}\u{0650}\u{06CC}"
		let mah = "\u{0645}\u{064E}\u{062D}"
		let onah = "\u{0622}\u{0646}\u{064E}\u{0647}"
		let q = "\u{061F}"
		let shan = "\u{0634}\u{0627}\u{0646}"
		let shomah = "\u{0634}\u{064F}\u{0645}\u{064E}\u{0627}"
		
		List {
			Section(header: Text("Formal")) {
				WordFormRow(english: "\(word.english) me", persian: (word.persian+" "+mah))
				WordFormRow(english: "\(word.english) you", persian: (word.persian+" "+shomah))
				WordFormRow(english: "\(word.english) them", persian: (word.persian+" "+shan))
				WordFormRow(english: "\(word.english) him/her", persian: (word.persian+" "+onah))
			}
			Section(header: Text("Informal")) {
				WordFormRow(english: "\(word.english) me", persian: (word.persian+im))
				WordFormRow(english: "\(word.english) you", persian: (word.persian+it))
				WordFormRow(english: "\(word.english) them", persian: (word.persian+ish))
			}
			Section(header: Text("Question")) {
				ExampleRow(example: Example(english: "is it \(word.english) me?", persian: "\(word.persian) \(mah) \(ast)\(q)"))
				ExampleRow(example: Example(english: "is it \(word.english) you?", persian: "\(word.persian) \(shomah) \(ast)\(q)"))
				ExampleRow(example: Example(english: "is it \(word.english) them?", persian: "\(word.persian) \(onah) \(ast)\(q)"))
				ExampleRow(example: Example(english: "who is it \(word.english)?", persian: "\(word.persian) \(ki) \(ast)\(q)"))
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
		let bo = "\u{0628}\u{064F}"
		let im = "\u{06CC}\u{0645}"
		let me = "\u{0645}\u{0650}\u{06CC}"
		let n = "\u{064E}\u{0646}"
		let na = "\u{0646}\u{064E}"
		let name = "\u{0646}\u{064E}\u{0645}\u{0650}\u{06CC}"
		let om = "\u{064F}\u{0645}"
		let q = "\u{061F}"
		
		List {
			Section(header: Text("Present/Future")) {
				WordFormRow(english: "I am \(gerundRoot)ing / will \(word.alternate)", persian: (me+word.derivative+om))
				WordFormRow(english: "I won't \(word.alternate)", persian: (name+word.derivative+om))
				WordFormRow(english: "we are \(gerundRoot)ing / will \(word.alternate)", persian: (me+word.derivative+im))
				WordFormRow(english: "we won't \(word.alternate)", persian: (name+word.derivative+im))
				WordFormRow(english: "they are \(gerundRoot)ing / will \(word.alternate)", persian: (me+word.derivative+n))
				WordFormRow(english: "they won't \(word.alternate)", persian: (name+word.derivative+n))
			}
			Section(header: Text("Past")) {
				WordFormRow(english: "I \(word.english)", persian: (word.persian+om))
				WordFormRow(english: "I did not \(word.alternate)", persian: (na+word.persian+om))
				WordFormRow(english: "we \(word.english)", persian: (me+word.persian+im))
				WordFormRow(english: "we did not \(word.alternate)", persian: (name+word.persian+im))
				WordFormRow(english: "they \(word.english)", persian: (me+word.persian+n))
				WordFormRow(english: "they did not \(word.alternate)", persian: (name+word.persian+n))
			}
			Section(header: Text("Command")) {
				WordFormRow(english: word.alternate, persian: (bo+word.derivative+n))
				WordFormRow(english: "don't \(word.alternate)", persian: (na+word.derivative+n))
			}
			Section(header: Text("Question")) {
				WordFormRow(english: "will you \(word.alternate)?", persian: (me+word.derivative+n+q))
				WordFormRow(english: "did you \(word.alternate)?", persian: (word.persian+n+q))
				WordFormRow(english: "you didn't \(word.alternate)?", persian: (na+word.persian+n+q))
				WordFormRow(english: "were you going to \(word.alternate)?", persian: (me+word.persian+n+q))
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
				Section(header: Text("Interface"), footer: Text("")) {
					HStack {
						Text("Show diacritical marks")
						Spacer()
						Toggle(isOn: $globalState.showDiacriticals) {
							EmptyView()
						}
						.labelsHidden()
					}
				}
				Section(header: Text("App Information"), footer: Text("")) {
					HStack {
						Text("Build Version")
						Spacer()
						Text("0.1")
							.foregroundColor(.gray)
					}
				}
			}
			.navigationBarTitle(Text("Settings"), displayMode: .inline)
		}
	}
}
