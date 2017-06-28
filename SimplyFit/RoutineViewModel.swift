//
//  RoutineViewModel.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/19/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation

struct RoutineViewModel {
    private let routine: Routine
    
    var titleText: String {
        return self.routine.title
    }
    
    var descriptionText: String {
        // For each exercise in the routine...
        var text = [String]()
        for exercise in routine.exercises {
            text.append("\(exercise.movementName) x\(exercise.sets)")
        }
        return text.joined(separator: ", ")
    }
    
    init(routine: Routine) {
        self.routine = routine
    }
    

}
