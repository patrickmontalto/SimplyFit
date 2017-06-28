//
//  Session.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation
import RealmSwift

class Session: Object {
    
    // MARK: - Persisted Properties
    dynamic var id = UUID().uuidString // Unique identifier for this session
    let sets = List<WorkingSet>()
    private let routines = LinkingObjects(fromType: Routine.self, property: "sessions")
    dynamic var timestamp = Date().timeIntervalSinceReferenceDate // datetime at moment of creation of object
    
    // MARK: - Other Properties
    
    var routine: Routine {
        assert(self.routines.first != nil, "orphaned session does not belong to a routine. make sure the session was added to the realm before accessing the routine property.")
        return self.routines.first!
    }
    
    // MARK: - Init
        
    /// Initialize in a specific realm
    convenience init(routine: Routine, realmService: RealmService = RealmService()) {
        self.init()
        realmService.commitTransaction {
            routine.sessions.append(self)
        }
    }
    
    // MARK: - Meta
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - Actions
    func addSet(_ set: WorkingSet) {
        sets.append(set)
    }
    
}
