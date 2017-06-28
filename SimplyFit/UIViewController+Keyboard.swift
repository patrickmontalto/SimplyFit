//
//  UIViewController+Keyboard.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/11/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

enum UIViewSlideDirection {
    case up, down
}

extension UIViewController {
    
    /// Add observers for when keboard will show and hide.
    func addKeyboardObservers(showSelector: Selector, hideSelector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: showSelector, name: NSNotification.Name.UIKeyboardWillShow, object: object)
        NotificationCenter.default.addObserver(self, selector: hideSelector, name: NSNotification.Name.UIKeyboardWillHide, object: object)
    }
    
    /// Call this function to enable hiding the keyboard when the user taps around in the view.
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// End editing on the view controller's view.
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Slide the view controller's view in a given direction
    func slideView(_ viewToSlide: UIView, inDirection direction: UIViewSlideDirection, duration: TimeInterval = 0.5, offset: CGFloat) {
        let yOriginOffset = direction == .up ? -offset : offset
        
        UIView.animate(withDuration: duration, animations: {
            var frame = viewToSlide.frame
            frame.origin.y += yOriginOffset
            viewToSlide.frame = frame
            viewToSlide.layoutIfNeeded()
        })
    }
}
