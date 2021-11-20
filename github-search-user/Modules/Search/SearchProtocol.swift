//
//  SearchProtocol.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

public protocol SearchDelegate {
    
}

protocol SearchViewToPresenterProtocol: AnyObject {
    var view: SearchPresenterToViewProtocol? { get set }
    var interactor: SearchPresenterToInteractorProtocol? { get set }
    var router: SearchPresenterToRouterProtocol? { get set }
    
    func fetchUsers(username: String, page: Int, perPage: Int)
    func goToMyUser(from: SearchVC)
}

protocol SearchPresenterToRouterProtocol: AnyObject {
    func createModule() -> SearchVC
    func goToMyUser(from: SearchVC)
}

protocol SearchPresenterToViewProtocol: AnyObject {
    func didFetchUsers(users: [User])
}

protocol SearchInteractorToPresenterProtocol: AnyObject {
    func didFetchUsers(users: [User])
}

protocol SearchPresenterToInteractorProtocol: AnyObject {
    var presenter: SearchInteractorToPresenterProtocol? { get set }
    func fetchUser(username: String, page: Int, perPage: Int)

}
