//
//  LetterViewController.swift
//

import UIKit

class LetterViewController: UITableViewController {
	
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
				if indexPath.row == 0 { return rightDetailCell("English", alphabet[selectedLetter].english) }
				else { return rightDetailCell("Persian", alphabet[selectedLetter].persian) }
			
			// Contextual forms
			case 2:
				if indexPath.row == 0 { return rightDetailCell("Isolated", alphabet[selectedLetter].isolated) }
				else if indexPath.row == 1 { return rightDetailCell("Initial", alphabet[selectedLetter].initial) }
				else if indexPath.row == 2 { return rightDetailCell("Medial", alphabet[selectedLetter].medial) }
				else { return rightDetailCell("Final", alphabet[selectedLetter].final) }
			
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
					cell?.textLabel?.text = alphabet[selectedLetter].din
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
				return "Persian letters may vary depending on location within script"
			default:
				return "Transliteration using DIN 31635 standard"
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

class LetterCell: UITableViewCell {
	
	let letterLabel = UILabel()
	let letterNameLabel = UILabel()
	let phoneticLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		let frameHeight = contentView.frame.height+2.5
		let frameWidth = contentView.frame.width
		
		letterLabel.frame = CGRect(x: 20, y: 0, width: 30, height: frameHeight)
		letterNameLabel.frame = CGRect(x: 60, y: 0, width: frameWidth-100, height: frameHeight)
		phoneticLabel.frame = CGRect(x: frameWidth-30, y: 0, width: 30, height: frameHeight)
		
		letterLabel.textColor = .lightGray
		letterNameLabel.textColor = .darkGray
		phoneticLabel.textColor = .darkGray
		
		letterLabel.font = .systemFont(ofSize: 24.0)
		letterNameLabel.font = .systemFont(ofSize: 15.0)
		
		letterLabel.textAlignment = .center
		phoneticLabel.textAlignment = .right
		
		contentView.addSubview(letterLabel)
		contentView.addSubview(letterNameLabel)
		contentView.addSubview(phoneticLabel)
	}
	
	required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
}
