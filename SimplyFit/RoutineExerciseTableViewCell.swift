//
//  RoutineExerciseTableViewCell.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/12/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

class RoutineExerciseTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: RoutineExerciseTableViewCell.self)
    
    // MARK: - Properties
    
    @IBOutlet var movementNameLabel: UILabel!
    @IBOutlet var repMinTextField: UITextField!
    @IBOutlet var repMaxTextField: UITextField!
    @IBOutlet var setTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // TODO: UITextField Delegate (return key to next textField)
        repMinTextField.tag = 0
        repMaxTextField.tag = 1
        setTextField.tag = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
