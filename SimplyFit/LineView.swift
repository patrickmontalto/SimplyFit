//
//  LineView.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/14/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.AppColor.detailGray
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
