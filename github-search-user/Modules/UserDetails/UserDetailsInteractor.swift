//
//  UserDetailsInteractor.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UserNotifications

class UserDetailsInteractor: UserDetailsPresenterToInteractorProtocol {
   
    let defaults = UserDefaults.standard
    
    var presenter: UserDetailsInteractorToPresenterProtocol?
    
    func saveData(name: String, role: String) {
        
        var users: [UserModel] = getUser()
        
        users.append(UserModel(name: name, role: role))
        
        do {
            let encodedData: Data = try PropertyListEncoder().encode(users)
            defaults.set(encodedData, forKey: "users")
            defaults.synchronize()
        } catch {
            print("Error saved data")
        }
    }
    
    func getUser()-> [UserModel] {
        if let data = UserDefaults.standard.value(forKey:"users") as? Data {
            let users = (try? PropertyListDecoder().decode(Array<UserModel>.self, from: data)) ?? []
            return users
        }
    
        return []
    }
    
    func fetchData(indexPath: IndexPath) {
        let users = getUser()
        presenter?.didFetchData(user: users[indexPath.row])
    }
    
    func updateData(data: UserModel, index: IndexPath) {
        
        var users = getUser()
        
        users.remove(at: index.row)

        users.append(data)
        
        do {
            let encodedData: Data = try PropertyListEncoder().encode(users)
            defaults.set(encodedData, forKey: "users")
            defaults.synchronize()
        } catch {
            print("Error saved data")
        }
    }
    
    func removeData(index: IndexPath) {
        var users = getUser()
        
        users.remove(at: index.row)
        
        do {
            let encodedData: Data = try PropertyListEncoder().encode(users)
            defaults.set(encodedData, forKey: "users")
            defaults.synchronize()
        } catch {
            print("Error saved data")
        }
    }
    
}
