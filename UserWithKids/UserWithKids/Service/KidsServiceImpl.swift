//
//  KidsServiceImpl.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 28.02.2022.
//

import UIKit

class KidsServiceImpl {
    
    var userKids: [Person] = []
}

extension KidsServiceImpl: KidsService {
    
    func kids() -> [Person] {
        return userKids
    }
    
    func addKidIfCan() {
    }
    
    func updateName(index: Int, name: String) {
        userKids[index].name = name
    }
    
    func updateAge(index: Int, age: String) {
        userKids[index].age = age
    }
    
    func updateKidIfCan(kid: Person) {

        var needAppear = true
        for i in 0..<userKids.count {
            if userKids[i].id == kid.id {
                userKids[i] = kid
                needAppear = false
                break
            }
        }
        if needAppear {
            userKids.append(kid)
        }
    }
    
    func deleteKid(index: Int) {
        userKids.remove(at: index)
    }
    
    func clearAll() {
        userKids.removeAll()
    }
}



