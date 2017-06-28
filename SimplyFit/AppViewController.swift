//
//  AppViewController.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

/// The initial view controller for the app.
/// Acts as a container for all other view controllers.
/// Observes authenication status changes and presents the appropriate views in response
/// to those changes.
///
/// Intended to always be in-memory.
class AppViewController: UIViewController {
    
    let appTabBarController = AppTabBarController()
    
    private lazy var behavior: ChildViewControllerBehavior = {
        ChildViewControllerBehavior(parentViewController: self)
    }()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initially display the app tab bar controller
        behavior.view.frame = view.bounds
        behavior.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(behavior.view)
        
        behavior.childViewController = appTabBarController
        
        // Add notification observers
        observeNotifications()
        
    }
    
    // MARK: - Add observers
    private func observeNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(presentNewRoutineViewController), name: .presentNewRoutineViewControllerNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentAddExercisesViewController(_:)), name: .presentAddExercisesViewControllerNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentNewMovementViewController(_:)), name: .presentNewMovementViewControllerNotification, object: nil)
    }
    
    /// Present a view controller to add a new routine.
    @objc private func presentNewRoutineViewController() {
        let newRoutineViewController = NewRoutineViewController()
        present(newRoutineViewController, animated: true, completion: nil)
    }
    
    /// Present a view controller modally to add new exercises to a routine.
    @objc private func presentAddExercisesViewController(_ notification: NSNotification) {
        guard let addExercisesViewControllerDelegate = notification.userInfo?[Constant.Key.addExercisesViewControllerDelegate] as? AddExercisesViewControllerDelegate else {
            preconditionFailure("An AddExercisesViewControllerDelegate must be passed in to presentAddExercisesViewController notification")
        }
        let addExercisesViewController = AddExercisesViewController()
        addExercisesViewController.delegate = addExercisesViewControllerDelegate
        
        UIApplication.topViewController()?.present(addExercisesViewController, animated: true)
    }
    
    /// Present a view controller over the current context to create a new movement.
    @objc private func presentNewMovementViewController(_ notification: NSNotification) {
        guard let newMovementViewControllerDelegate = notification.userInfo?[Constant.Key.newMovementViewControllerDelegate] as? NewMovementViewControllerDelegate else {
            preconditionFailure("A NewMovementViewControllerDelegate must be passed in to presentNewMovementViewController notification")
        }
        let newMovementViewController = NewMovementViewController()
        newMovementViewController.modalPresentationStyle = .overCurrentContext
        newMovementViewController.delegate = newMovementViewControllerDelegate
        newMovementViewController.realmService = RealmService()
        
        UIApplication.topViewController()?.present(newMovementViewController, animated: false)
    }
    
}

