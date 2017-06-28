//
//  SearchableObject.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/12/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation
import RealmSwift

protocol SearchableObject {
    
    var displayName: String { get }
    
    static func primaryKey() -> String?
    
    static func filterQuery(searchTerm: String) -> NSPredicate
}

extension SearchableObject {
    static func filterQuery(searchTerm: String) -> NSPredicate {
        let pk = primaryKey()!
        return NSPredicate(format: "\(pk) CONTAINS[cd] %@", searchTerm)
    }
}
