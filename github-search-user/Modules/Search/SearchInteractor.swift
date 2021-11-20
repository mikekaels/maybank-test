//
//  SearchInteractor.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation

class SearchInteractor: SearchPresenterToInteractorProtocol {
    
    
    var presenter: SearchInteractorToPresenterProtocol?
    
    func fetchUser(username: String, page: Int, perPage: Int) {
        let session = URLSession.shared
        let url = URL(string: "https://api.github.com/search/users?q=\(username)&per_page=\(perPage)&page=\(page)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            do {
                let result = try JSONDecoder().decode(Response.self, from: data! )
                self.presenter?.didFetchUsers(users: result.users)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
