//
//  RealmService.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import RealmSwift

/// This class abstracts having to know about a specific Realm from the normal consumer.
/// This prevents each object having to know about the realm in it's own save() method.
///
/// In some circumstances the Object will have to be injected with a RealmService to handle
/// managing it's own relational logic.

class RealmService {
    let realm: Realm!
    
    /// Initialize with a specific Realm.
    init(realm: Realm) {
        self.realm = realm
    }
    
    /// Initialize with the default Realm.
    convenience init() {
        var realm: Realm
        if ProcessInfo.processInfo.arguments.contains("-UseInMemoryRealm") {
            var configuration = Realm.Configuration()
            configuration.inMemoryIdentifier = "inMemoryRealm"
            realm = try! Realm(configuration: configuration)
        } else {
            realm = try! Realm()
        }
        self.init(realm: realm)
    }
    
    /// Persist an object to the realm
    ///
    /// Child objects will also be added to the realm.
    func addObject(_ object: Object) {
        try! realm.write {
            self.realm.add(object)
        }
    }
    
    /// Remove an object from the realm.
    ///
    /// Child objects which are dependent will also be removed from the realm.
    func removeObject(_ object: Object) {
        // Remove all sessions and exercises from routine
        if let routine = object as? Routine {
            for session in routine.sessions {
                removeObject(session)
            }
            for exercise in routine.exercises {
                removeObject(exercise)
            }
            //                self.realm.delete(routine.sessions)
            //                self.realm.delete(routine.exercises)
        } else if let session = object as? Session {
            // Remove all working sets from session
            for set in session.sets {
                removeObject(set)
            }
        }

        try! realm.write {
            self.realm.delete(object)
        }
    }
    
    
    
    /// Commit a write transaction to the realm
    func commitTransaction(_ block: (() -> Void)) {
        try! realm.write {
            block()
        }
    }
}
