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
    
    func updateUserName(name: String)
    
    func updateUserAge(age: String)
    
    func updateName(index: Int, name: String)
    
    func updateAge(index: Int, age: String)
    
    func addKid(kid: Person)

    func deleteKid(index: Int)
    
    func clearAll() 
    
}
