//
//  AddExercisesViewControllerDelegate.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/13/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import RealmSwift

protocol AddExercisesViewControllerDelegate: class {
    func addExercisesViewController(_ addExercisesViewController: AddExercisesViewController, didAddMovements movements: [Movement])
    
    func addExercisesViewController(_ addExercisesViewController: AddExercisesViewController, didAddSupersetMovements movements: [Movement])
}
