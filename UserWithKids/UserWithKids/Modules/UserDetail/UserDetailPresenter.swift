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
    func viewWillAppear() {
        models = kidsServiсe?.kids() ?? []
        user = kidsServiсe?.currentUser()
        view?.reloadUI()
    }
    
    func addUserName(name: String) {
        kidsServiсe?.addUserName(name: name)
        //viewWillAppear()
    }
    
    func addUserAge(age: String) {
        kidsServiсe?.addUserAge(age: age)
       // viewWillAppear()
    }
    
    func currentUser() -> Person {
        return user ?? Person(id: UUID(), name: "", age: "")
    }
    
    func buttonAddTapped() {
        if models.count >= 5 {
            return
        }
        let emptykid = Person(id: UUID(), name: "", age: "")
        kidsServiсe?.updateKidIfCan(kid: emptykid)
       viewWillAppear()
        print("Add")
    }
    
    func buttonDeleteTapped(index: Int) {
        kidsServiсe?.deleteKid(index: index)
        viewWillAppear()
        print("delete")
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
        router?.showAlert()
        viewWillAppear()
        print("clear")
    }
    
}
