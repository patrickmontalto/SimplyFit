//
//  MovementHistory.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation
import RealmSwift

/// This object encapsulates the history of a movement across all sessions and exercises.
struct MovementHistory {
    let movement: Movement
    var history = [[String: Any]]()
    
    // MARK: - Init
    init(movement: Movement, inRealm realm: Realm) {
        self.movement = movement
        
        // Build the history property
        gatherHistory(inRealm: realm)
    }
    
    /// Determines if a movement has a history or not.
    func doesExist() -> Bool {
        return !history.isEmpty
    }
    
    // MARK: - Actions
    private mutating func gatherHistory(inRealm realm: Realm) {
        // Put each working set into a dictionary according to their respective session
        for session in movement.sessions {
            let sets = movement.workingSets.filter("%@ IN sessions", session).sorted(byKeyPath: "setNumber", ascending: true)
            let data = ["session": session,
                        "workingSets": sets]
            history.append(data)
        }
    }
}
