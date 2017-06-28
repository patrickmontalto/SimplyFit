//
//  MovementTests.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import XCTest
import RealmSwift
@testable import SimplyFit

class MovementTests: XCTestCase, RealmTestable {
    
    // MARK: - Properties
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
    /// Creates a new movement Object and adds it to the test realm.
    func newMovement(name: String = "Hammer Curls") -> Movement {
        let movement = Movement(name: name)
        realmService.addObject(movement)
        return movement
    }
    
    /// Creates a new Routine Object and adds it to the test realm.
    func newRoutine(title: String = "Upperbody 1") -> Routine {
        let routine = Routine(title: title)
        realmService.addObject(routine)
        return routine
    }
    
    /// Creates a new Movement Object that has history in 2 sessions.
    func createMovementWithHistory() -> Movement {
        // Create a new routine
        let routine = newRoutine()
        // Create a new movement
        let movement = newMovement()
        // Add a new exercise for that routine
        realmService.commitTransaction {
            routine.addExercise(movement: movement, repMin: 6, repMax: 8, sets: 2, inRealm: testRealm)
        }
        // Create two sessions for the routine
        let session1 = Session(routine: routine, realmService: realmService)
        let session2 = Session(routine: routine, realmService: realmService)
        // Add working sets to the two sessions
        let _ = WorkingSet(movement: movement, setNumber: 1, weight: 30, reps: 8, session: session1, realmService: realmService)
        let _ = WorkingSet(movement: movement, setNumber: 2, weight: 30, reps: 8, session: session1, realmService: realmService)
        let _ = WorkingSet(movement: movement, setNumber: 1, weight: 35, reps: 6, session: session2, realmService: realmService)
        let _ = WorkingSet(movement: movement, setNumber: 2, weight: 37.5, reps: 5, session: session2, realmService: realmService)
        
        return movement
    }
    
    
    // MARK: - Tests
    func test_InitSetsProperties() {
        // given
        let movement = newMovement()
        
        // then
        XCTAssertEqual(movement.name, "Hammer Curls")
    }
    
    func test_MovementHasManySessions() {
        // given
        let movement = createMovementWithHistory()
        
        // then
        XCTAssertEqual(movement.sessions.count, 2, "movement should have sessions")
    }
    
    func test_HistoryReturnsOccurrencesOfMovement() {
        // given
        let movement = createMovementWithHistory()
        
        // when
        let history = movement.movementHistory(inRealm: testRealm)
        
        // then
        print(history.history)
        XCTAssertTrue(history.doesExist(), "movement should have a history")
    }
    
    func test_MovementExistsInRealm() {
        // given
        let movement = newMovement()
        
        // then
        XCTAssertTrue(movement.existsInRealm(testRealm), "object should exist in realm")
    }
    
    func test_UnsavedMovementDoesNotExistInRealm() {
        // given
        let movement = Movement(name: "EZ Bar Curl")
        
        // then
        XCTAssertFalse(movement.existsInRealm(testRealm), "object should not exist in realm")
        
    }
    
}
