//
//  NewRoutineViewController.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/10/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

class NewRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var routineNameTextField: UITextField!
    @IBOutlet var routineTableView: UITableView!

    @IBOutlet var addExercisesButton: UIButton!
    @IBOutlet var saveRoutineButton: UIButton!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationSetup()
        
        routineButtonsSetup()
        
        routineNameTextField.borderStyle = .none
        routineNameTextField.autocapitalizationType = .words
        routineNameTextField.delegate = self
        routineNameTextField.addTarget(self, action: #selector(routineNameTextFieldChanged), for: .editingChanged)
    }
    
    private func navigationSetup() {
        navigationBar.backgroundColor = .white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        cancelButton.tintColor = UIColor.AppColor.blue
        editButton.tintColor = UIColor.AppColor.blue
        
        editButton.action = #selector(toggleEdit)
        cancelButton.action = #selector(cancel)
    }
    
    private func routineButtonsSetup() {
        addExercisesButton.setTitleColor(UIColor.AppColor.blue, for: .normal)
        saveRoutineButton.setTitleColor(UIColor.AppColor.blue, for: .normal)
        saveRoutineButton.setTitleColor(.gray, for: .disabled)
        saveRoutineButton.isEnabled = false
        
        addExercisesButton.addTarget(self, action: #selector(addExercisesPressed), for: .touchUpInside)
        saveRoutineButton.addTarget(self, action: #selector(saveRoutinePressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func toggleEdit() {
        // TODO: Enable deleting exercises from the routine.
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addExercisesPressed() {        
        // Notify the AppViewController to present the AddExercisesViewController
        NotificationCenter.default.post(name: .presentAddExercisesViewControllerNotification, object: nil, userInfo: [Constant.Key.addExercisesViewControllerDelegate: self])
    }
    
    @objc private func saveRoutinePressed() {
        // TODO: Save the routine if the name and all fields are filled out completely.
    }
    
    // TODO: This needs to be implemented for every single cell (exercise)
    @objc private func routineNameTextFieldChanged() {
        saveRoutineButton.isEnabled = routineNameTextField.hasText
    }
}

// MARK: - UITextFieldDelegate
extension NewRoutineViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - AddExercisesViewControllerDelegate 
extension NewRoutineViewController: AddExercisesViewControllerDelegate {
    func addExercisesViewController(_ addExercisesViewController: AddExercisesViewController, didAddMovements movements: [Movement]) {
        // TODO: Implement
        print(movements)
        
    }
    
    func addExercisesViewController(_ addExercisesViewController: AddExercisesViewController, didAddSupersetMovements movements: [Movement]) {
        // TODO: Implement
    }
}
