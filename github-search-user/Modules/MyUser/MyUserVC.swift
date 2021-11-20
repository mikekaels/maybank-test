//
//  MyUserVC.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class MyUserVC: UIViewController {
    var presentor: MyUserViewToPresenterProtocol?
    public var delegate: MyUserDelegate!
    var users: [UserModel] = [UserModel]()
    
    let tableView: UITableView = UITableView()
        .configure { v in
            v.register(UserTableViewCell.self, forCellReuseIdentifier: "cell")
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let floatingButton: UIButton = UIButton()
        .configure { v in
            v.setImage(UIImage(systemName: "plus"), for: .normal)
            v.contentMode = .scaleAspectFill
            v.backgroundColor = .systemGray4
            v.layer.cornerRadius = 25
            v.tintColor = .white
            v.heightAnchor.constraint(equalToConstant: 50).isActive = true
            v.widthAnchor.constraint(equalToConstant: 50).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
            
            v.addTarget(self, action: #selector(goToUserDetails), for: .touchUpInside)
        }
    
    let stateView: UIView = UIView()
        .configure { v in
            v.tag = 99
            v.backgroundColor = .white
            v.translatesAutoresizingMaskIntoConstraints = false
            v.alpha = 0
        }
    
    let notFound: UIImageView = UIImageView()
        .configure { v in
            v.image = UIImage(named: "no-data-found")
            v.contentMode = .scaleAspectFill
            v.widthAnchor.constraint(equalToConstant: 180).isActive = true
            v.heightAnchor.constraint(equalToConstant: 180).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My User"
        view.backgroundColor = .secondarySystemBackground
        fetchUsers()
        // tableView
        setupTableView()
        // stateView
        view.addSubview(stateView)
        stateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stateView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stateView.addSubview(notFound)
        notFound.centerXAnchor.constraint(equalTo: stateView.centerXAnchor).isActive = true
        notFound.centerYAnchor.constraint(equalTo: stateView.centerYAnchor).isActive = true
        // floating button
        view.addSubview(floatingButton)
        floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    @objc func goToUserDetails() {
        presentor?.goToUserDetail(from: self)
    }
    
    func fetchUsers() {
        presentor?.getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Executed")
        presentor?.getUsers()
    }
    
}

extension MyUserVC: MyUserPresenterToViewProtocol {
    func didFetchUsers(users: [UserModel]) {
        self.users = users
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.users.count == 0 {
                self.stateView.alpha = 1
            } else {
                self.stateView.alpha = 0
            }
        }
    }
}

extension MyUserVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if users.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
            cell.usernameLabel.text = "No User"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
            let user = users[indexPath.row]
            cell.usernameLabel.text = user.name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        presentor?.goToUserDetail(from: self, data: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
