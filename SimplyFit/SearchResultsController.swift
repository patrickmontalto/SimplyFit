//
//  SearchResultsController.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/12/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit
import RealmSwift

/// Manages search results of a specified object type for a UITableView
/// on behalf of a parent viewController.
/// Also serves as the delegate and data source for the UITableView.
///
/// - parameter delegate: The parent view controller containing the tableView which conforms to SearchResultsDelegate
/// - parameter tableView: Tableview responding to results change.
/// - parameter realmService: The realm service object conducting fetches.
class SearchResultsController<T>: UITableViewController where T: Object, T: SearchableObject {
    
    // MARK: - Properties
    weak var delegate: SearchResultsDelegate?
    let realmService: RealmService
    
    lazy var data: Results<T> = {
        self.realmService.realm.objects(T.self)
    }()
    
    var selectedData = [T]()
    
    init(delegate: SearchResultsDelegate, tableView: UITableView, realmService: RealmService) {
        self.delegate = delegate
        self.realmService = realmService
        
        super.init(style: .plain)

        self.tableView = tableView
        
        // set delegate and data source for tableview
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        // register cell
        self.tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: SearchResultsTableViewCell.reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Filters the data with the given search term.
    ///
    /// - parameter searchTerm: String to use for filtering.
    ///
    /// - returns: Number of results displayed.
    func filterData(searchTerm: String) -> Int {
        
        // Reload the tableView at end of function execution
        defer { tableView.reloadData() }
        
        let count = searchTerm.characters.count
        guard count > 0 else {
            data = realmService.realm.objects(T.self)
            return data.count
        }
        
        
        data = realmService.realm.objects(T.self).filter(T.filterQuery(searchTerm: searchTerm))
        
        return data.count
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.reuseIdentifier, for: indexPath) as! SearchResultsTableViewCell
        let object = data[indexPath.row]
        if selectedData.contains(object) {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        cell.nameLabel.text = object.displayName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Add the selected object to the selected objects array
        let selectedObject = data[indexPath.row]
        selectedData.append(selectedObject)
        delegate?.searchResultsController(self, didSelectObjects: selectedData)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // TODO: Remove that object from the selected list
        let deselectedObject = data[indexPath.row]
        selectedData = selectedData.filter { $0 != deselectedObject }
        delegate?.searchResultsController(self, didSelectObjects: selectedData)
    }
}

