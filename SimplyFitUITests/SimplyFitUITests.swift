//
//  SimplyFitUITests.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import XCTest

class SimplyFitUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("-UseInMemoryRealm")
        app.launch()
    }
    
    // MARK: - Helpers
    func navigateToNewRoutineScreen() {
        let newRoutineButton = app.buttons["Create New Routine"]
        newRoutineButton.tap()
    }
    
    func test_AppLaunchesAtWorkoutScreenWithTabBar() {
        // View title contents
        let myRoutinesText = app.staticTexts["My Routines"]
        // Tab bar contents
        let historyText = app.tabBars.buttons["History"]
        let workoutText = app.tabBars.buttons["Workout"]
        let profileText = app.tabBars.buttons["Profile"]
        
        
        XCTAssertEqual(app.tabBars.count, 1, "should present with a tab bar")
        XCTAssertTrue(historyText.exists, "should launch with history on tab bar")
        XCTAssertTrue(workoutText.exists, "should launch with workout on tab bar")
        XCTAssertTrue(profileText.exists, "should launch with profile on tab bar")
        XCTAssertTrue(myRoutinesText.exists, "should launch with routines screen")
    }
    
    // TODO: Implement full-functionality for scenarios
    func test_WorkoutScreenHasNewRoutineButton() {
        navigateToNewRoutineScreen()
        
        let newRoutineTitle = app.navigationBars["New Routine"]
        
        XCTAssertTrue(newRoutineTitle.exists, "should have new routine title on view controller")
    }
    
    func test_CanCreateNewRoutineWithExercise() {
        navigateToNewRoutineScreen()
        
        // Name the routine
        let routineNameTextField = app.textFields["Routine Name"]
        routineNameTextField.tap()
        routineNameTextField.typeText("Test Routine\n")
    
        // Add new exercise
        let addExercisesButton = app.buttons["Add Exercises"]
        addExercisesButton.tap()
        
        // Create a new movement
        let newMovementButton = app.buttons["New"]
        newMovementButton.tap()
        
        // Enter movement name
        let movementNameTextField = app.textFields["E.g. Bicep Curl"]
        // Keyboard should be active
        // Fill out textfield
        movementNameTextField.typeText("Lat Pulldown")
        
        // Save movement
        let saveButton = app.buttons["Save"]
        saveButton.tap()
        
        // Select movement from list
        let latPulldownCell = app.tables.cells.staticTexts["Lat Pulldown"]
        latPulldownCell.tap()
            
        // Add to routine
        let addMovementButton = app.buttons["Add Movement (1)"]
        addMovementButton.tap()
        
        // Fill out cell for Lat Pulldown
        let repMinTextField = app.tables.cells.matching(identifier: "0-repMin").element
        let repMaxTextField = app.tables.cells.matching(identifier: "0-repMax").element
        let setsTextField = app.tables.cells.matching(identifier: "0-sets").element
        
        repMinTextField.tap()
        repMinTextField.typeText("6\n")
        repMaxTextField.typeText("8\n")
        setsTextField.typeText("4")
        
        // Save routine
        let saveRoutineButton = app.buttons["Save Routine"]
        saveRoutineButton.tap()
        
        let myRoutinesText = app.staticTexts["My Routines"]
        let testRoutineCell = app.tables.cells.matching(identifier: "Test Routine").element
        
        XCTAssertTrue(myRoutinesText.exists, "should return to routines screen upon success")
        XCTAssertTrue(testRoutineCell.exists, "should successfully create a new routine")
    }
    
    func test_NewRoutineScreenHasAddExercisesAndSaveRoutineButton() {
        navigateToNewRoutineScreen()
        
        let addExercisesButton = app.buttons["Add Exercises"]
        let saveRoutineButton = app.buttons["Save Routine"]
        
        XCTAssertTrue(addExercisesButton.exists)
        XCTAssertTrue(saveRoutineButton.exists)
    }
}
