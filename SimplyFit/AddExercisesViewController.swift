//
//  AddExercisesViewController.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/11/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit
import RealmSwift


class AddExercisesViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: AddExercisesViewControllerDelegate?
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var newMovementButton: UIBarButtonItem!
    @IBOutlet var searchBarContainerView: UIView!
    @IBOutlet var movementsTableView: UITableView!
    @IBOutlet var instructionsLabel: UILabel!
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var addMovementButton: UIButton!
    @IBOutlet var supersetButton: UIButton!
    @IBOutlet var stackViewBottomConstraint: NSLayoutConstraint!
    
    var routineName: String?
    
    lazy var searchBarController: SFSearchBarController = {
        let controller = SFSearchBarController(delegate: self, placeholder: "Movements")
        
        return controller
    }()
    
    var searchResultsController: SearchResultsController<Movement>!
    
    private var selectedMovements: [Movement] {
        return searchResultsController.selectedData
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial view and action configuration
        configureButtonTargets()
        configureButtonAppearances()
        configureSearchBar()
        
        // Edit instructions label
        instructionsLabel.text = "Add Exercises to \(routineName ?? "New Routine")"

        movementsTableView.allowsMultipleSelection = true
        
        navigationBar.backgroundColor = .white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()

        // Configure searchResultsController
        searchResultsController = SearchResultsController<Movement>(delegate: self, tableView: self.movementsTableView, realmService: RealmService())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers(showSelector: #selector(keyboardWillShow(_:)), hideSelector: #selector(keyboardWillHide(_:)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    
    private func configureSearchBar() {
        searchBarContainerView.addSubview(searchBarController.view)
        NSLayoutConstraint(item: searchBarController.view, attribute: .leading, relatedBy: .equal, toItem: searchBarContainerView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: searchBarController.view, attribute: .trailing, relatedBy: .equal, toItem: searchBarContainerView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: searchBarController.view, attribute: .top, relatedBy: .equal, toItem: searchBarContainerView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: searchBarController.view, attribute: .bottom, relatedBy: .equal, toItem: searchBarContainerView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    private func configureButtonTargets() {
        // Configure navbar buttons
        cancelButton.action = #selector(cancelPressed)
        newMovementButton.action = #selector(newMovementPressed)
        
        // Add targets for bottom buttons
        addMovementButton.addTarget(self, action: #selector(addMovementPressed), for: .touchUpInside)
        supersetButton.addTarget(self, action: #selector(supersetPressed), for: .touchUpInside)
    }
    
    private func configureButtonAppearances() {
        // Navbar buttons
        cancelButton.tintColor = UIColor.AppColor.blue
        newMovementButton.tintColor = UIColor.AppColor.blue
        
        
        // Bottom buttons
        supersetButton.isEnabled = false
        addMovementButton.isEnabled = false
        
        supersetButton.setTitleColor(UIColor.AppColor.detailGray, for: .disabled)
        addMovementButton.setTitleColor(UIColor.AppColor.detailGray, for: .disabled)
        
        supersetButton.setTitleColor(.white, for: .normal)
        addMovementButton.setTitleColor(.white, for: .normal)
        
        supersetButton.backgroundColor = UIColor.darkGray 
        addMovementButton.backgroundColor = UIColor.AppColor.blue
        
    }
    
    @objc private func cancelPressed() {
        dismiss(animated: true)
    }
    
    @objc private func newMovementPressed() {
        // Notify the AppViewController to present the NewMovementViewController
        NotificationCenter.default.post(name: .presentNewMovementViewControllerNotification, object: nil, userInfo: [Constant.Key.newMovementViewControllerDelegate: self])
    }
    
    @objc private func addMovementPressed() {
        // TODO: Implement
        delegate?.addExercisesViewController(self, didAddMovements: selectedMovements)
        
    }
    
    @objc private func supersetPressed() {
        // TODO: Implement
        delegate?.addExercisesViewController(self, didAddSupersetMovements: selectedMovements)
    }
    
    // MARK: - Keyboard
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.2) {
            let offset = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! CGRect
            self.stackViewBottomConstraint.constant = offset.height - (self.movementsTableView.frame.origin.y - 20)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.2) { 
            self.stackViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func updateButtonLabels(withCount count: Int) {
        var addMovementsText: String
        var supersetText: String
        switch count {
        case 0:
            addMovementsText = "Add Movement"
            supersetText = "Superset"
        case 1:
            addMovementsText = "Add Movement (1)"
            supersetText = "Superset (1)"
        default:
            addMovementsText = "Add Movements (\(count))"
            supersetText = "Superset (\(count))"
        }
        
        UIView.performWithoutAnimation {
            self.addMovementButton.setTitle(addMovementsText, for: .normal)
            self.supersetButton.setTitle(supersetText, for: .normal)
            
            // Toggle enable/disable
            self.toggleButtons(count > 0)
        }
        
        
    }
    
    private func toggleButtons(_ enabled: Bool) {
        addMovementButton.isEnabled = enabled
        supersetButton.isEnabled = enabled
    }
}


// MARK: - SFSearchBarControllerDelegate
extension AddExercisesViewController: SFSearchBarControllerDelegate {
    func searchBarController(_ searchBarController: SFSearchBarController, searchBarDidBecomeActive active: Bool) {
        let offset = movementsTableView.frame.origin.y - 20
        if active {
           slideView(view, inDirection: .up, duration: 0.2, offset: offset)
        } else {
            UIView.animate(withDuration: 0.2) { [unowned self] in
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func searchBarController(_ searchBarController: SFSearchBarController, searchBarDidUpdateWithText searchTerm: String?) {
        // Filter the data using the searchResultsController to update the tableview
        let searchText = searchTerm ?? ""
        _ = searchResultsController.filterData(searchTerm: searchText)
    }
}

// MARK: - SearchResultsDelegate
extension AddExercisesViewController: SearchResultsDelegate {
    func searchResultsController<T>(_ searchResultsController: SearchResultsController<T>, didSelectObjects objects: [T]) where T : Object, T : SearchableObject {
        updateButtonLabels(withCount: searchResultsController.selectedData.count)
    }
}

// MARK: - NewMovementViewControllerDelegate
extension AddExercisesViewController: NewMovementViewControllerDelegate {
    func newMovementViewController(_ controller: NewMovementViewController, didFinishCreatingMovement movement: Movement) {
        // Refilter the data
        let searchText = searchBarController.searchBar.text ?? ""
        _ = searchResultsController.filterData(searchTerm: searchText)
        // Dismiss the new movement view controller
        controller.dismiss()
    }
}
