//
//  SearchVC.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class SearchVC: UIViewController {
    var presentor: SearchViewToPresenterProtocol?
    public var delegate: SearchDelegate!
    var page: Int = 1
    var totalPage: Int = 100
    var perPage: Int = 20
    
    var users: [User] = [User]()
    
    let searchBar: UISearchBar = UISearchBar()
        .configure { v in
            v.placeholder = "Type username..."
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let tableView: UITableView = UITableView()
        .configure { v in
            v.backgroundColor = .secondarySystemBackground
            v.register(UserTableViewCell.self, forCellReuseIdentifier: "cell")
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let myUserButton: UIButton = UIButton()
        .configure { v in
            v.setTitleColor(.label, for: .normal)
            v.setTitle("MY USER", for: .normal)
            v.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            v.layer.cornerRadius = 15
            v.backgroundColor = .systemGray5
            v.widthAnchor.constraint(equalToConstant: 100).isActive = true
            v.heightAnchor.constraint(equalToConstant: 30).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
            v.addTarget(self, action: #selector(goToMyUser), for: .touchUpInside)
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
        title = "Github Users"
        view.backgroundColor = .secondarySystemBackground
        // Do any additional setup after loading the view.
        
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        setupTableView()
        
        view.addSubview(stateView)
        stateView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stateView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stateView.addSubview(notFound)
        notFound.centerXAnchor.constraint(equalTo: stateView.centerXAnchor).isActive = true
        notFound.centerYAnchor.constraint(equalTo: stateView.centerYAnchor).isActive = true
        
        view.addSubview(myUserButton)
        myUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
        myUserButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }

    
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    func fetchUser(username: String, page: Int) {
        presentor?.fetchUsers(username: username, page: page, perPage: self.perPage)
    }
    
    @objc func goToMyUser() {
        presentor?.goToMyUser(from: self)
    }
}

extension SearchVC: SearchPresenterToViewProtocol {
    func didFetchUsers(users: [User]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.users.append(contentsOf: users)
            self.tableView.reloadData()
            if self.users.count == 0 {
                self.stateView.alpha = 1
            } else {
                self.stateView.alpha = 0
            }
        }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        self.users = []
        self.page = 1
        fetchUser(username: searchBar.text!, page: self.page)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
            let user = users[indexPath.row]
            cell.usernameLabel.text = user.login
            cell.githubIDLabel.text = String(user.id)
            cell.image.load(url: URL(string: user.avatarURL)!)
            return cell

    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
//        print("POSITION: ",position)
//        print("POSITION - Content-Size: ",tableView.contentSize.height)
//        print("POSITION - SCROLL VIEW: ",scrollView.frame.size.height)
        if page < totalPage && position > (tableView.contentSize.height - scrollView.frame.size.height) {
            self.tableView.tableFooterView = createSpinnerFooter()
//            print("Fetching User!!!")
            fetchUser(username: searchBar.text!, page: self.page + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
