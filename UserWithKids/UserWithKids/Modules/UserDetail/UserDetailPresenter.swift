//
//  UserDetailPresenter.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import Foundation

class UserDetailPresenter {
    
    weak var view: UserDetailViewInput?
    var models: [Person] = []
    var router: UserDetailRouter?
    var kidsServiсe: KidsService?
    
    var user: Person?
}

extension UserDetailPresenter: UserDetailViewOutput {
    func updateUI() {
        models = kidsServiсe?.kids() ?? []
        user = kidsServiсe?.currentUser()
        view?.reloadUI()
    }
    
    func viewWillAppear() {
        view?.reloadUI()
    }
    
    func addUserName(name: String) {
        kidsServiсe?.updateUserName(name: name)
    }
    
    func addUserAge(age: String) {
        kidsServiсe?.updateUserAge(age: age)
    }
    
    func currentUser() -> Person {
        return user ?? Person(name: "", age: "")
    }
    
    func buttonAddTapped() {
        if models.count >= 5 {
            return
        }
        let emptykid = Person(name: "", age: "")
        kidsServiсe?.addKid(kid: emptykid)
        updateUI()
    }
    
    func buttonDeleteTapped(index: Int) {
        kidsServiсe?.deleteKid(index: index)
        updateUI()
    }
    
    func addKidName(name: String, index: Int) {
        kidsServiсe?.updateName(index: index, name: name)
    }
    
    func addKidAge(age: String, index: Int) {
        kidsServiсe?.updateAge(index: index, age: age)
    }
    
    func numberOfItems() -> Int {
        return models.count
    }
    
    func modelOfIndex(index: Int) -> Person {
        let currentModel = models[index]
        return currentModel
    }
    
    func buttonClearTapped() {
        let cleanAll = { [weak self] in
            self?.kidsServiсe?.clearAll()
            self?.updateUI()
        }
        router?.showAlert(actionHandler: cleanAll)
    }
}
