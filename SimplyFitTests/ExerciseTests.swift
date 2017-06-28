//
//  ExerciseTests.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import XCTest
@testable import SimplyFit

class ExerciseTests: XCTestCase {
    
    // MARK: - Setup/teardown
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Helpers
    
    
    
    // MARK: - Tests
    func test_InitWithMovementSetsProperties() {
        let movement = Movement(name: "Hammer Curls")
        let exercise = Exercise(movement: movement, repMin: 6, repMax: 8, sets: 4)
        
        XCTAssertEqual(exercise.movementName, "Hammer Curls", "should set movement name")
        XCTAssertEqual(exercise.repMin, 6, "should set minimum reps")
        XCTAssertEqual(exercise.repMax, 8, "should set maximum reps")
        XCTAssertEqual(exercise.sets, 4, "should set exercise sets")
    }
    
}
