//
//  WordViewController.swift
//

import UIKit

class WordViewController: UITableViewController {
	
	let word = dictionary[selectedRow]
	var examples = [Example]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.register(LetterCell.self, forCellReuseIdentifier: "letterCell")
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(buttonBookmark))

		for e in example {
			let x = e.persian.map{String($0)}
			if let ex = x.firstIndex(where: {$0 == word.persian}) {
				examples.append(example[ex])
			}
		}

		if favorite.firstIndex(where: {$0.persian == word.persian}) != nil {
			navigationItem.rightBarButtonItem?.tintColor = .systemGreen
		}
	}
	
	@objc func buttonBookmark(sender: UIButton!) {
		if let i = favorite.firstIndex(where: {$0.persian == word.persian}) {
			print("Removed \(favorite[i].persian) from favorites")
			navigationItem.rightBarButtonItem?.tintColor = .white
			favorite.remove(at: i)
		}
		else {
			print("Adding \(word.persian) to favorites")
			navigationItem.rightBarButtonItem?.tintColor = .systemGreen
			favorite.append(word)
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
			case 1:
				let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
					if indexPath.row == 0 {
						cell?.textLabel?.text = word.pos
						cell?.textLabel?.font = .systemFont(ofSize: 15.0)
						cell?.textLabel?.textColor = .darkGray
						cell?.isUserInteractionEnabled = false
						tableView.rowHeight = 30.0
						return cell!
					}
					else {
						cell?.textLabel?.text = word.english
						cell?.textLabel?.font = .systemFont(ofSize: 17.0)
						cell?.textLabel?.numberOfLines = 5
						cell?.isUserInteractionEnabled = false
						tableView.rowHeight = UITableView.automaticDimension
						return cell!
					}
			
			case 2:
				let cell = tableView.dequeueReusableCell(withIdentifier: "letterCell") as! LetterCell
				let letter: String = word.split[indexPath.row]
				cell.letterLabel.text = letter
				if let a = alphabet.firstIndex(where: {$0.isolated == letter}) {
					cell.letterNameLabel.text = alphabet[a].english
					cell.phoneticLabel.text = alphabet[a].ipa
				}
				cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
				tableView.rowHeight = 50.0
				return cell
				
			
			default:
				let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
				if indexPath.row == 0 {
					cell?.textLabel?.text = word.persian
					cell?.textLabel?.font = .systemFont(ofSize: 36.0)
					cell?.textLabel?.textAlignment = .center;
					cell?.isUserInteractionEnabled = false
					tableView.rowHeight = 75.0
					return cell!
				}
				else {
					cell?.textLabel?.text = word.din
					cell?.textLabel?.textAlignment = .center;
					cell?.isUserInteractionEnabled = false
					tableView.rowHeight = 35.0
					return cell!
				}
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let letter = word.split[indexPath.row]
		selectedLetter = alphabet.firstIndex(where: {$0.isolated == String(letter)})!
		tableView.deselectRow(at: indexPath, animated: false)
		let sc = LetterViewController.init(style: .grouped)
		self.navigationController?.pushViewController(sc, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
			case 1:
				return "Definition"
			case 2:
				return "Decomposition"
			default:
				return ""
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
			case 2:
				return word.split.count
			default:
				return 2
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		switch section {
			case 0:
				return "Transliteration using DIN 31635 standard"
			case 2:
				return "Transliteration using International Phonetic Alphabet notation"
			default:
				return ""
		}
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
}
