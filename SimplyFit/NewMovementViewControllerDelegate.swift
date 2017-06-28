//
//  NewMovementViewControllerDelegate.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/13/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation

protocol NewMovementViewControllerDelegate: class {
    func newMovementViewController(_ controller: NewMovementViewController, didFinishCreatingMovement movement: Movement)
}

