//
//  RealmServiceTests.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import XCTest
import RealmSwift
@testable import SimplyFit

class RealmServiceTests: XCTestCase, RealmTestable {
    
    var testRealm: Realm!
    var realmService: RealmService!
    
    override func setUp() {
        super.setUp()
        
        // Create in-memory test realm
        testRealm = prepareTestRealm(inMemoryIdentifier: "realm-service-tests")
        
        // Create RoutineService object
        realmService = RealmService(realm: testRealm)
    }
    
    override func tearDown() {
        // Wipe the realm after each test
        wipeRealm(testRealm)
        super.tearDown()
    }

    // MARK: - Helpers
    
    func newRoutine() -> Routine {
        return Routine(title: "Lowerbody 1")
    }
    
    // MARK: - Tests
    
    func test_AddEmptyRoutineToTheReam() {
        // given
        let routine = newRoutine()
        
        // when
        realmService.addObject(routine)
        
        // then
        XCTAssertEqual(testRealm.objects(Routine.self).count, 1, "should add routine to the realm")
    }
    
    func test_EmptyRemoveRoutineFromRealm() {
        // given
        let routine = newRoutine()
        realmService.addObject(routine)
        
        // when
        realmService.removeObject(routine)
        
        // then
        XCTAssertEqual(testRealm.objects(Routine.self).count, 0, "should remove routine from the realm")
    }

    
    
}
