//
//  UserDetailsProtocol.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

public protocol UserDetailsDelegate {
    
}

protocol UserDetailsViewToPresenterProtocol: AnyObject {
    var view: UserDetailsPresenterToViewProtocol? { get set }
    var interactor: UserDetailsPresenterToInteractorProtocol? { get set }
    var router: UserDetailsPresenterToRouterProtocol? { get set }
    
    func saveData(name: String, role: String)
    func _dismiss(from: UserDetailsVC)
    func fetchData(indexPath: IndexPath)
    func updateData(data: UserModel, index: IndexPath)
    func removeData(index: IndexPath)
}

protocol UserDetailsPresenterToRouterProtocol: AnyObject {
    func createModule() -> UserDetailsVC
    func _dismiss(from: UserDetailsVC)
}

protocol UserDetailsPresenterToViewProtocol: AnyObject {
    func didFetchData(user: UserModel)
}

protocol UserDetailsInteractorToPresenterProtocol: AnyObject {
    func didFetchData(user: UserModel)
}

protocol UserDetailsPresenterToInteractorProtocol: AnyObject {
    var presenter: UserDetailsInteractorToPresenterProtocol? { get set }
    func saveData(name: String, role: String)
    func fetchData(indexPath: IndexPath)
    func updateData(data: UserModel, index: IndexPath)
    func removeData(index: IndexPath)
}
