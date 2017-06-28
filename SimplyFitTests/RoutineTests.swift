//
//  RoutineTests.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import XCTest
import RealmSwift
@testable import SimplyFit

class RoutineTests: XCTestCase, RealmTestable {
    
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
    
    /// Creates a new Routine Object and adds it to the test realm.
    func newRoutine(title: String = "Upperbody 1") -> Routine {
        let routine = Routine(title: title)
        realmService.addObject(routine)
        return routine
    }
    
    // MARK: - Tests
    
    func test_InitWhenGivenTitleSetsTitle() {
        // given/when
        let routine = newRoutine()
        
        // then
        XCTAssertEqual(routine.title, "Upperbody 1", "should set title")
    }
    
    func test_CanAddNewExercise() {
        // given
        let routine = newRoutine()
        let movement = Movement(name: "Hammer Curls")
        // when
        realmService.commitTransaction {
            routine.addExercise(movement: movement, repMin: 6, repMax: 8, sets: 4, inRealm: testRealm)
        }
        
        // then
        XCTAssertNotNil(routine.exercises.first, "should add new exercise")
        XCTAssertEqual(routine.exercises.first!.movementName, "Hammer Curls", "should set new exercise name")
        XCTAssertEqual(routine.exercises.first!.repMin, 6, "should set new exercise rep min")
        XCTAssertEqual(routine.exercises.first!.repMax, 8, "should set new exercise rep max")
        XCTAssertEqual(routine.exercises.first!.sets, 4, "should set new exercise sets")
    }
    
    func test_DeletingRoutineDeletesExercises() {
        // given 
        let routine = newRoutine()
        let movement = Movement(name: "Hammer Curls")
        realmService.commitTransaction {
            routine.addExercise(movement: movement, repMin: 6, repMax: 8, sets: 4, inRealm: testRealm)
        }
        
        // when
        realmService.removeObject(routine)
        
        // then
        XCTAssertEqual(testRealm.objects(Exercise.self).count, 0, "should delete exercise when routine is deleted")
    }
    
    func test_RoutineExistsInRealm() {
        // given
        let routine = newRoutine()
        
        // then
        XCTAssertTrue(routine.existsInRealm(testRealm), "routine should exist in realm")
    }
    
    func test_UnsavedRoutineShouldNotExistInRealm() {
        // given
        let routine = Routine(title: "Upperbody 1")
        
        // then
        XCTAssertFalse(routine.existsInRealm(testRealm), "routine should not exist in realm")
    }
    
}
