//
//  SearchResultsDelegate.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/12/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import RealmSwift

protocol SearchResultsDelegate: class {
    func searchResultsController<T: SearchableObject>(_ searchResultsController: SearchResultsController<T>, didSelectObjects objects: [T])
}
