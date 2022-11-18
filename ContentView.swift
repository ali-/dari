//
//  ContentView.swift
//

import SwiftUI

// Global variables
var alphabet = [Letter]()
var dictionary = [Word]()
var examples = [Example]()

struct DictionaryRow: View {
	var word: Word
	var body: some View {
		NavigationLink(destination: WordView(word: word)) {
			VStack {
				Text("\(word.persian)")
					.fontWeight(.bold)
					.frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
				Text("\(word.english)")
					.foregroundColor(.gray)
					.frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
			}
			.environment(\.layoutDirection, .rightToLeft)
			.padding(.bottom, 10)
			.padding(.top, 5)
		}
	}
}

struct NounView: View {
	var word: Word
	var body: some View {
		let h = "ح"			// meem
		let m = "م"			// meem
		let q = "؟"			// question
		let t = "م"			// teh
		let ast = ""
		let key = ""
		let their = "ونح"	// vaw, noon, hey
		let your = "شمح"		// sheen, meem, hey
		List {
			Section(header: Text("Formal")) {
				HStack {
					Text("my \(word.english)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+" "+m+h)") // seb e mah
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("your \(word.english)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+" "+your)") // seb e shomah
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("their \(word.english)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+" "+their)") // seb e onah
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
			}
			Section(header: Text("Informal")) {
				HStack {
					Text("my \(word.english)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+m)") // seb em
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("your \(word.english)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+t)") // seb toh
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
			}
			Section(header: Text("Question")) {
				HStack {
					Text("is it your \(word.english)?")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+q)") // seb shomah ast
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("is it their \(word.english)?")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+q)") // seb onah ast
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("who's \(word.english) is it?")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+" "+key+" "+ast)") // seb key ast
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
			}
		}.listStyle(.grouped)
	}
}

struct VerbView: View {
	var word: Word
	var body: some View {
		let my = "می"		// meem, ya
		let m = "م"			// meem
		let n = "ن"			// noon
		let nmy = "نمی"		// noon, meem, ya
		let q = "؟"			// question
		let ym = "یم"		// ya, meem
		List {
			Section(header: Text("Present/Future")) {
				HStack {
					Text("I am \(word.alternate)ing / will \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(my+" "+word.derivative+m)") // mekonom
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("I won't \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(nmy+" "+word.derivative+m)") // namekonom
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("we are \(word.alternate)ing / will \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(my+" "+word.derivative+ym)") // mekonem
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("we won't \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(nmy+" "+word.derivative+ym)") // namekonem
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("they are \(word.alternate)ing / will \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(my+" "+word.derivative+n)") // mekonan
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("they won't \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(nmy+" "+word.derivative+n)") // namekonan
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
			}
			Section(header: Text("Past")) {
				HStack {
					Text("I \(word.english)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+m)") // kardom
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("I did not \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(n+word.persian+m)") // nakardom
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("we \(word.english)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(my+" "+word.persian+ym)") // mekardem
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("we did not \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(nmy+" "+word.persian+ym)") // namekardem
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("they \(word.english)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(my+" "+word.persian+n)") // mekardan
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("they did not \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(nmy+" "+word.persian+n)") // namekardan
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
			}
			Section(header: Text("Command")) {
				HStack {
					Text("\(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\("ب"+word.derivative+n)") // bokonen
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("don't \(word.alternate)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(n+word.derivative+n)") // nakonen
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
			}
			Section(header: Text("Question")) {
				HStack {
					Text("will you \(word.alternate)?")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(my+" "+word.derivative+n+q)") // mekonen?
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("did you \(word.alternate)?")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(word.persian+n+q)") // karden?
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("you didn't \(word.alternate)?")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(n+word.persian+n+q)") // karden?
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
				HStack {
					Text("were you going to \(word.alternate)?")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(my+" "+word.persian+n+q)") // mekarden?
						.frame(width: 100, alignment: .trailing)
						.textSelection(.enabled)
				}
			}
		}.listStyle(.grouped)
	}
}

struct WordView: View {
	@State private var favorited = "star"
	var word: Word
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
					Text("\(word.ipa)")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .center)
				}
				.padding(.bottom, 10)
			}
			Section(header: Text("Definition")) {
				if word.pos == .noun {
					NavigationLink(destination: NounView(word: word)) {
						Text("\(word.pos.rawValue)")
							.font(.system(size: 14.0, weight: .bold))
							.foregroundColor(.gray)
							.textCase(.uppercase)
					}
				}
				else if word.pos == .verb {
					NavigationLink(destination: VerbView(word: word)) {
						Text("\(word.pos.rawValue)")
							.font(.system(size: 14.0, weight: .bold))
							.foregroundColor(.gray)
							.textCase(.uppercase)
					}
				}
				else {
					Text("\(word.pos.rawValue)")
						.font(.system(size: 14.0, weight: .bold))
						.foregroundColor(.gray)
						.textCase(.uppercase)
				}
				Text("\(word.english)")
					.lineSpacing(5)
					.padding(.bottom, 7)
					.padding(.top, 7)
			}
			Section(header: Text("Script Decomposition")) {
				ForEach(0..<word.split.count) { l in
					let letter = alphabet.firstIndex(where: {$0.isolated == String(word.split[l])})!
					NavigationLink(destination: LetterView(letter: letter)) {
						HStack {
							Text("\(alphabet[letter].isolated)")
								.frame(width: 30, alignment: .center)
							Text("\(alphabet[letter].english)")
								.foregroundColor(.gray)
								.frame(maxWidth: .infinity, alignment: .leading)
							Text("\(alphabet[letter].ipa)")
								.foregroundColor(.gray)
								.frame(width: 30, alignment: .trailing)
						}
					}
				}
			}
			if examples[0].matches(word) {
				Section(header: Text("Examples")) {
					// TODO: Query example database for matches that contain this word
					ForEach(0..<examples.count) { e in
						NavigationLink(destination: Text("Best name")) {
							VStack {
								Text("\(examples[e].persian)")
									.frame(maxWidth: .infinity, alignment: .trailing)
									.padding(.bottom, 5)
									.padding(.top, 5)
								Divider()
								Text("\(examples[e].english)")
									.foregroundColor(.gray)
									.frame(maxWidth: .infinity, alignment: .trailing)
									.padding(.bottom, 5)
									.padding(.top, 5)
							}
						}
					}
				}
			}
		}
		.listStyle(.grouped)
		.toolbar {
			ToolbarItem {
				Image(systemName: favorited).onTapGesture {
					// TODO: Insert word into favorites list
					print("Favorited!")
					favorited = "star.fill"
				}
			}
		}
	}
}

struct LetterView: View {
	var letter: Int
	var body: some View {
		List {
			Section(footer: Text("Using International Phonetic Alphabet notation")) {
				VStack {
					Text("\(alphabet[letter].isolated)")
						.font(.system(size: 40.0))
						.frame(maxWidth: .infinity, alignment: .center)
						.padding(.bottom, 5)
						.padding(.top, 15)
					Text("\(alphabet[letter].ipa)")
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
					Text("\(alphabet[letter].english)")
						.frame(width: 75, alignment: .trailing)
				}
				HStack {
					Text("Persian")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(alphabet[letter].persian)")
						.frame(width: 75, alignment: .trailing)
				}
			}
			Section(header: Text("Contextual Forms")) {
				HStack {
					Text("Isolated")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(alphabet[letter].isolated)")
						.frame(width: 75, alignment: .trailing)
				}
				HStack {
					Text("Initial")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(alphabet[letter].initial)")
						.frame(width: 75, alignment: .trailing)
				}
				HStack {
					Text("Medial")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(alphabet[letter].medial)")
						.frame(width: 75, alignment: .trailing)
				}
				HStack {
					Text("Final")
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					Text("\(alphabet[letter].final)")
						.frame(width: 75, alignment: .trailing)
				}
			}
		}
		.listStyle(.grouped)
	}
}

struct ContentView: View {
	@State private var searchQuery = ""
	@State private var searchScope = 0
	
	var body: some View {
		NavigationView {
			List {
				ForEach(0..<dictionary.count) { index in
					DictionaryRow(word: dictionary[index])
						.listRowBackground(Color.black)
				}
			}
			.listStyle(.plain)
			.navigationBarTitle(Text("Dictionary"), displayMode: .inline)
			.toolbar {
				ToolbarItem(placement: .navigation) {
					Button("🇦🇫") {
						print("🇦🇫")
					}
				}
			}
		}
		.preferredColorScheme(.dark)
		/*
		.searchable(text: $searchQuery) {
			Picker("Please choose a color", selection: $searchScope) {
				Text("All").tag(0)
				Text("Favorites").tag(1)
			}
			.pickerStyle(.segmented)
		}
		*/
	}
}
