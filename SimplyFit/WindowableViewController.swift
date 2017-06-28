//
//  WindowableViewController.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/14/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

/// Abstract base class. Subclass this to implement a WindowableViewController
/// Customize by adding controls and buttons to the windowView.
///
/// The windowView by default comes with a cancelButton and a titleLabel.
class WindowableViewController: UIViewController {
    
    // MARK: - Properties
    lazy var windowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.0
        return view
    }()
    
    var windowViewHeight: CGFloat = 200.0
    
    var windowViewOffset: CGFloat {
        return self.view.frame.height / 2.0 + self.windowViewHeight / 2.0
    }
    
    lazy var windowViewCenterYConstraint: NSLayoutConstraint = {
        return NSLayoutConstraint(item: self.windowView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: self.windowViewOffset)
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "Cancel_X"), for: .normal)
        button.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var blurView: UIView = {
        let blurView = UIView()
        blurView.frame = self.view.frame
        blurView.alpha = 0
        blurView.backgroundColor = UIColor.AppColor.detailGray
        return blurView
        
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.title
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    override var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Fade in the blur view
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.blurView.alpha = 0.6
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.windowViewCenterYConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    
    // MARK: - UISetup
    private func setupUI() {
        view.backgroundColor = UIColor.clear
        
        
        view.addSubview(blurView)
        view.addSubview(windowView)
        windowView.addSubview(cancelButton)
        windowView.addSubview(titleLabel)
        
        windowView.layer.cornerRadius = 8
    
        // Constraints
        NSLayoutConstraint(item: windowView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: windowViewHeight).isActive = true
        NSLayoutConstraint(item: windowView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 24).isActive = true
        windowViewCenterYConstraint.isActive = true
        NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: windowView, attribute: .trailing, multiplier: 1.0, constant: 24).isActive = true
        
        NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: windowView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: windowView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        
        NSLayoutConstraint(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: windowView, attribute: .leading, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: cancelButton, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
    }
    
    // MARK: - Actions
    @objc private func cancelPressed() {
        dismiss()
    }
    
    func dismiss() {
        windowViewCenterYConstraint.constant = windowViewOffset
        view.endEditing(true)
        // Fade out the blur view
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.blurView.alpha = 0.0
            self.view.layoutIfNeeded()
            }, completion: { [unowned self] (completed) in
                self.dismiss(animated: true, completion: nil)
        })
    }
}
