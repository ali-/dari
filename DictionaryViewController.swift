//
//  TableViewController.swift
//

import UIKit

// Global variables
var alphabet = [Letter]()
var dictionary = [Word]()
var example = [Example]()
var filtered = [Word]()
var favorite = [Word]()
var selectedRow = 0
var selectedLetter = 0
let isListingDictionaryRightToLeft = true

class DictionaryViewController: UITableViewController {
	
	lazy var searchController: UISearchController = {
		let s = UISearchController(searchResultsController: nil)
		s.searchResultsUpdater = self
		s.obscuresBackgroundDuringPresentation = false
		s.searchBar.placeholder = "Search..."
		s.searchBar.sizeToFit()
		s.searchBar.searchBarStyle = .prominent
		s.searchBar.scopeButtonTitles = ["All", "Favorites"]
		s.searchBar.delegate = self
		return s
	}()

	// Prepare view
	override func loadView() {
		super.loadView()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		if isListingDictionaryRightToLeft { tableView.semanticContentAttribute = .forceRightToLeft }
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(buttonSearch))
		navigationItem.searchController = searchController
		searchController.hidesNavigationBarDuringPresentation = true
	}
	
	@objc func buttonSearch(sender: UIButton!) {
		searchController.searchBar.becomeFirstResponder()
	}
    
	// Get cell count
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isFiltering() { return filtered.count }
		return dictionary.count
	}
	
	// Load table with data
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Prepare word
		let currentWord: Word
		if isFiltering() { currentWord = filtered[indexPath.row] }
		else { currentWord = dictionary[indexPath.row] }

		// Fill table cell with data
		let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
		cell.textLabel?.text = currentWord.persian
		cell.detailTextLabel?.text = currentWord.english

		// Style cell
		cell.textLabel?.font = UIFont.systemFont(ofSize: 22.0)
		if favorite.contains(where: {$0.persian == currentWord.persian}) {
			cell.textLabel?.textColor = .systemGreen
		}
		cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15.0)
		cell.detailTextLabel?.textColor = UIColor.lightGray
		//cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
		cell.separatorInset = UIEdgeInsets.zero

		// Custom background color when selected
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor(white: 1, alpha: 0.05)
		cell.selectedBackgroundView = backgroundView

		return cell
	}
	
	// Called when a table cell is selected
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if isFiltering() {
			if let i = dictionary.firstIndex(where: {$0.persian == filtered[indexPath.row].persian}) {
				selectedRow = i
			}
		}
		else { selectedRow = indexPath.row }
		tableView.deselectRow(at: indexPath, animated: false)
		let wc = WordViewController.init(style: .grouped)
		self.navigationController?.pushViewController(wc, animated: true)
	}
	
	// Control swipe actions
	override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .normal, title:  "Bookmark", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
			let list: [Word]
			if self.isFiltering() { list = filtered }
			else { list = dictionary }
			if favorite.firstIndex(where: {$0.persian == list[indexPath.row].persian}) != nil {
				print("Already favorited this word")
			}
			else {
				favorite.append(list[indexPath.row])
			}
			tableView.reloadRows(at: [IndexPath(item: indexPath.row, section: indexPath.section)], with: .left)
			success(true)
		})
		action.backgroundColor = .systemGreen
		return UISwipeActionsConfiguration(actions: [action])
	}
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .normal, title:  "Remove", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
			let list: [Word]
			if self.isFiltering() { list = filtered }
			else { list = dictionary }
			if let i = favorite.firstIndex(where: {$0.persian == list[indexPath.row].persian}) {
				favorite.remove(at: i)
			}
			tableView.reloadRows(at: [IndexPath(item: indexPath.row, section: indexPath.section)], with: .right)
			success(true)
		})
		action.backgroundColor = .systemRed
		return UISwipeActionsConfiguration(actions: [action])
	}
	
	// Search functionality
	func filterContentForSearchText(searchText: String, scope: String = "All") {
		let list: [Word]
		if (scope == "Favorites") { list = favorite }
		else { list = dictionary }
		filtered = list.filter({(word: Word) -> Bool in
			let doesWordMatch = (scope == "All") || (scope == "Favorites")
			if isSearchBarEmpty() { return doesWordMatch }
			else { return doesWordMatch && (word.english.lowercased().contains(searchText.lowercased()) || word.persian.contains(searchText)) }
		})
		tableView.reloadData()
	}
	
	func isSearchBarEmpty() -> Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}
	
	// Check if user is filtering
	func isFiltering() -> Bool {
		let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
		return searchController.isActive && (!isSearchBarEmpty() || searchBarScopeIsFiltering)
	}

}

extension DictionaryViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles! [selectedScope])
	}
}

extension DictionaryViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
		filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
	}
}
