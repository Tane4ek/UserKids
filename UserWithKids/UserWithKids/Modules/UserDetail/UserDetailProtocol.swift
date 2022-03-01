//
//  UserDetailProtocol.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import Foundation
import UIKit

protocol UserKidsTextFieldDelegate {
    
    func getData (data: String, index: Int)
    
    func dataTransfer(index: Int)
}

protocol UserTextFieldDelegate {
    
    func transfer(index: Int)
}

protocol UserDetailViewInput: AnyObject {
    
    func reloadUI()
}

protocol UserDetailViewOutput: AnyObject {
    
    func viewWillAppear()
    
    func buttonAddTapped()
    
    func buttonDeleteTapped()
    
    func addKidName(name: String, index: Int)
    
    func addKidAge(age: String)
    
    func numberOfItems() -> Int
    
    func modelOfIndex(index: Int) -> Kids
    
    func buttonClearTapped()
}
