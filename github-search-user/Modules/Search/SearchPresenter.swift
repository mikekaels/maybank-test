//
//  SearchPresenter.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class SearchPresenter: SearchViewToPresenterProtocol {
    
    
    
    var view: SearchPresenterToViewProtocol?
    var router: SearchPresenterToRouterProtocol?
    var interactor: SearchPresenterToInteractorProtocol?
    
    func fetchUsers(username: String, page: Int, perPage: Int) {
        interactor?.fetchUser(username: username, page: page, perPage: perPage)
    }
    
    func goToMyUser(from: SearchVC) {
        router?.goToMyUser(from: from)
    }
    
}

extension SearchPresenter: SearchInteractorToPresenterProtocol {
    func didFetchUsers(users: [User]) {
        view?.didFetchUsers(users: users)
    }
}
