//
//  MyUserRouter.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

public class MyUserRouter: MyUserPresenterToRouterProtocol{

    
    public static let shared = MyUserRouter()
    
    func initialize() -> MyUserVC {
        return createModule()
    }
    
    func createModule() -> MyUserVC {
        let view = MyUserVC()
        
        let presenter: MyUserViewToPresenterProtocol & MyUserInteractorToPresenterProtocol = MyUserPresenter()
        
        let interactor: MyUserPresenterToInteractorProtocol = MyUserInteractor()
        
        let router: MyUserPresenterToRouterProtocol = MyUserRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func goToUserDetail(from: MyUserVC) {
        let vc = UserDetailsRouter().createModule()
        from.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToUserDetail(from: MyUserVC, data: IndexPath) {
        let vc = UserDetailsRouter().createModule()
        vc.indexPath = data
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
