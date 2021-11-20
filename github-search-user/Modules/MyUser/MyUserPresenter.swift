//
//  MyUserPresenter.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class MyUserPresenter: MyUserViewToPresenterProtocol {
   
    
    var view: MyUserPresenterToViewProtocol?
    var router: MyUserPresenterToRouterProtocol?
    var interactor: MyUserPresenterToInteractorProtocol?
    
    func goToUserDetail(from: MyUserVC) {
        router?.goToUserDetail(from: from)
    }
    
    func getUsers() {
        interactor?.getUsers()
    }
    
    func goToUserDetail(from: MyUserVC, data: IndexPath) {
        router?.goToUserDetail(from: from, data: data)
    }
}

extension MyUserPresenter: MyUserInteractorToPresenterProtocol {
    func didFetchUsers(users: [UserModel]) {
        view?.didFetchUsers(users: users)
    }
    

}
