//
//  SessionTests.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import XCTest
import RealmSwift
@testable import SimplyFit

class SessionTests: XCTestCase, RealmTestable {
    
    var testRealm: Realm!
    var realmService: RealmService!
    
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
    
    func createSessionWithWorkingSets() -> Session {
        // given
        let routine = newRoutine()
        let session = Session(routine: routine, realmService: realmService)
        let movement = Movement(name: "Hammer Curls")
        
        // when
        let _ = WorkingSet(movement: movement, setNumber: 1, weight: 25, reps: 7, session: session, realmService: realmService)
        let _ = WorkingSet(movement: movement, setNumber: 2, weight: 25, reps: 7, session: session, realmService: realmService)

        return session
    }
    
    // MARK: - Tests
    
    func test_SessionBelongsToRoutine() {
        // given
        let routine = newRoutine()
        let session = Session(routine: routine, realmService: realmService)
        
        // then
        XCTAssertEqual(session.routine, routine, "should set routine")
        XCTAssertEqual(routine.sessions.first!, session, "should set session on routine")
    }
    
    func test_DeletingSessionRemovesItFromRoutine() {
        // given
        let routine = newRoutine()
        let session = Session(routine: routine, realmService: realmService)
        
        // when
        realmService.removeObject(session)
        
        // then
        XCTAssertEqual(routine.sessions.count, 0, "should remove session from routine upon deletion.")
    }
    
    func test_DeletingRoutineDeletesSessions() {
        // given
        let routine = newRoutine()
        let _ = [Session(routine: routine, realmService: realmService),
                 Session(routine: routine, realmService: realmService)]
        
        // when
        realmService.removeObject(routine)
        
        // then
        XCTAssertEqual(testRealm.objects(Session.self).count, 0, "should delete all sessions from realm when their routine is deleted.")
    }
    
    func test_SessionHasMultipleSets() {
        // given
        let session = createSessionWithWorkingSets()
        
        // then
        XCTAssertEqual(session.sets.count, 2, "should add sets to the session")
    }
    
    func test_DeleteSessionDeletesWorkingSets() {
        // given
        let session = createSessionWithWorkingSets()
        
        // when
        realmService.removeObject(session)
        
        // then
        XCTAssertEqual(testRealm.objects(WorkingSet.self).count, 0, "should remove working sets when session is removed.")
        
    }
    
}
