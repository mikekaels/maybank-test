//
//  UserDetailsPresenter.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class UserDetailsPresenter: UserDetailsViewToPresenterProtocol {
    
    
    
    
    
    
   
    
    var view: UserDetailsPresenterToViewProtocol?
    var router: UserDetailsPresenterToRouterProtocol?
    var interactor: UserDetailsPresenterToInteractorProtocol?
    
    func saveData(name: String, role: String) {
        interactor?.saveData(name: name, role: role)
    }
    
    func _dismiss(from: UserDetailsVC) {
        router?._dismiss(from: from)
    }
    
    func fetchData(indexPath: IndexPath) {
        interactor?.fetchData(indexPath: indexPath)
    }
    
    func updateData(data: UserModel, index: IndexPath) {
        interactor?.updateData(data: data, index: index)
    }
    
    func removeData(index: IndexPath) {
        interactor?.removeData(index: index)
    }
}

extension UserDetailsPresenter: UserDetailsInteractorToPresenterProtocol {
    func didFetchData(user: UserModel) {
        view?.didFetchData(user: user)
    }
    

}
