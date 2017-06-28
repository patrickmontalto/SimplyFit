//
//  Movement.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation
import RealmSwift

class Movement: Object {
    
    // MARK: - Persisted Properties
    
    dynamic var name = ""
    let exercises = LinkingObjects(fromType: Exercise.self, property: "movement")
    let workingSets = LinkingObjects(fromType: WorkingSet.self, property: "movement")

    // MARK: - Other Properties
    var sessions: Set<Session> {
        return Set(workingSets.map { $0.session })
    }
    
    func movementHistory(inRealm realm: Realm) -> MovementHistory {
        return MovementHistory(movement: self, inRealm: realm)
    }
    
    func existsInRealm(_ realm: Realm) -> Bool {
        return realm.object(ofType: Movement.self, forPrimaryKey: self.name) != nil
    }
        
    // MARK: - Init
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    // MARK: - Meta
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    
}

extension Movement: SearchableObject {    
    var displayName: String {
        return name
    }
}
