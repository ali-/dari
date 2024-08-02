//
//  ContentView.swift
//

import SwiftUI


var alphabet = [Letter]()
var dictionary = [Word]()
var examples = [Example]()


// TODO: iPad split-view support
struct ContentView: View {
	@State private var searchQuery = ""
	@State private var showingSettingsMenu = false
	
	var searchResults: [Word] {
		if searchQuery.isEmpty {
			return dictionary
		}
		else {
			// TODO: Rank results and order by relevance
			var results = dictionary.filter{$0.english.lowercased().contains(searchQuery.lowercased())}
			results = results.isEmpty ? dictionary.filter{$0.persian.contains(searchQuery)} : results
			return results
		}
	}
	
	var body: some View {
		NavigationView {
			List(searchResults) { word in
				WordRow(word: word)
					.swipeActions(edge: .leading) {
						Button("Favorite") {
							print("Favorited!")
						}
						.tint(.green)
					}
					.navigationBarTitle(Text("Dictionary"), displayMode: .inline)
			}
			.listStyle(.plain)
		}
		.accentColor(.green)
		.searchable(text: $searchQuery, placement: .toolbar)
	}
}


struct WordRow: View {
	var word: Word
	var body: some View {
		NavigationLink(destination: WordView(word: word)) {
			VStack {
				Text("\(word.persian)")
					.fontWeight(.bold)
					.frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
				Text("\(word.english)")
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

struct WordView: View {
	private var exampleList: [Example] = []
	var word: Word

	init(word: Word) {
		self.word = word
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
					Text("\(word.persian)")
						.font(.system(size: 40.0, weight: .light))
						.frame(maxWidth: .infinity, alignment: .center)
						.padding(.bottom, 5)
						.padding(.top, 10)
						.textSelection(.enabled)
					Text("\(Word.transliterate(persian: word.persian))")
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
				Text("\(word.english)")
					.lineSpacing(5)
					.padding(.bottom, 7)
					.padding(.top, 7)
			}
			Section(header: Text("Script Decomposition")) {
				// TODO: Resolve error about non-unique letters
				ForEach(word.split, id: \.self) { l in
					let letter = alphabet.first(where: {$0.isolated == l})!
					LetterRow(letter: letter)
				}
			}
			// TODO: Look through example database for any that contain this word
			if !exampleList.isEmpty {
				Section(header: Text("Examples"), footer: Text("Examples and transliteration are read from right to left")) {
					// TODO: Query example database for matches that contain this word
					ForEach(exampleList, id: \.self) { example in
						ExampleRow(example: example)
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
				.frame(width: 100, alignment: .trailing)
				.textSelection(.enabled)
		}
	}
}

struct NounView: View {
	var word: Word
	var body: some View {
		let h = "ح"			// meem
		let m = "م"			// meem
		let q = "؟"			// question
		let tw = "تو"		// teh
		let ast = ""
		let key = ""
		let their = "ونح"	// vaw, noon, hey
		let your = "شما"		// sheen, meem, hey
		
		// TODO: Review this list
		List {
			Section(header: Text("Formal")) {
				WordFormRow(english: "my \(word.english)", persian: (word.persian+" "+m+h))
				WordFormRow(english: "your \(word.english)", persian: (word.persian+" "+your))
				WordFormRow(english: "their \(word.english)", persian: (word.persian+" "+their))
			}
			Section(header: Text("Informal")) {
				WordFormRow(english: "my \(word.english)", persian: (word.persian+" "+m))
				WordFormRow(english: "your \(word.english)", persian: (word.persian+" "+tw))
			}
			Section(header: Text("Question")) {
				WordFormRow(english: "is it your \(word.english)?", persian: (word.persian+q))
				WordFormRow(english: "is it their \(word.english)?", persian: (word.persian+q))
				WordFormRow(english: "who's \(word.english) is it?", persian: (word.persian+key+ast+q))
			}
		}
		.listStyle(.grouped)
	}
}

struct VerbView: View {
	var word: Word
	var body: some View {
		let b = "ب"			// beh
		let my = "می"		// meem, ya
		let m = "م"			// meem
		let n = "ن"			// noon
		let nmy = "نمی"		// noon, meem, ya
		let q = "؟"			// question
		let ym = "یم"		// ya, meem
		List {
			Section(header: Text("Present/Future")) {																			// kard / kon (derivative / root)
				WordFormRow(english: "I am \(word.alternate)ing / will \(word.alternate)", persian: (my+word.derivative+m))		// mekonom
				WordFormRow(english: "I won't \(word.alternate)", persian: (nmy+word.derivative+m))								// namekonom
				WordFormRow(english: "we are \(word.alternate)ing / will \(word.alternate)", persian: (my+word.derivative+ym))	// mekonem
				WordFormRow(english: "we won't \(word.alternate)", persian: (nmy+word.derivative+ym))							// namekonem
				WordFormRow(english: "they are \(word.alternate)ing / will \(word.alternate)", persian: (my+word.derivative+n))	// mekonan
				WordFormRow(english: "they won't \(word.alternate)", persian: (nmy+word.derivative+n))							// namekonan
			}
			Section(header: Text("Past")) {
				WordFormRow(english: "I \(word.english)", persian: (word.persian+m))											// kardom
				WordFormRow(english: "I did not \(word.alternate)", persian: (n+word.persian+m))								// nakardom
				WordFormRow(english: "we \(word.english)", persian: (my+word.persian+ym))										// mekardem
				WordFormRow(english: "we did not \(word.alternate)", persian: (nmy+word.persian+ym))							// namekardem
				WordFormRow(english: "they \(word.english)", persian: (my+word.persian+n))										// mekardan
				WordFormRow(english: "they did not \(word.alternate)", persian: (nmy+word.persian+n))							// namekardan
			}
			Section(header: Text("Command")) {
				WordFormRow(english: word.alternate, persian: (b+word.derivative+n))											// bokonen
				WordFormRow(english: "don't \(word.alternate)", persian: (n+word.derivative+n))									// nakonen
			}
			Section(header: Text("Question")) {
				WordFormRow(english: "will you \(word.alternate)?", persian: (my+word.derivative+n+q))							// mekonen?
				WordFormRow(english: "did you \(word.alternate)?", persian: (word.persian+n+q))									// karden?
				WordFormRow(english: "you didn't \(word.alternate)?", persian: (n+word.persian+n+q))							// nakarden?
				WordFormRow(english: "were you going to \(word.alternate)?", persian: (my+word.persian+n+q))					// mekarden?
			}
		}
		.listStyle(.grouped)
	}
}


struct ExampleRow: View {
	var example: Example
	var body: some View {
		NavigationLink(destination: ExampleView(example: example)) {
			VStack {
				HStack {
					ForEach(example.persian.split(separator: " ").reversed(), id: \.self) { word in
						// TODO: The parent HStack needs to support multiple lines of text
						VStack {
							Text(Word.transliterate(persian: String(word)))
								.font(.system(size: 15.0))
								.foregroundColor(.gray)
								.frame(alignment: .trailing)
							Text(word)
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
	var example: Example
	var body: some View {
		Text(example.persian)
		Text(example.english)
	}
}


struct LetterRow: View {
	var letter: Letter
	var body: some View {
		NavigationLink(destination: LetterView(letter: letter)) {
			HStack {
				Text("\(Word.transliterate(persian: letter.isolated))")
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
					Text("\(Word.transliterate(persian: letter.isolated))")
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
						.frame(width: 75, alignment: .trailing)
				}
				HStack {
					Text("Persian")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(letter.persian)")
						.frame(width: 75, alignment: .trailing)
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
				HStack {
					Text("Initial")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(letter.initial)")
						.frame(width: 75, alignment: .trailing)
				}
				HStack {
					Text("Medial")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(letter.medial)")
						.frame(width: 75, alignment: .trailing)
				}
				HStack {
					Text("Final")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(letter.final)")
						.frame(width: 75, alignment: .trailing)
				}
			}
		}
		.listStyle(.grouped)
	}
}
