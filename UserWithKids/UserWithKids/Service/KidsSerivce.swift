//
//  KidsSerivce.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 28.02.2022.
//

import Foundation

protocol KidsService {
    
    func kids() -> [Kids]
    
    func addKidIfCan()
    
    func updateKidIfCan(kid: Kids)

    func deleteKid()
    
    func clearAll() 
    
}
