//
//  UserInterfaceTestApp.swift
//  UserInterfaceTest
//
//  Created by Vasanth Kumar on 04/08/23.
//

import SwiftUI

@main
struct UserInterfaceTestApp: App {
    var user = User()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
        }
    }
}
