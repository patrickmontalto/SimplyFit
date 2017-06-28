//
//  ChildViewControllerBehavior.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

/// A behavior that allows you to add basic child view controller containment
/// to any view controller class. Add the `view` as a descendent of the
/// `parentViewController`'s view and assign a value to `childViewController`
/// to install a child.
public final class ChildViewControllerBehavior {
    
    // MARK: - Properties
    /// The view in which all children of this behavior will be installed.
    public let view = UIView()
    
    private unowned let parentViewController: UIViewController
    
    /// The child view controller that will be installed.
    public var childViewController: UIViewController? {
        willSet {
            guard let childViewController = childViewController else {
                return
            }
            childViewController.willMove(toParentViewController: nil)
            childViewController.viewIfLoaded?.removeFromSuperview()
            childViewController.removeFromParentViewController()
        }
        didSet {
            guard let childViewController = childViewController else {
                return
            }
            
            parentViewController.addChildViewController(childViewController)
            
            childViewController.view.frame = view.bounds
            childViewController.view.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
            view.addSubview(childViewController.view)
            
            childViewController.didMove(toParentViewController: parentViewController)
        }
    }
    
    
    // MARK: - Initializers
    /// Create a behavior that manages a single child view controller of the
    /// given view controller.
    ///
    /// - parameter parentViewController: The view controller for which children
    ///     will be managed. The returned object will maintain an unowned
    ///     reference to the view controller.
    public init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
}
