//
//  MyUserProtocol.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

public protocol MyUserDelegate {
    
}

protocol MyUserViewToPresenterProtocol: AnyObject {
    var view: MyUserPresenterToViewProtocol? { get set }
    var interactor: MyUserPresenterToInteractorProtocol? { get set }
    var router: MyUserPresenterToRouterProtocol? { get set }
    
    func goToUserDetail(from: MyUserVC)
    func goToUserDetail(from: MyUserVC, data: IndexPath)
    func getUsers()
}

protocol MyUserPresenterToRouterProtocol: AnyObject {
    func createModule() -> MyUserVC
    func goToUserDetail(from: MyUserVC)
    func goToUserDetail(from: MyUserVC, data: IndexPath)
}

protocol MyUserPresenterToViewProtocol: AnyObject {
    func didFetchUsers(users: [UserModel])
}

protocol MyUserInteractorToPresenterProtocol: AnyObject {
    func didFetchUsers(users: [UserModel])
}

protocol MyUserPresenterToInteractorProtocol: AnyObject {
    var presenter: MyUserInteractorToPresenterProtocol? { get set }
    func getUsers()

}
