//
//  SFSearchBarController.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/13/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

protocol SFSearchBarControllerDelegate: class {
    func searchBarController(_ searchBarController: SFSearchBarController, searchBarDidUpdateWithText searchTerm: String?)
    func searchBarController(_ searchBarController: SFSearchBarController, searchBarDidBecomeActive active: Bool)
}

class SFSearchBarController {
    
    // MARK: - Properties
    
    weak var delegate: SFSearchBarControllerDelegate?
    
    let placeholder: String
    
    lazy var view: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    lazy var searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = UIColor.AppColor.searchBarGray
        searchBar.placeholder = self.placeholder
        searchBar.font = UIFont.preferredFont(forTextStyle: .title3)
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        searchBar.autocapitalizationType = .words
        searchBar.borderStyle = .none
        searchBar.clearButtonMode = .always
        searchBar.layer.cornerRadius = 6
        searchBar.addTarget(self, action: #selector(searchBarTextChanged), for: .editingChanged)
        searchBar.addTarget(self, action: #selector(searchBarBecameActive), for: .editingDidBegin)
        searchBar.addTarget(self, action: #selector(searchBarBecameInactive), for: .editingDidEnd)
        searchBar.addTarget(self, action: #selector(searchBarBecameInactive), for: .editingDidEndOnExit)
        let searchIcon = UIImageView(image: #imageLiteral(resourceName: "search_icon"))
        if let size = searchIcon.image?.size {
            searchIcon.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 20.0, height: size.height)
        }
        searchIcon.contentMode = UIViewContentMode.center
        searchBar.leftView = searchIcon
        searchBar.leftViewMode = UITextFieldViewMode.always

        
        return searchBar
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitleColor(UIColor.AppColor.blue, for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        return cancelButton
    }()
    
    var searchBarTrailingConstraint: NSLayoutConstraint!
    
    init(delegate: SFSearchBarControllerDelegate, placeholder: String?) {
        self.delegate = delegate
        self.placeholder = placeholder ?? ""
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(cancelButton)
        
        NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
        searchBarTrailingConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: searchBar, attribute: .trailing, multiplier: 1, constant: 16)
        searchBarTrailingConstraint.isActive = true
        
        NSLayoutConstraint(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: searchBar, attribute: .trailing, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: cancelButton, attribute: .centerY, relatedBy: .equal, toItem: searchBar, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    // MARK: - Actions
    
    @objc private func searchBarTextChanged() {
        delegate?.searchBarController(self, searchBarDidUpdateWithText: searchBar.text)
    }
    
    @objc private func searchBarBecameActive() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: { [unowned self] in
            self.searchBarTrailingConstraint.constant = self.cancelButton.frame.width + 28
            self.view.layoutIfNeeded()
        })
        
        delegate?.searchBarController(self, searchBarDidBecomeActive: true)
    }
    
    @objc private func searchBarBecameInactive() {
        UIView.animate(withDuration: 0.2) { [unowned self] in
            self.searchBarTrailingConstraint.constant = 16
            self.view.layoutIfNeeded()
        }
        
        delegate?.searchBarController(self, searchBarDidBecomeActive: false)
    }
    
    @objc private func cancelPressed() {
        searchBar.endEditing(true)
    }
    
}

