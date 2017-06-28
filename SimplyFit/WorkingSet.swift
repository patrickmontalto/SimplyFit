//
//  WorkingSet.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation
import RealmSwift

class WorkingSet: Object {
    
    // MARK: - Persisted Properties
    
    dynamic var id = UUID().uuidString // Unique identifier for this working set
    dynamic var setNumber: Int = 0
    dynamic var movement: Movement?
    dynamic var weight: Float = 0.0
    dynamic var reps: Int = 0
    private let sessions = LinkingObjects(fromType: Session.self, property: "sets")
    
    var session: Session {
        assert(self.sessions.first != nil, "orphaned working set does not belong to a session.")
        return self.sessions.first!
    }

    // MARK: - Other Properties
    
    
    // MARK: - Init
        
    /// Initialize in a specific realm
    /// Adds the working set to the specified session.
    convenience init(movement: Movement, setNumber: Int, weight: Float, reps: Int, session: Session, realmService: RealmService = RealmService()) {
        self.init()
        self.movement = movement
        self.setNumber = setNumber
        self.weight = weight
        self.reps = reps
        realmService.commitTransaction {
            session.addSet(self)
        }
    }
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
}
