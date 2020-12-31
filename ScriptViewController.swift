//
//  ScriptViewController.swift
//

import UIKit

class ScriptViewController: UITableViewController {
	
	// Prepare view
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}
	
	// Layout for detail cells
	func rightDetailCell(_ text: String, _ detail: String) -> UITableViewCell {
		let rowHeight: CGFloat = 50.0
		var cell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell")
		if cell == nil { cell = UITableViewCell(style: .value1, reuseIdentifier: "rightDetailCell") }
		cell?.textLabel?.text = text
		cell?.textLabel?.textColor = .darkGray
		cell?.detailTextLabel?.text = detail
		cell?.isUserInteractionEnabled = false
		tableView.rowHeight = rowHeight
		return cell!
	}
	
	// Load data
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
			// Name of letter
			case 1:
				if indexPath.row == 0 {
					return rightDetailCell("English", alphabet[selectedLetter].english)
				}
				else {
					return rightDetailCell("Persian", alphabet[selectedLetter].persian)
				}
			
			// Contextual forms
			case 2:
				if indexPath.row == 0 {
					return rightDetailCell("Isolated", alphabet[selectedLetter].isolated)
				}
				else if indexPath.row == 1 {
					return rightDetailCell("Initial", alphabet[selectedLetter].initial)
				}
				else if indexPath.row == 2 {
					return rightDetailCell("Medial", alphabet[selectedLetter].medial)
				}
				else {
					return rightDetailCell("Final", alphabet[selectedLetter].final)
				}
			
			// Letter
			default:
				let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
				if indexPath.row == 0 {
					cell?.textLabel?.text = alphabet[selectedLetter].isolated
					cell?.textLabel?.font = .systemFont(ofSize: 36.0)
					cell?.textLabel?.textAlignment = .center;
					cell?.isUserInteractionEnabled = false
					tableView.rowHeight = 75.0
					return cell!
				}
				else {
					cell?.textLabel?.text = alphabet[selectedLetter].phonetic
					cell?.textLabel?.textAlignment = .center;
					cell?.isUserInteractionEnabled = false
					tableView.rowHeight = 40.0
					return cell!
				}
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
			case 1:
				return "Name"
			case 2:
				return "Contextual Forms"
			default:
				return ""
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		switch section {
			case 1:
				return ""
			case 2:
				return "Persian script may vary depending on the location of the letter within a word"
			default:
				return "Using International Phonetic Alphabet notation"
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
			case 2:
				return 4
			default:
				return 2
		}
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
}

class ScriptCell: UITableViewCell {
	
	let scriptLabel = UILabel()
	let scriptNameLabel = UILabel()
	let phoneticLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		let frameHeight = contentView.frame.height+2.5
		let frameWidth = contentView.frame.width
		
		scriptLabel.frame = CGRect(x: 20, y: 0, width: 30, height: frameHeight)
		scriptNameLabel.frame = CGRect(x: 60, y: 0, width: frameWidth-100, height: frameHeight)
		phoneticLabel.frame = CGRect(x: frameWidth-30, y: 0, width: 30, height: frameHeight)
		
		scriptLabel.textColor = .lightGray
		scriptNameLabel.textColor = .darkGray
		phoneticLabel.textColor = .darkGray
		
		scriptLabel.font = .systemFont(ofSize: 24.0)
		scriptNameLabel.font = .systemFont(ofSize: 15.0)
		
		scriptLabel.textAlignment = .center
		phoneticLabel.textAlignment = .right
		
		contentView.addSubview(scriptLabel)
		contentView.addSubview(scriptNameLabel)
		contentView.addSubview(phoneticLabel)
	}
	
	required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
}
