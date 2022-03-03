//
//  KidsServiceImpl.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 28.02.2022.
//

import UIKit

class KidsServiceImpl {
    
    var user: Person = Person(name: "", age: "")
    var userKids: [Person] = []
}

extension KidsServiceImpl: KidsService {
    
    func kids() -> [Person] {
        return userKids
    }
    
    func currentUser() -> Person {
        return user
    }
    
    func updateUserName(name: String) {
        user.name = name
    }
    
    func updateUserAge(age: String) {
        user.age = age
    }
    
    func updateName(index: Int, name: String) {
        userKids[index].name = name
    }
    
    func updateAge(index: Int, age: String) {
        userKids[index].age = age
    }
    
    func addKid(kid: Person) {
            userKids.append(kid)
    }
    
    func deleteKid(index: Int) {
        userKids.remove(at: index)
    }
    
    func clearAll() {
        user.name = ""
        user.age = ""
        userKids.removeAll()
    }
}



