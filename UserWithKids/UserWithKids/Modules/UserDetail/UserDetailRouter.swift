//
//  UserDetailRouter.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import UIKit

class UserDetailRouter {
    
    weak var view: UIViewController?
    var serviceContainer: ServiceContainer
    weak var alert: UIAlertController?
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Внимание!", message: "Вы уверены, что хотите очистить данные?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Очистить данные", style: UIAlertAction.Style.default, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }
}
