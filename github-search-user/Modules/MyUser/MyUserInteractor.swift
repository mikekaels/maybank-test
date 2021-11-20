//
//  MyUserInteractor.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UserNotifications

class MyUserInteractor: MyUserPresenterToInteractorProtocol {
    var presenter: MyUserInteractorToPresenterProtocol?
    
    func getUsers() {
        if let data = UserDefaults.standard.value(forKey:"users") as? Data {
            let users = (try? PropertyListDecoder().decode(Array<UserModel>.self, from: data)) ?? []
            presenter?.didFetchUsers(users: users)
        }
    }
}
