//
//  Notification+Custom.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/10/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let presentNewRoutineViewControllerNotification = Notification.Name("presentNewRoutineViewControllerNotification")
    static let presentAddExercisesViewControllerNotification = Notification.Name("presentAddExercisesViewControllerNotification")
    static let presentNewMovementViewControllerNotification = Notification.Name("presentNewMovementViewControllerNotification")
    static let windowableViewControllerDidDismissNotification = Notification.Name("windowableViewControllerDidDismissNotification")
    static let windowableViewControllerWillPresentNotification = Notification.Name("windowableViewControllerWillPresentNotification")
}
