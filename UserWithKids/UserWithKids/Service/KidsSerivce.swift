//
//  KidsSerivce.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 28.02.2022.
//

import Foundation

protocol KidsService {
    
    func kids() -> [Person]
    
    func currentUser() -> Person
    
    func addUserName(name: String)
    
    func addUserAge(age: String)
    
    func updateName(index: Int, name: String)
    
    func updateAge(index: Int, age: String)
    
    func updateKidIfCan(kid: Person)

    func deleteKid(index: Int)
    
    func clearAll() 
    
}
