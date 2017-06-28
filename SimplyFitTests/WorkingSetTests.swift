//
//  WorkingSetTests.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import XCTest
import RealmSwift
@testable import SimplyFit

class WorkingSetTests: XCTestCase, RealmTestable {
    
    var testRealm: Realm!
    var realmService: RealmService!
    
    // MARK: - Setup/teardown
    
    override func setUp() {
        super.setUp()
        
        // Create the test realm and realm service
        testRealm = prepareTestRealm(inMemoryIdentifier: "session-tests")
        realmService = RealmService(realm: testRealm)
    }
    
    override func tearDown() {
        // Wipe the realm after each test
        wipeRealm(testRealm)
        
        super.tearDown()
    }

    // MARK: - Helpers
    /// Creates a new Routine Object and adds it to the test realm.
    func newRoutine(title: String = "Upperbody 1") -> Routine {
        let routine = Routine(title: title)
        realmService.addObject(routine)
        return routine
    }
    
    /// Creates a new movement Object and adds it to the test realm.
    func newMovement(name: String = "Hammer Curls") -> Movement {
        let movement = Movement(name: name)
        
        return movement
    }
    
    // MARK: - Tests
    
    func test_InitSetsProperties() {
        let routine = newRoutine()
        let movement = newMovement()
//        let exercise = Exercise(movement: movement, repMin: 6, repMax: 8, sets: 4)
        let session = Session(routine: routine, realmService: realmService)
        
        let workingSet = WorkingSet(movement: movement, setNumber: 1, weight: 25, reps: 7, session: session, realmService: realmService)
        
        XCTAssertEqual(workingSet.movement, movement, "should set movement")
        XCTAssertEqual(workingSet.weight, 25, "should set weight")
        XCTAssertEqual(workingSet.reps, 7, "should set reps")
    }
    
    func test_WorkingSetBelongsToSession() {
        let routine = newRoutine()
        let movement = newMovement()
        let session = Session(routine: routine, realmService: realmService)

        
        let workingSet = WorkingSet(movement: movement, setNumber: 1, weight: 25, reps: 7, session: session, realmService: realmService)
        
        XCTAssertEqual(workingSet.session, session, "should set session")
    }
}
