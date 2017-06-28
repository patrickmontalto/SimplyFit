//
//  SearchResultsTableViewCell.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/12/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: SearchResultsTableViewCell.self)
    
    // MARK: - Properties
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = UIColor.AppColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: nameLabel, attribute: .trailing, multiplier: 1.0, constant: 16).isActive = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            contentView.backgroundColor = UIColor.AppColor.blue
            nameLabel.textColor = .white
        } else {
            contentView.backgroundColor = .white
            nameLabel.textColor = UIColor.AppColor.blue
        }
    }
    
}
