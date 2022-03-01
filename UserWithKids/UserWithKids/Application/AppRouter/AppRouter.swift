//
//  AppRouter.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import UIKit

class AppRouter {
    
  var kidService: KidsServiceImpl
  var serviceContainer: ServiceContainer
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.kidService = KidsServiceImpl()
        self.serviceContainer = ServiceContainer(kidsService: kidService)
    }
    
    func openInitialViewController() {
        
        let configurator = UserDetailModuleConfigurator(serviceContainer: serviceContainer)
    
        window.rootViewController = configurator.configure()
        window.makeKeyAndVisible()
    }
}
