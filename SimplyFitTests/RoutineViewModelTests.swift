//
//  RoutineViewModel.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/9/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import XCTest
import RealmSwift
@testable import SimplyFit

class RoutineViewModelTests: XCTestCase, RealmTestable {
    
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
    func test_ReturnsProperDescriptionText() {
        // given
        // Create routine
        let routine = newRoutine()
        realmService.commitTransaction {
            // Create exercises
            routine.addExercise(movement: Movement(name: "DB Bench"), repMin: 6, repMax: 8, sets: 3, inRealm: testRealm)
            routine.addExercise(movement: Movement(name: "Bent Over Row"), repMin: 8, repMax: 10, sets: 3, inRealm: testRealm)
        }
        
        
        // when
        let routineViewModel = RoutineViewModel(routine: routine)
        // Check text
        XCTAssertEqual(routineViewModel.descriptionText, "DB Bench x3, Bent Over Row x3")
    }
    
}
