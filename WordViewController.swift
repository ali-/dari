//
//  WordViewController.swift
//

import UIKit

class WordViewController: UITableViewController {
	
	var letters: String = dictionary[selectedRow].persian.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "")
	var examples = [Example]()
	
	// Prepare view
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.register(ScriptCell.self, forCellReuseIdentifier: "scriptCell")
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(buttonBookmark))

		for e in example {
			let x = e.persian.map{String($0)}
			if let ex = x.firstIndex(where: {$0 == dictionary[selectedRow].persian}) {
				examples.append(example[ex])
			}
		}

		if favorite.firstIndex(where: {$0.persian == dictionary[selectedRow].persian}) != nil {
			navigationItem.rightBarButtonItem?.tintColor = .systemGreen
		}
	}
	
	// Favorite word
	@objc func buttonBookmark(sender: UIButton!) {
		if let i = favorite.firstIndex(where: {$0.persian == dictionary[selectedRow].persian}) {
			print("Removed \(favorite[i].persian) from favorites")
			navigationItem.rightBarButtonItem?.tintColor = .white
			favorite.remove(at: i)
		}
		else {
			print("Adding \(dictionary[selectedRow].persian) to favorites")
			navigationItem.rightBarButtonItem?.tintColor = .systemGreen
			favorite.append(dictionary[selectedRow])
		}
	}
	
	// Load data
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
			case 1:
				let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
					if indexPath.row == 0 {
						cell?.textLabel?.text = dictionary[selectedRow].pos
						cell?.textLabel?.font = .systemFont(ofSize: 15.0)
						cell?.textLabel?.textColor = .darkGray
						cell?.isUserInteractionEnabled = false
						tableView.rowHeight = 30.0
						return cell!
					}
					else {
						cell?.textLabel?.text = dictionary[selectedRow].english
						cell?.textLabel?.font = .systemFont(ofSize: 17.0)
						cell?.textLabel?.numberOfLines = 5
						cell?.isUserInteractionEnabled = false
						tableView.rowHeight = UITableView.automaticDimension
						return cell!
					}
			
			case 2:
				let cell = tableView.dequeueReusableCell(withIdentifier: "scriptCell") as! ScriptCell
				let word = splitWord()
				let letter = word[indexPath.row]
				cell.scriptLabel.text = letter
				if let a = alphabet.firstIndex(where: {$0.isolated == String(letter)}) {
					cell.scriptNameLabel.text = alphabet[a].english
					cell.phoneticLabel.text = alphabet[a].phonetic
				}
				cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
				tableView.rowHeight = 50.0
				return cell
				
			
			default:
				let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
				if indexPath.row == 0 {
					cell?.textLabel?.text = dictionary[selectedRow].persian
					cell?.textLabel?.font = .systemFont(ofSize: 36.0)
					cell?.textLabel?.textAlignment = .center;
					cell?.isUserInteractionEnabled = false
					tableView.rowHeight = 75.0
					return cell!
				}
				else {
					cell?.textLabel?.text = dictionary[selectedRow].phonetic
					cell?.textLabel?.textAlignment = .center;
					cell?.isUserInteractionEnabled = false
					tableView.rowHeight = 35.0
					return cell!
				}
		}
	}
	
	// Check for special characters
	func splitWord() -> [String] {
		var array = [String]()
		let word = letters.map{String($0)}
		for (i, letter) in letters.enumerated() {
			// Special exception for lam-alef-la
			if letter == "ل" {
				if word.count-1 > i {
					if word[i+1] == "ا" {
						array.append("لا")
						continue
					}
				}
			}
			else if letter == "ا" {
				if i != 0 {
					if word[i-1] == "ل" {
						continue
					}
				}
			}
			array.append(String(letter))
		}
		return array
	}
	
	// Called when a table cell is selected
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let letter = splitWord()[indexPath.row]
		selectedLetter = alphabet.firstIndex(where: {$0.isolated == String(letter)})!
		tableView.deselectRow(at: indexPath, animated: false)
		let sc = ScriptViewController.init(style: .grouped)
		self.navigationController?.pushViewController(sc, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
			case 1:
				return "Definition"
			case 2:
				return "Script Decomposition"
			default:
				return ""
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
			case 2:
				return splitWord().count
			default:
				return 2
		}
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
}
