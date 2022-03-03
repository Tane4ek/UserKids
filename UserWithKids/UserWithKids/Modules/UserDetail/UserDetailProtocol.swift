//
//  UserDetailProtocol.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import Foundation
import UIKit

protocol KidsCellDelegate: AnyObject {
    
    func getData (data: String, textIndex: Int, kidIndex: Int)
    
    func deleteKid(index: Int)
}

protocol UserViewDelegate: AnyObject {
    
    func transfer(index: Int)
    
    func getUserData(data: String, index: Int)
}

protocol UserDetailViewInput: AnyObject {
    
    func reloadUI()
}

protocol UserDetailViewOutput: AnyObject {
    
    func viewWillAppear()
    
    func updateUI()
    
    func addUserName(name: String)
    
    func addUserAge(age: String)
    
    func currentUser() -> Person
    
    func buttonAddTapped()
    
    func buttonDeleteTapped(index: Int)
    
    func addKidName(name: String, index: Int)
    
    func addKidAge(age: String, index: Int)
    
    func numberOfItems() -> Int
    
    func modelOfIndex(index: Int) -> Person
    
    func buttonClearTapped()
}
