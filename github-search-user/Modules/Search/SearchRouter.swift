//
//  SearchRouter.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

public class SearchRouter: SearchPresenterToRouterProtocol{
    public static let shared = SearchRouter()
    
    func initialize() -> SearchVC {
        return createModule()
    }
    
    func createModule() -> SearchVC {
        let view = SearchVC()
        
        let presenter: SearchViewToPresenterProtocol & SearchInteractorToPresenterProtocol = SearchPresenter()
        
        let interactor: SearchPresenterToInteractorProtocol = SearchInteractor()
        
        let router: SearchPresenterToRouterProtocol = SearchRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func goToMyUser(from: SearchVC) {
        let vc = MyUserRouter().createModule()
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
