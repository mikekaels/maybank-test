//
//  UserDetailsRouter.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

public class UserDetailsRouter: UserDetailsPresenterToRouterProtocol{
    public static let shared = UserDetailsRouter()
    
    func initialize() -> UserDetailsVC {
        return createModule()
    }
    
    func createModule() -> UserDetailsVC {
        let view = UserDetailsVC()
        
        let presenter: UserDetailsViewToPresenterProtocol & UserDetailsInteractorToPresenterProtocol = UserDetailsPresenter()
        
        let interactor: UserDetailsPresenterToInteractorProtocol = UserDetailsInteractor()
        
        let router: UserDetailsPresenterToRouterProtocol = UserDetailsRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func _dismiss(from: UserDetailsVC) {
        from.navigationController?.popViewController(animated: true)
    }
}
