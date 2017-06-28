//
//  WorkoutViewController.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/8/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit
import RealmSwift

class WorkoutViewController: UIViewController {
    
    @IBOutlet var newRoutineButton: UIButton!
    @IBOutlet var tableViewEditButton: UIButton!
    @IBOutlet var tableViewTitleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewTopSeparatorConstraint: NSLayoutConstraint!
    @IBOutlet var tableViewTopSeparator: UIView!
    private(set) var routines: Results<Routine>!
    let realmService = RealmService()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Move this responsibility to the AppViewController
        routines = realmService.realm.objects(Routine.self)
            .filter("archived == %@", false)
            .sorted(byKeyPath: "title", ascending: true)
        
        configureTableView()
        configureNewRoutineButton()
        
        createRoutine()
    }
    
    
    // FIXME: Remove this
    private func createRoutine() {
        let routine = Routine(title: "Upperbody 3")
        if routine.existsInRealm(realmService.realm) { return }
        realmService.addObject(routine)
        
        realmService.commitTransaction {
            // Create exercises
            routine.addExercise(movement: Movement(name: "DB Bench"), repMin: 6, repMax: 8, sets: 3, inRealm: realmService.realm)
            routine.addExercise(movement: Movement(name: "Bent Over Row"), repMin: 8, repMax: 10, sets: 3, inRealm: realmService.realm)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false

    }
    
    
    // MARK: - Initial setup
    private func configureTableView() {
        tableViewTopSeparator.backgroundColor = tableView.separatorColor
        tableViewTopSeparatorConstraint.constant = 1.0 / UIScreen.main.scale
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: WorkoutTableViewCell.reuseIdentifier)
        
        // Configure edit button
        tableViewEditButton.setTitleColor(UIColor.AppColor.blue, for: .normal)
        tableViewEditButton.addTarget(self, action: #selector(toggleEdit(sender:)), for: .touchUpInside)
    }
    
    private func configureNewRoutineButton() {
        newRoutineButton.setTitleColor(UIColor.AppColor.blue, for: .normal)
        newRoutineButton.addTarget(self, action: #selector(newRoutineButtonPressed(sender:)), for: .touchUpInside)
    }
    
    
    @objc private func toggleEdit(sender: UIButton) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        // Implement the same Edit/Done button behavior as in the Apple Music app
        if tableView.isEditing {
            tableViewEditButton.setTitle("Done", for: .normal)
        } else {
            UIView.transition(with: tableViewEditButton, duration: 0.4, options: .transitionFlipFromLeft, animations: { [unowned self] in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [unowned self] in
                    self.tableViewEditButton.layer.removeAllAnimations()
                })
                self.tableViewEditButton.setTitle("Edit", for: .normal)
                }, completion: nil)
        }
        
        
    }
    
    @objc private func newRoutineButtonPressed(sender: UIButton) {
        // Notify AppViewController to present NewRoutineViewController as modal
        NotificationCenter.default.post(name: .presentNewRoutineViewControllerNotification, object: nil)
    }
}

// MARK: - UITableViewDelegate & DataSource
extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.reuseIdentifier, for: indexPath) as! WorkoutTableViewCell
        
        cell.viewModel = RoutineViewModel(routine: routines[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let archiveAction = UITableViewRowAction(style: .normal, title: "Archive") { [weak self](action, indexPath) in
            guard let strongSelf = self else { return }
            // TODO: Ask user if they want to archive this routine
            print("archiving!")
            
            // Archive the routine
            let routine = strongSelf.routines[indexPath.row]
            strongSelf.realmService.commitTransaction {
                routine.archive(true)
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        archiveAction.backgroundColor = UIColor.AppColor.blue
        
        
        return [archiveAction]
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 
//    }
    
    
//    // Hide the default edit control
//    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
}

