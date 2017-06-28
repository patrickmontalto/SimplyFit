//
//  Routine.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation
import RealmSwift

class Routine: Object {
    
    // MARK: - Persisted Properties
    
    dynamic var title = ""
    dynamic var archived: Bool = false
    let exercises = List<Exercise>()
    let sessions = List<Session>()
    
    // MARK: - Other Properties
    
    
    // MARK: - Init
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    // MARK: - Meta
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    // MARK: - Actions
    
    /// Add a new exercise to the routine.
    func addExercise(movement: Movement, repMin: Int, repMax: Int, sets: Int, inRealm realm: Realm) {
        
        var _movement = movement
        
        if movement.existsInRealm(realm) {
            _movement = realm.object(ofType: Movement.self, forPrimaryKey: movement.name)!
        }

        let exercise = Exercise(movement: _movement, repMin: repMin, repMax: repMax, sets: sets)
        exercises.append(exercise)
    }
    
    func existsInRealm(_ realm: Realm) -> Bool {
        return realm.object(ofType: Routine.self, forPrimaryKey: self.title) != nil
    }
    
    func archive(_ archive: Bool) {
        self.archived = archive
    }
        
}
 
extension Routine: SearchableObject {
    var displayName: String {
        return title
    }
}
