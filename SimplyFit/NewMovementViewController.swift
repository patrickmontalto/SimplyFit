//
//  NewMovementViewController.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/13/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

class NewMovementViewController: WindowableViewController {
    
    // MARK: - Properties
    var realmService: RealmService!
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.AppColor.blue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor.AppColor.detailGray, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    lazy var movementNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.placeholder = "E.g. Bicep Curl"
        textField.autocapitalizationType = .words
        textField.addTarget(self, action: #selector(movementNameTextFieldChanged), for: .editingChanged)
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.delegate = self
        return textField
    }()
    
    weak var delegate: NewMovementViewControllerDelegate?
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Movement"
        configureWindowView()
        
        addKeyboardObservers(showSelector: #selector(keyboardWillShow), hideSelector: #selector(keyboardWillHide))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        movementNameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Configure UI
    private func configureWindowView() {
        // Add save button and text field to the view
        windowView.clipsToBounds = true
        
        let lineViewTop = LineView()
        let lineViewBottom = LineView()
        
        windowView.addSubview(saveButton)
        windowView.addSubview(movementNameTextField)
        windowView.addSubview(lineViewTop)
        windowView.addSubview(lineViewBottom)
        
        // Constraints
        NSLayoutConstraint(item: saveButton, attribute: .bottom, relatedBy: .equal, toItem: windowView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: saveButton, attribute: .leading, relatedBy: .equal, toItem: windowView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: saveButton, attribute: .trailing, relatedBy: .equal, toItem: windowView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: movementNameTextField, attribute: .leading, relatedBy: .equal, toItem: windowView, attribute: .leading, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: movementNameTextField, attribute: .centerY, relatedBy: .equal, toItem: windowView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: windowView, attribute: .trailing, relatedBy: .equal, toItem: movementNameTextField, attribute: .trailing, multiplier: 1.0, constant: 8).isActive = true
        
        NSLayoutConstraint(item: lineViewTop, attribute: .leading, relatedBy: .equal, toItem: movementNameTextField, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: lineViewTop, attribute: .trailing, relatedBy: .equal, toItem: movementNameTextField, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: movementNameTextField, attribute: .top, relatedBy: .equal, toItem: lineViewTop, attribute: .top, multiplier: 1, constant: 16).isActive = true
        
        NSLayoutConstraint(item: lineViewBottom, attribute: .leading, relatedBy: .equal, toItem: movementNameTextField, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: lineViewBottom, attribute: .trailing, relatedBy: .equal, toItem: movementNameTextField, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: lineViewBottom, attribute: .top, relatedBy: .equal, toItem: movementNameTextField, attribute: .bottom, multiplier: 1, constant: 16).isActive = true
    }
    
    
    // MARK: - Actions
    
    @objc private func savePressed() {
        // Check if movement already exists in realm
        guard let movementName = movementNameTextField.text else {
            // TODO: Alert user: please enter a valid name
            return
        }
        
        let movement = Movement(name: movementName)
        
        guard !movement.existsInRealm(realmService.realm) else {
            // TODO: Alert user: Movement already exists!
            return
        }
        
        realmService.addObject(movement)
        
        delegate?.newMovementViewController(self, didFinishCreatingMovement: movement)
    }
    
    @objc private func movementNameTextFieldChanged() {
        saveButton.isEnabled = movementNameTextField.hasText
    }
    
    @objc private func keyboardWillShow() {
        slideView(view, inDirection: .up, offset: 100)
        
    }
    
    @objc private func keyboardWillHide() {
        slideView(view, inDirection: .down, offset: 100)
    }
    
}

extension NewMovementViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
