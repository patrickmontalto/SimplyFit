//
//  RealmTestable.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation
import RealmSwift
@testable import SimplyFit

protocol RealmTestable {
    func prepareTestRealm(inMemoryIdentifier: String) -> Realm
        
    func wipeRealm(_ realm: Realm)
}

extension RealmTestable {
    func prepareTestRealm(inMemoryIdentifier: String) -> Realm {
        // Create in-memory test realm
        var inMemoryConfig = Realm.Configuration()
        inMemoryConfig.inMemoryIdentifier = inMemoryIdentifier
        return try! Realm(configuration: inMemoryConfig)
    }
    
    func wipeRealm(_ realm: Realm) {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
