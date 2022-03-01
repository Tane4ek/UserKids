//
//  UserDetailConfigurator.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import Foundation

final class UserDetailModuleConfigurator {
    
   var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure() -> UserDetailViewController {
        let presenter = UserDetailPresenter()
        let view = UserDetailViewController(presenter: presenter)
        let router = UserDetailRouter(serviceContainer: serviceContainer)
        
        presenter.view = view
        presenter.router = router
        presenter.kidsServiсe = serviceContainer.kidsService
        router.serviceContainer = serviceContainer
        router.view = view
        
        return view
    }
}

