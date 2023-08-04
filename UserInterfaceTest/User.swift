//
//  User.swift
//  UserInterfaceTest
//
//  Created by Vasanth Kumar on 04/08/23.
//

import Foundation
import Combine

class User: ObservableObject {
    @Published var isLoggedIn = false
    @Published var username = ""
    @Published var password = ""
    
    func login() -> Bool {
        guard username == "test" && password == "pass" else {
            return false
        }
        
        password = ""
        isLoggedIn = true
        return true
    }
    
    func logout() {
        username = ""
        isLoggedIn = false
    }
}
