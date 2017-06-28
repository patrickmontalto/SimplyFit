//
//  Exercise.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation
import RealmSwift

class Exercise: Object {
    
    // MARK: - Persisted Properties
    
    dynamic var id = UUID().uuidString // Unique identifier for this exercise
    dynamic var movement: Movement?
    dynamic var repMin: Int = 0
    dynamic var repMax: Int = 0
    dynamic var sets: Int = 0
    let routines = LinkingObjects(fromType: Routine.self, property: "exercises")
    
    // MARK: - Other Properties
    
    var movementName: String {
        guard let movement = movement else {
            return ""
        }
        return movement.name
    }
    
    // MARK: - Init
    
    convenience init(movement: Movement, repMin: Int, repMax: Int, sets: Int) {
        self.init()
        self.movement = movement
        self.repMin = repMin
        self.repMax = repMax
        self.sets = sets
    }
    
    // MARK: - Meta
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}
