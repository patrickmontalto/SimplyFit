//
//  WorkoutTableViewCell.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/9/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: WorkoutTableViewCell.self)
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)
        label.textColor = UIColor.AppColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.AppColor.detailGray
        return label
    }()
    
    let archiveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.AppColor.blue
        return button
    }()
    
    var viewModel: RoutineViewModel! {
        didSet {
            titleLabel.text = viewModel.titleText
            detailLabel.text = viewModel.descriptionText
        }
    }
    
    var archiving = false
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: detailLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: detailLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: detailLabel, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: detailLabel, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
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
            titleLabel.textColor = .white
            detailLabel.textColor = .white
        } else {
            contentView.backgroundColor = .white
            titleLabel.textColor = UIColor.AppColor.blue
            detailLabel.textColor = UIColor.AppColor.detailGray
        }
    }
    
    
}
