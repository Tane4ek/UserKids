//
//  KidsServiceImpl.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 28.02.2022.
//

import UIKit

class KidsServiceImpl {
    
    var userKids: [Kids] = []
}

extension KidsServiceImpl: KidsService {
    
    func kids() -> [Kids] {
        return userKids
    }
    
    func addKidIfCan() {
    }
    
    
    func updateKidIfCan(kid: Kids) {

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
    
    func deleteKid() {
       
    }
    
    func clearAll() {
        userKids = []
    }
}



