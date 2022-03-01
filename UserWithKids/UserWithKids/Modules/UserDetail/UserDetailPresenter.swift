//
//  UserDetailPresenter.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import Foundation

class UserDetailPresenter {
    
    weak var view: UserDetailViewInput?
    var models: [Kids] = []
    var router: UserDetailRouter?
    var kidsServiсe: KidsService?
    
    var kid: Kids?
}

extension UserDetailPresenter: UserDetailViewOutput {
    func viewWillAppear() {
        view?.reloadUI()
    }
    
    func buttonAddTapped() {
        if models.count >= 5 {
            return
        }
        let emptykid = Kids(id: UUID(), name: "", age: "")
        models.append(emptykid)
        viewWillAppear()
        print("Add")
    }
    
    func buttonDeleteTapped() {
        
        print("delete")
    }
    
    func addKidName(name: String) {
        kid?.name = name
        kidsServiсe?.updateKidIfCan(kid: kid ?? Kids(id: UUID(), name: "", age: ""))
        print(kid)
    }
    
    func addKidAge(age: String) {
        kid?.age = age
        kidsServiсe?.updateKidIfCan(kid: kid ?? Kids(id: UUID(), name: "", age: ""))
        print(kid)
    }
    
    func numberOfItems() -> Int {
        return models.count
    }
    
    func modelOfIndex(index: Int) -> Kids {
        let currentModel = models[index]
        return currentModel
    }
    
    func buttonClearTapped() {
        router?.showAlert()
        models = []
       // kidsServiсe?.clearAll()
        viewWillAppear()
        print("clear")
    }
    
}
