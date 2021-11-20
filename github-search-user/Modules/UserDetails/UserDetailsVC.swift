//
//  UserDetailsVC.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class UserDetailsVC: UIViewController {
    var presentor: UserDetailsViewToPresenterProtocol?
    public var delegate: UserDetailsDelegate!
    
    var indexPath: IndexPath?
    
    var modeEdit: Bool = false
    
    let nameLabel: UILabel = UILabel()
        .configure { v in
            v.text = "Name"
            v.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let nameTextfield: UITextField = UITextField()
        .configure { v in
            v.placeholder = "Type name here..."
            v.backgroundColor = .white
            v.layer.cornerRadius = 13
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
            v.leftViewMode = .always
            v.leftView = view
            
            v.heightAnchor.constraint(equalToConstant: 40).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let roleLabel: UILabel = UILabel()
        .configure { v in
            v.text = "Role"
            v.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let roleTextfield: UITextField = UITextField()
        .configure { v in
            v.placeholder = "Type role here..."
            v.backgroundColor = .white
            v.layer.cornerRadius = 13
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
            v.leftViewMode = .always
            v.leftView = view
            
            v.heightAnchor.constraint(equalToConstant: 40).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let saveButton: UIButton = UIButton()
        .configure { v in
            v.backgroundColor = .systemGray4
            v.layer.cornerRadius = 10
            v.setTitle("Save", for: .normal)
            v.heightAnchor.constraint(equalToConstant: 30).isActive = true
            v.widthAnchor.constraint(equalToConstant: 70).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
            
            v.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        }
    
    let removeButton: UIButton = UIButton()
        .configure { v in
            v.backgroundColor = .systemGray4
            v.layer.cornerRadius = 10
            v.setTitle("Remove", for: .normal)
            v.heightAnchor.constraint(equalToConstant: 30).isActive = true
            v.widthAnchor.constraint(equalToConstant: 70).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
            
            v.addTarget(self, action: #selector(removeData), for: .touchUpInside)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Manage User"
        view.backgroundColor = .secondarySystemBackground
        // Do any additional setup after loading the view.
        
        setupViews()
        
        if (indexPath != nil) {
            self.saveButton.setTitle("Update", for: .normal)
            fetchData()
        }
    }
    
    func fetchData() {
        presentor?.fetchData(indexPath: indexPath!)
    }
    
    @objc func removeData() {
        presentor?.removeData(index: indexPath!)
        presentor?._dismiss(from: self)
    }
    
    @objc func saveData() {
        if saveButton.titleLabel?.text == "Update" {
            presentor?.updateData(data: UserModel(name: nameTextfield.text!, role: roleTextfield.text!), index: indexPath!)
            presentor?._dismiss(from: self)
        } else {
            presentor?.saveData(name: nameTextfield.text!, role: roleTextfield.text!)
            presentor?._dismiss(from: self)
        }
    }
    
    func setupViews() {
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
        
        view.addSubview(nameTextfield)
        nameTextfield.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        nameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        nameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
        
        view.addSubview(roleLabel)
        roleLabel.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 20).isActive = true
        roleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        roleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
        
        view.addSubview(roleTextfield)
        roleTextfield.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 10).isActive = true
        roleTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        roleTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
        
        
        view.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: roleTextfield.bottomAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
        
        view.addSubview(removeButton)
        removeButton.topAnchor.constraint(equalTo: roleTextfield.bottomAnchor, constant: 20).isActive = true
        removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
    }
}

extension UserDetailsVC: UserDetailsPresenterToViewProtocol {
    func didFetchData(user: UserModel) {
        DispatchQueue.main.async {
            self.nameTextfield.text = user.name
            self.roleTextfield.text = user.role
        }
    }
    
    
}
